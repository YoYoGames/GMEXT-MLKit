#import <Foundation/Foundation.h>
#import <MLKitCommon/MLKitCommon.h>
#import <MLKitTranslate/MLKitTranslate.h>

#import "GMMLKit_ios.h"

@implementation GMMLKit
{
    NSMutableDictionary<NSString *, MLKTranslator *> *_translators;
    NSInteger _nextTranslatorId;
    NSMutableDictionary<NSString *, id> *_downloadObservers;
}

- (instancetype)init
{
    self = [super init];
    if (self)
    {
        _translators = [[NSMutableDictionary alloc] init];
        _downloadObservers = [[NSMutableDictionary alloc] init];
        _nextTranslatorId = 0;
    }
    return self;
}

- (double)mlkit_translation_create:(std::string_view)source
                            target:(std::string_view)target
{
    NSString *sourceTag =
        [[NSString alloc] initWithBytes:source.data()
                                length:source.size()
                              encoding:NSUTF8StringEncoding];

    NSString *targetTag =
        [[NSString alloc] initWithBytes:target.data()
                                length:target.size()
                              encoding:NSUTF8StringEncoding];

    // Validate before building so an unsupported tag returns an invalid (-1)
    // handle instead of constructing a translator that fails later. MLKit has
    // no tag-conversion helper, so check membership in the supported set;
    // mirrors the Android fromLanguageTag null-check.
    NSSet<MLKTranslateLanguage> *supported = MLKTranslateAllLanguages();
    if (![supported containsObject:sourceTag] ||
        ![supported containsObject:targetTag])
    {
        return -1;
    }

    MLKTranslatorOptions *options =
        [[MLKTranslatorOptions alloc] initWithSourceLanguage:sourceTag
                                             targetLanguage:targetTag];

    MLKTranslator *translator = [MLKTranslator translatorWithOptions:options];

    _nextTranslatorId += 1;
    _translators[[self keyForTranslator:_nextTranslatorId]] = translator;
    return (double)_nextTranslatorId;
}

- (void)mlkit_translation_model_is_available:(double)translatorId
                                    callback:(gm::wire::GMFunction)callback
{
    MLKTranslator *translator =
        _translators[[self keyForTranslator:(NSInteger)translatorId]];

    if (!translator)
    {
        callback.call(false, translatorId, "Invalid translator handle.");
        return;
    }

    MLKModelDownloadConditions *conditions =
        [[MLKModelDownloadConditions alloc]
            initWithAllowsCellularAccess:NO
            allowsBackgroundDownloading:YES];

    [translator downloadModelIfNeededWithConditions:conditions
        completion:^(NSError *_Nullable error)
    {
        dispatch_async(dispatch_get_main_queue(), ^{
            if (error)
                callback.call(false, translatorId,
                              error.localizedDescription.UTF8String ?: "");
            else
                callback.call(true, translatorId, "");
        });
    }];
}

- (void)mlkit_translation_translate:(double)translatorId
                               text:(std::string_view)text
                           callback:(gm::wire::GMFunction)callback
{
    MLKTranslator *translator =
        _translators[[self keyForTranslator:(NSInteger)translatorId]];

    if (!translator)
    {
        callback.call(false, translatorId, "", "Invalid translator handle.");
        return;
    }

    NSString *input =
        [[NSString alloc] initWithBytes:text.data()
                                length:text.size()
                              encoding:NSUTF8StringEncoding];

    [translator translateText:input
        completion:^(NSString *_Nullable translatedText,
                     NSError *_Nullable error)
    {
        dispatch_async(dispatch_get_main_queue(), ^{
            if (error || !translatedText)
            {
                callback.call(false, translatorId, "",
                    error.localizedDescription.UTF8String ?: "Translation failed.");
            }
            else
            {
                callback.call(true, translatorId,
                              translatedText.UTF8String ?: "", "");
            }
        });
    }];
}

- (void)mlkit_translation_close:(double)translatorId
{
    [_translators removeObjectForKey:
        [self keyForTranslator:(NSInteger)translatorId]];
}

- (void)mlkit_translation_get_downloaded_list:
    (gm::wire::GMFunction)callback
{
    NSSet<MLKTranslateRemoteModel *> *models =
        [MLKModelManager modelManager].downloadedTranslateModels;

    gm::wire::ArrayStream languages(4096);

    for (MLKTranslateRemoteModel *model in models)
    {
        if (model.language)
            languages.push(model.language.UTF8String ?: "");
    }

    callback.call(true, languages, "");
}

- (void)mlkit_translation_model_delete:(std::string_view)language
                              callback:(gm::wire::GMFunction)callback
{
    NSString *languageString =
        [[NSString alloc] initWithBytes:language.data()
                                length:language.size()
                              encoding:NSUTF8StringEncoding];

    MLKTranslateRemoteModel *model =
        [MLKTranslateRemoteModel translateRemoteModelWithLanguage:languageString];

    [[MLKModelManager modelManager] deleteDownloadedModel:model
        completion:^(NSError *_Nullable error)
    {
        dispatch_async(dispatch_get_main_queue(), ^{
            if (error)
                callback.call(false, languageString.UTF8String ?: "",
                              error.localizedDescription.UTF8String ?: "");
            else
                callback.call(true, languageString.UTF8String ?: "", "");
        });
    }];
}

- (void)mlkit_translation_model_download:(std::string_view)language
                                callback:(gm::wire::GMFunction)callback
{
    NSString *languageString =
        [[NSString alloc] initWithBytes:language.data()
                                length:language.size()
                              encoding:NSUTF8StringEncoding];

    MLKTranslateRemoteModel *model =
        [MLKTranslateRemoteModel translateRemoteModelWithLanguage:languageString];

    MLKModelManager *modelManager = [MLKModelManager modelManager];

    // Already present: report success immediately. downloadModel: otherwise
    // performs an online version-check that can spuriously fail when offline
    // even though the model is downloaded and usable.
    if ([modelManager isModelDownloaded:model])
    {
        dispatch_async(dispatch_get_main_queue(), ^{
            callback.call(true, languageString.UTF8String ?: "", "");
        });
        return;
    }

    MLKModelDownloadConditions *conditions =
        [[MLKModelDownloadConditions alloc]
            initWithAllowsCellularAccess:NO
            allowsBackgroundDownloading:YES];

    NSString *observerKey = [NSString stringWithFormat:@"download:%@",
                                                       languageString];

    [self removeDownloadObserversForKey:observerKey];

    __block id successObserver = nil;
    __block id failureObserver = nil;
    __weak __typeof__(self) weakSelf = self;

    void (^finish)(bool, NSString *) = ^(bool success, NSString *errorText)
    {
        dispatch_async(dispatch_get_main_queue(), ^{
            callback.call(success,
                          languageString.UTF8String ?: "",
                          errorText.UTF8String ?: "");
            [weakSelf removeDownloadObserversForKey:observerKey];
        });
    };

    successObserver =
        [NSNotificationCenter.defaultCenter
            addObserverForName:MLKModelDownloadDidSucceedNotification
                        object:nil
                         queue:nil
                    usingBlock:^(NSNotification *note)
    {
        MLKTranslateRemoteModel *downloadedModel =
            note.userInfo[MLKModelDownloadUserInfoKeyRemoteModel];

        if ([downloadedModel isKindOfClass:[MLKTranslateRemoteModel class]] &&
            [downloadedModel.language isEqualToString:languageString])
        {
            finish(true, @"");
        }
    }];

    failureObserver =
        [NSNotificationCenter.defaultCenter
            addObserverForName:MLKModelDownloadDidFailNotification
                        object:nil
                         queue:nil
                    usingBlock:^(NSNotification *note)
    {
        MLKTranslateRemoteModel *failedModel =
            note.userInfo[MLKModelDownloadUserInfoKeyRemoteModel];

        // Only handle our model. A nil or different model is some other
        // download's failure — ignore it (mirrors the success observer).
        if (![failedModel isKindOfClass:[MLKTranslateRemoteModel class]] ||
            ![failedModel.language isEqualToString:languageString])
        {
            return;
        }

        NSError *error = note.userInfo[MLKModelDownloadUserInfoKeyError];
        finish(false, error.localizedDescription ?: @"Model download failed.");
    }];

    _downloadObservers[observerKey] = @[successObserver, failureObserver];

    [modelManager downloadModel:model conditions:conditions];
}

- (NSString *)keyForTranslator:(NSInteger)translatorId
{
    return [NSString stringWithFormat:@"%ld", (long)translatorId];
}

- (void)removeDownloadObserversForKey:(NSString *)key
{
    NSArray *observers = _downloadObservers[key];
    for (id observer in observers)
        [NSNotificationCenter.defaultCenter removeObserver:observer];

    [_downloadObservers removeObjectForKey:key];
}

- (void)dealloc
{
    for (NSString *key in _downloadObservers.allKeys.copy)
        [self removeDownloadObserversForKey:key];
}

@end

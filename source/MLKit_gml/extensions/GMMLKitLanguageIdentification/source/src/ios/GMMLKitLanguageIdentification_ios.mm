#import <Foundation/Foundation.h>
#import <MLKitLanguageID/MLKitLanguageID.h>

#import "GMMLKitLanguageIdentification_ios.h"

namespace
{
    constexpr int32_t kStatusError = -1;
    constexpr int32_t kStatusUndetermined = 0;
    constexpr int32_t kStatusIdentified = 1;
}

@implementation GMMLKitLanguageIdentification

- (void)mlkit_language_identification_identify:
            (std::string_view)text
                                         callback:
            (gm::wire::GMFunction)callback
{
    NSString *input =
        [[NSString alloc] initWithBytes:text.data()
                                length:text.size()
                              encoding:NSUTF8StringEncoding];

    MLKLanguageIdentification *identifier =
        [MLKLanguageIdentification languageIdentification];

    [identifier identifyLanguageForText:input
        completion:^(NSString *_Nullable languageCode,
                     NSError *_Nullable error)
    {
        dispatch_async(dispatch_get_main_queue(), ^{
            if (error)
            {
                callback.call(
                    kStatusError,
                    "und",
                    error.localizedDescription.UTF8String ?: "");
            }
            else if (!languageCode ||
                     [languageCode isEqualToString:@"und"])
            {
                // Omit the trailing error arg when there is no error; it
                // arrives as undefined on the GML side.
                callback.call(kStatusUndetermined, "und");
            }
            else
            {
                callback.call(
                    kStatusIdentified,
                    languageCode.UTF8String ?: "und");
            }
        });
    }];
}

@end

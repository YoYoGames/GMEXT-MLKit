
#import "MLKit.h"

const int EVENT_OTHER_SOCIAL = 70;
extern int CreateDsMap( int _num, ... );
extern void CreateAsynEventWithDSMap(int dsmapindex, int event_index);
// extern UIViewController *g_controller;
// extern UIView *g_glView;
extern int g_DeviceWidth;
extern int g_DeviceHeight;

extern "C" void dsMapClear(int _dsMap );
extern "C" int dsMapCreate();
extern "C" void dsMapAddInt(int _dsMap, char* _key, int _value);
extern "C" void dsMapAddDouble(int _dsMap, char* _key, double _value);
extern "C" void dsMapAddString(int _dsMap, char* _key, char* _value);

extern "C" int dsListCreate();
extern "C" void dsListAddInt(int _dsList, int _value);
extern "C" void dsListAddString(int _dsList, char* _value);
extern "C" const char* dsListGetValueString(int _dsList, int _listIdx);
extern "C" double dsListGetValueDouble(int _dsList, int _listIdx);
extern "C" int dsListGetSize(int _dsList);

extern "C" const char* extOptGetString(char* _ext, char* _opt);

extern "C" void createSocialAsyncEventWithDSMap(int dsmapindex);
@implementation MLKit

-(id) init
{
    if (self = [super init])
    {

        return self;
    }
}

-(void) Init
{
    Map_Translator = [[NSMutableDictionary alloc] init];
	ind= 0;
}		
	-(double) mlkit_translation_create:(NSString*) source target:(NSString*) target
	{
		MLKTranslatorOptions *options = [[MLKTranslatorOptions alloc] initWithSourceLanguage:source targetLanguage:target];
        //MLKTranslator *mTranslator = [MLKTranslator translatorwithOptions:options];
        MLKTranslator *mTranslator = [MLKTranslator translatorWithOptions:options];
		
		ind ++;
		[Map_Translator setValue:mTranslator forKey:[NSString stringWithFormat:@"%d",ind]];
		
		return ind;
	}
	
	-(void) mlkit_translation_model_is_available:(double) _ind
	{
		MLKModelDownloadConditions *conditions = [[MLKModelDownloadConditions alloc] initWithAllowsCellularAccess:NO allowsBackgroundDownloading:YES];
        MLKTranslator *mTranslator = [Map_Translator valueForKey:[NSString stringWithFormat:@"%d", (int) _ind]];
		[mTranslator downloadModelIfNeededWithConditions:conditions completion:^(NSError *_Nullable error)
		{
			
			int dsMapIndex = dsMapCreate();
			dsMapAddString(dsMapIndex,(char*)"type",(char*)"mlkit_translation_model_is_available");
			dsMapAddDouble(dsMapIndex,(char*)"translator",_ind);
			
			if (error != nil)
            {
                dsMapAddDouble(dsMapIndex,(char*)"success",0.0);
                dsMapAddString(dsMapIndex,(char*)"error",(char*)[error.description UTF8String]);
            }
			else
				dsMapAddDouble(dsMapIndex,(char*)"success",1.0);
			
			CreateAsynEventWithDSMap(dsMapIndex,EVENT_OTHER_SOCIAL);
			
		}];
	}
	
	-(void) mlkit_translation_translate:(double) _ind text: (NSString*) text
	{
        MLKTranslator *mTranslator = [Map_Translator valueForKey:[NSString stringWithFormat:@"%d", (int) _ind]];
		[mTranslator translateText:text completion:^(NSString *_Nullable translatedText,NSError *_Nullable error)
		{
			
			int dsMapIndex = dsMapCreate();
			dsMapAddString(dsMapIndex,(char*)"type",(char*)"mlkit_translation_translate");
			dsMapAddDouble(dsMapIndex,(char*)"translator",_ind);
			
			if (error != nil || translatedText == nil) 
			{
				dsMapAddDouble(dsMapIndex,(char*)"success",0.0);
                dsMapAddString(dsMapIndex,(char*)"error",(char*)[error.description UTF8String]);

			}
			else
			{
				dsMapAddDouble(dsMapIndex,(char*)"success",1.0);
				dsMapAddString(dsMapIndex,(char*)"text",(char*)[translatedText UTF8String]);
			}
			
			CreateAsynEventWithDSMap(dsMapIndex,EVENT_OTHER_SOCIAL);
		}];
	}
	
	-(void) mlkit_translation_close:(double) _ind
	{
        [Map_Translator removeObjectForKey:[NSString stringWithFormat:@"%d", (int) _ind]];
	}


	-(void) mlkit_translation_get_downloaded_list
	{
        
        NSSet<MLKTranslateRemoteModel*> *localModels = [MLKModelManager modelManager].downloadedTranslateModels;
        
        NSString *array = @"";
        for(MLKTranslateRemoteModel* model in localModels) {
            
            array = [NSString stringWithFormat:@"%@\"%@\",",array,model.language];
        }
        array = [NSString stringWithFormat:@"[%@]",array];
        
        int dsMapIndex = dsMapCreate();
        dsMapAddString(dsMapIndex,(char*)"type",(char*)"mlkit_translation_get_downloaded_list");
        dsMapAddString(dsMapIndex,(char*)"list",(char*) [array UTF8String]);
        dsMapAddDouble(dsMapIndex,(char*)"success",1.0);
        
        CreateAsynEventWithDSMap(dsMapIndex,EVENT_OTHER_SOCIAL);
	}


	-(void) mlkit_translation_model_delete:(NSString*) language
    {
        
        MLKTranslateRemoteModel *germanModel =
        [MLKTranslateRemoteModel translateRemoteModelWithLanguage:MLKTranslateLanguageGerman];
        [[MLKModelManager modelManager] deleteDownloadedModel:germanModel completion:^(NSError * _Nullable error)
                         {
                            int dsMapIndex = dsMapCreate();
                            dsMapAddString(dsMapIndex,(char*)"type",(char*)"mlkit_translation_model_delete");
                            dsMapAddString(dsMapIndex,(char*)"language",(char*)[language UTF8String]);
                            
                            if (error != nil)
                            {
                                
                                dsMapAddDouble(dsMapIndex,(char*)"success",1.0);
                                dsMapAddString(dsMapIndex,(char*)"error",(char*)[error.description UTF8String]);

                            }
                            else
                            {
                                dsMapAddDouble(dsMapIndex,(char*)"success",0.0);
                            }
                            
                            CreateAsynEventWithDSMap(dsMapIndex,EVENT_OTHER_SOCIAL);
                }];
    }


	-(void) mlkit_translation_model_download:(NSString*) language
	{

        MLKModelDownloadConditions *conditions =
            [[MLKModelDownloadConditions alloc] initWithAllowsCellularAccess:NO allowsBackgroundDownloading:YES];
        MLKTranslateRemoteModel *frenchModel = [MLKTranslateRemoteModel translateRemoteModelWithLanguage:language];
        
        self->download_process = [[MLKModelManager modelManager] downloadModel:frenchModel
        conditions:conditions];
        
        [NSNotificationCenter.defaultCenter
         addObserverForName:MLKModelDownloadDidSucceedNotification
         object:nil
         queue:nil
         usingBlock:^(NSNotification * _Nonnull note) {
             if (note.userInfo == nil)
             {
                 return;
             }

             MLKTranslateRemoteModel *model = note.userInfo[MLKModelDownloadUserInfoKeyRemoteModel];
             if ([model isKindOfClass:[MLKTranslateRemoteModel class]]
                 && [model.language isEqualToString:language])
             {
                 // The model was downloaded and is available on the device
                 
                 
                 int dsMapIndex = dsMapCreate();
                 dsMapAddString(dsMapIndex,(char*)"type",(char*)"mlkit_translation_model_download");
                 dsMapAddString(dsMapIndex,(char*)"language",(char*)[language UTF8String]);
                dsMapAddDouble(dsMapIndex,(char*)"success",1.0);
                 CreateAsynEventWithDSMap(dsMapIndex,EVENT_OTHER_SOCIAL);
                 
                 
             }
         }];

        [NSNotificationCenter.defaultCenter
         addObserverForName:MLKModelDownloadDidFailNotification
         object:nil
         queue:nil
         usingBlock:^(NSNotification * _Nonnull note)
         {
             if (note.userInfo == nil)
             {
                 return;
             }

             NSError *error = note.userInfo[MLKModelDownloadUserInfoKeyError];
            
            int dsMapIndex = dsMapCreate();
            dsMapAddString(dsMapIndex,(char*)"type",(char*)"mlkit_translation_model_download");
            dsMapAddString(dsMapIndex,(char*)"language",(char*)[language UTF8String]);
            dsMapAddString(dsMapIndex,(char*)"error",(char*)[error.description UTF8String]);
           dsMapAddDouble(dsMapIndex,(char*)"success",0.0);
            CreateAsynEventWithDSMap(dsMapIndex,EVENT_OTHER_SOCIAL);
         }];
	}
	
@end


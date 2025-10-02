
#import "MLKit_Language_Identification.h"

extern int CreateDsMap( int _num, ... );

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
extern "C" const char* extGetVersion(char* _ext);

extern "C" void createSocialAsyncEventWithDSMap(int dsmapindex);


@implementation MLKit_Language_Identification

- (instancetype)init {
    return [super init];
}

-(void) mlkit_language_identification_identify:(NSString *)text {
    
    NSString *const undetermined = @"und";
    
    MLKLanguageIdentification *languageId = [MLKLanguageIdentification languageIdentification];

    [languageId identifyLanguageForText:text
                              completion:^(NSString * _Nullable languageCode,
                                           NSError * _Nullable error) {
        int dsMapIndex = dsMapCreate();
		
		dsMapAddString(dsMapIndex, (char*)"type", (char*)"mlkit_language_identification_identify");
        if (error != nil) {
            dsMapAddString(dsMapIndex, (char*)"error", (char*)[error.localizedDescription UTF8String]);
            dsMapAddDouble(dsMapIndex, (char*)"success", -1.0);
        } else if ([languageCode isEqualToString:undetermined]) {
            dsMapAddString(dsMapIndex, (char*)"language_code", (char*)[undetermined UTF8String]);
            dsMapAddDouble(dsMapIndex, (char*)"success", 0.0);
        } else {
            dsMapAddString(dsMapIndex, (char*)"language_code", (char*)[languageCode UTF8String]);
            dsMapAddDouble(dsMapIndex, (char*)"success", 1.0);
        }

        createSocialAsyncEventWithDSMap(dsMapIndex);
    }];
}

@end

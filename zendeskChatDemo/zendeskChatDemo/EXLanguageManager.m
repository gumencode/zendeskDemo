//
//  FTLocalizedHelper.h
//  APPLE iOS
//
//  Created by APPLE  on 2021/05/26.
//  Copyright © 2018 APPLE. All rights reserved.
//

#import "EXLanguageManager.h"

static NSBundle *_bundle;

//static NSString *const kUserLanguage = @"kUserLanguage";

@implementation EXLanguageManager

+ (instancetype)shared {
    static EXLanguageManager *helper;
    static dispatch_once_t onceToken;
    dispatch_once(&onceToken, ^{
        helper = [[self alloc] init];
    });
    return helper;
}

- (instancetype)init {
    
    if (self = [super init]) {
        
        if (!_bundle) {
            NSUserDefaults *defaults = [NSUserDefaults standardUserDefaults];
            
            NSString *userLanguage = [defaults valueForKey:@"kSave_UserLanguage"];
            
//            NSString *localeLanguageCode = [[NSLocale currentLocale] objectForKey:NSLocaleLanguageCode];
//            NSLog(@"localeLanguageCode===%@",localeLanguageCode);
            
            //用户未手动设置过语言
            if (userLanguage.length == 0) {
                userLanguage = @"en";
                [[NSUserDefaults standardUserDefaults] setValue:userLanguage forKey:@"kSave_UserLanguage"];
                [[NSUserDefaults standardUserDefaults] synchronize];
            }else{
                NSArray *languages = [[NSBundle mainBundle] preferredLocalizations];
                
                NSString *systemLanguage = languages.firstObject;
            
                userLanguage = systemLanguage;
            }
            
//            NSLog(@"infoDictionary===%@",[NSBundle mainBundle].infoDictionary);
//            NSDictionary *dic = [NSBundle mainBundle].localizedInfoDictionary;
//            NSLog(@"CFBundleDisplayName====%@,NSPhotoLibraryAddUsageDescription===%@",dic[@"CFBundleDisplayName"],dic[@"NSPhotoLibraryAddUsageDescription"]);
//            NSArray *localizations = [[NSBundle mainBundle] localizations];
//            NSLog(@"localizations====%@",localizations);
//            NSLog(@"developmentLocalization====%@",[[NSBundle mainBundle] developmentLocalization]);
            if ([userLanguage isEqualToString:@"zh-HK"] || [userLanguage isEqualToString:@"zh-TW"]) {
                userLanguage = @"zh-Hant";
            }
            
            NSString *path = [[NSBundle mainBundle] pathForResource:userLanguage ofType:@"lproj"];
            
            _bundle = [NSBundle bundleWithPath:path];
            self.currentLanguage = userLanguage;
            
            
        }
        
    }
    return self;
}

- (NSBundle *)bundle {
    return _bundle;
}
- (void)updateLocalLanguage{
    EXLanguageItem *currentLanguageItem = EXLanguageManager.supportLanguageItems.firstObject;
    NSMutableArray<NSString *> *preferredLanguages = [[NSLocale preferredLanguages] mutableCopy];
    [preferredLanguages replaceObjectAtIndex:0 withObject:self.currentLanguage?self.currentLanguage:currentLanguageItem.languageKey];
    [NSLocale setValue:preferredLanguages forKey:@"preferredLanguages"];
}
- (void)updateSystemLanguage{
    [[NSUserDefaults standardUserDefaults] setValue:@[self.currentLanguage?self.currentLanguage:@"en"] forKey:@"AppleLanguages"];
    [[NSUserDefaults standardUserDefaults] synchronize];
}
- (void)setUserLanguage:(NSString *)language {
   
    NSUserDefaults *defaults = [NSUserDefaults standardUserDefaults];
    
    NSString *path = [[NSBundle mainBundle] pathForResource:language ofType:@"lproj"];
    
    _bundle = [NSBundle bundleWithPath:path];
    self.currentLanguage = language;
    [defaults setValue:language forKey:@"kSave_UserLanguage"];
    [defaults synchronize];
    
}
- (void)setCurrentLanguage:(NSString *)currentLanguage{
    _currentLanguage = currentLanguage;
    NSArray *items = EXLanguageManager.supportLanguageItems;
    for (EXLanguageItem *item in items) {
        if ([item.languageKey isEqualToString:_currentLanguage]) {
            self.currentLanguageItem = item;
            self.paramValue = item.paramValue;
            break;
        }
    }
//    其他语言则默认为英文
    if (self.currentLanguageItem == nil) {
        self.currentLanguageItem = EXLanguageManager.supportLanguageItems.firstObject;
        self.paramValue = self.currentLanguageItem.paramValue;
        _currentLanguage = self.currentLanguageItem.languageKey;
    }
    [self updateLocalLanguage];
    [self updateSystemLanguage];

}
- (NSString *)stringWithKeyFormat:(NSString *)key, ...{
    va_list args;
    va_start(args, key);
    key = [[NSString alloc] initWithFormat:[self stringWithKey:key] arguments:args];
    va_end(args);
    return key;
}
- (NSString *)stringWithKey:(NSString *)key {
    if (_bundle) {
        return [_bundle localizedStringForKey:key value:nil table:@"Localizable"];
    }else {
        return NSLocalizedString(key, nil);
    }
}
- (BOOL)isChinese{
    return [self.currentLanguageItem.languageKey hasPrefix:@"zh"];
}
- (BOOL)isEnglish{
    return [self.currentLanguageItem.languageKey isEqualToString:@"en"];
}
+ (NSArray<EXLanguageItem *> *)supportLanguageItems{
    return @[[EXLanguageItem itemWithName:@"English" key:@"en"],
             [EXLanguageItem itemWithName:@"繁体中文" paramValue:@"tc" key:@"zh-Hant" localDescription:@"繁体中文"],
             [EXLanguageItem itemWithName:@"日本語" key:@"ja"],
             ];
}
//+ (NSArray<EXLanguageItem *> *)supportLanguageItems{
////    这里的几个字不需要国际化
//    return @[[EXLanguageItem itemWithName:@"English" key:@"en"],[EXLanguageItem itemWithName:@"中文" paramValue:@"zh" key:@"zh-Hans" localDescription:@"简体中文"],[EXLanguageItem itemWithName:@"中文繁体" paramValue:@"zh" key:@"zh-Hant" localDescription:@"简体中文"],[EXLanguageItem itemWithName:@"한글" key:@"kor"]
//             ];
//}
@end

//
//  FTLocalizedHelper.h
//  APPLE iOS
//
//  Created by APPLE  on 2021/05/26.
//  Copyright © 2018 APPLE. All rights reserved.
//


#import <Foundation/Foundation.h>
#import "EXLanguageItem.h"

#define EXLocalizedString(key) [[EXLanguageManager shared] stringWithKey:key]
#define EXLocalizedFormat(key,...) [[EXLanguageManager shared] stringWithKeyFormat:key,__VA_ARGS__]
#define EXLanguageInstance EXLanguageManager.shared

@interface EXLanguageManager : NSObject

+ (instancetype)shared;


/**
 当前语言的key值，简体中文：zh-Hans
 */
@property (nonatomic, copy) NSString *currentLanguage;
/**
 当前语言的服务器参数值，简体中文：zh
 */
@property (nonatomic, copy) NSString *paramValue;


- (void)setUserLanguage:(NSString *)language;

- (NSString *)stringWithKey:(NSString *)key;
- (NSString *)stringWithKeyFormat:(NSString *)key,... NS_FORMAT_FUNCTION(1,2);

@property (nonatomic, strong) EXLanguageItem *currentLanguageItem;
//当前语言是否为中文
- (BOOL)isChinese;
//当前语言是否为英文
- (BOOL)isEnglish;

+ (NSArray<EXLanguageItem *> *)supportLanguageItems;

@end

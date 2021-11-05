//
//  EXLanguageItem.h
//  exchangenew
//
//  Created by Apple on 2021/05/21.
//  Copyright © 2021 Apple. All rights reserved.
//

#import <Foundation/Foundation.h>

@interface EXLanguageItem : NSObject

@property (nonatomic, copy) NSString *localName;
@property (nonatomic, copy) NSString *languageKey;
@property (nonatomic, copy) NSString *localDescription;

/**
 服务器该语言的值
 */
@property (nonatomic, copy) NSString *paramValue;

+ (instancetype)itemWithName:(NSString *)name key:(NSString *)key;

+ (instancetype)itemWithName:(NSString *)name paramValue:(NSString *)value key:(NSString *)key localDescription:(NSString *)localDescription;

@end

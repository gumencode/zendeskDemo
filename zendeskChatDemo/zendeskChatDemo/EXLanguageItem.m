//
//  EXLanguageItem.h
//  exchangenew
//
//  Created by Apple on 2021/05/21.
//  Copyright © 2021 Apple. All rights reserved.
//

#import "EXLanguageItem.h"

@implementation EXLanguageItem

+ (instancetype)itemWithName:(NSString *)name key:(NSString *)key{
    return [self itemWithName:name paramValue:key key:key localDescription:name];
    
}
+ (instancetype)itemWithName:(NSString *)name paramValue:(NSString *)paramValue key:(NSString *)key localDescription:(NSString *)localDescription{
    EXLanguageItem *item = [[self alloc] init];
    item.languageKey = key;
    item.localName = name;
    item.localDescription = localDescription;
    item.paramValue = paramValue;
    return item;
}
@end

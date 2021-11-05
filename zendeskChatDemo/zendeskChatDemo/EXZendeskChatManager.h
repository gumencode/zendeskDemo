//
//  EXZendeskChatManager.h
//  exchangenew
//
//  Created by macbook on 2021/8/6.
//

#import <Foundation/Foundation.h>

#import <MessagingSDK/MessagingSDK.h>
#import <MessagingAPI/MessagingAPI.h>
#import <CommonUISDK/CommonUISDK.h>
#import <ChatSDK/ChatSDK.h>
#import <ChatProvidersSDK/ChatProvidersSDK.h>


#define EXZendeskChatManagerM [EXZendeskChatManager sharedManager]

NS_ASSUME_NONNULL_BEGIN

@interface EXZendeskChatManager : NSObject

+ (instancetype)sharedManager;
- (void)startChat:(UIViewController *)vc;

@end

NS_ASSUME_NONNULL_END

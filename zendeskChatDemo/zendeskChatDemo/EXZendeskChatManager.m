//
//  EXZendeskChatManager.m
//  exchangenew
//
//  Created by macbook on 2021/8/6.
//

#import "EXZendeskChatManager.h"

#define kAccounntKey @"cZF1Niqp6npYBPM3BuRY9V47uHEQXOlh"

@implementation EXZendeskChatManager

+ (instancetype)sharedManager {
    static EXZendeskChatManager *sharedManeger = nil;
//    static dispatch_once_t onceToken;
//    dispatch_once(&onceToken, ^{
        sharedManeger = [[self alloc] init];
//    });
    return sharedManeger;
}

- (instancetype)init
{
    self = [super init];
    if (self) {
        [ZDKChat initializeWithAccountKey:kAccounntKey queue:dispatch_get_main_queue()];
    }
    return self;
}

+ (ZDKMessagingConfiguration *)messagingConfiguration{
    ZDKMessagingConfiguration *config = [ZDKMessagingConfiguration new];
    config.name = @"Chat Bot";
    config.isMultilineResponseOptionsEnabled = YES;
    return config;
}

+ (ZDKChatConfiguration *)chatConfiguration{
    ZDKChatFormConfiguration *formConfiguration = [[ZDKChatFormConfiguration alloc] initWithName:ZDKFormFieldStatusRequired email:ZDKFormFieldStatusOptional phoneNumber:ZDKFormFieldStatusHidden department:ZDKFormFieldStatusRequired];
    ZDKChatConfiguration *config = [ZDKChatConfiguration new];
    config.preChatFormConfiguration = formConfiguration;
    config.isAgentAvailabilityEnabled = NO;
    config.isPreChatFormEnabled = NO;
    return config;
}

+ (ZDKChatAPIConfiguration *)chatAPIConfiguration{
    ZDKChatAPIConfiguration *config = [ZDKChatAPIConfiguration new];
//    ZDKVisitorInfo * visitorInfo = [[ZDKVisitorInfo alloc] initWithName:EXUserManagerM.currentUser.user_base.userId email:EXUserManagerM.currentUser.item.user_email phoneNumber:@""];
    ZDKVisitorInfo * visitorInfo = [[ZDKVisitorInfo alloc] initWithName:@"66" email:@"" phoneNumber:@""];
    config.visitorInfo = visitorInfo;
    config.tags = @[@"iOS", @"chat_v2"];
    return config;
}

- (void)startChat:(UIViewController *)vc{
    [[ZDKChat instance] setConfiguration: [EXZendeskChatManager chatAPIConfiguration]];
    NSError *error = nil;
    NSArray *engines = @[
         (id <ZDKEngine>) [ZDKChatEngine engineAndReturnError: &error]
     ];
//    [NSBundle registerBundle];
//    NSArray<id<ZDKConfiguration>> *configs = @[[EXZendeskChatManager messagingConfiguration], [EXZendeskChatManager chatConfiguration]];
    NSArray<id<ZDKConfiguration>> *configs = @[[EXZendeskChatManager chatConfiguration]];

    UIViewController *viewController = [[ZDKMessaging instance] buildUIWithEngines:engines configs:configs error:&error];
    UINavigationController *nav = [[UINavigationController alloc] initWithRootViewController:viewController];
    [vc presentViewController:nav animated:YES completion:^{
            
    }];
//    [vc.navigationController pushViewController:viewController animated:YES];
}


@end

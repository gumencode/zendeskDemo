//
//  ViewController.m
//  zendeskChatDemo
//
//  Created by mac on 2021/11/4.
//

#import "ViewController.h"
#import "EXLanguageItem.h"
#import "EXLanguageManager.h"
#import "EXZendeskChatManager.h"
#import "FTPopOverMenu.h"

@interface ViewController ()

@property (nonatomic, strong) UIButton *btnChangeLanguage;
@property (nonatomic, strong) UIButton *btnStartChat;

@end

@implementation ViewController

- (void)viewDidLoad {
    [super viewDidLoad];
    [self setUI];
}

- (void)setUI{
    
    self.btnChangeLanguage = [UIButton buttonWithType:UIButtonTypeCustom];
    [self.btnChangeLanguage setTitle:EXLocalizedString(@"切換語言") forState:UIControlStateNormal];
    self.btnChangeLanguage.frame = CGRectMake(20, 300, 150, 100);
    [self.btnChangeLanguage setTitleColor:[UIColor blackColor] forState:UIControlStateNormal];
    self.btnChangeLanguage.titleLabel.font = [UIFont boldSystemFontOfSize:14.0];
    self.btnChangeLanguage.layer.borderWidth = 1;
    self.btnChangeLanguage.layer.borderColor = [UIColor blackColor].CGColor;
    self.btnChangeLanguage.layer.cornerRadius = 5;
    [self.btnChangeLanguage addTarget:self action:@selector(btnChangeLanguageClick) forControlEvents:UIControlEventTouchUpInside];
    [self.view addSubview:self.btnChangeLanguage];
    
    self.btnStartChat = [UIButton buttonWithType:UIButtonTypeCustom];
    [self.btnStartChat setTitle:EXLocalizedString(@"開始聊天") forState:UIControlStateNormal];
    self.btnStartChat.frame = CGRectMake(self.view.frame.size.width - 170, 300, 150, 100);
    [self.btnStartChat setTitleColor:[UIColor blackColor] forState:UIControlStateNormal];
    self.btnStartChat.titleLabel.font = [UIFont boldSystemFontOfSize:14.0];
    self.btnStartChat.layer.borderWidth = 1;
    self.btnStartChat.layer.borderColor = [UIColor blackColor].CGColor;
    self.btnStartChat.layer.cornerRadius = 5;
    [self.btnStartChat addTarget:self action:@selector(btnStartChatClick) forControlEvents:UIControlEventTouchUpInside];
    [self.view addSubview:self.btnStartChat];
    
}

- (void)reloadBtnTitle{
    [self.btnChangeLanguage setTitle:EXLocalizedString(@"切換語言") forState:UIControlStateNormal];
    [self.btnStartChat setTitle:EXLocalizedString(@"開始聊天") forState:UIControlStateNormal];
}

- (void)btnChangeLanguageClick{
    [self showMoreChooseView];
}

- (void)btnStartChatClick{
    [EXZendeskChatManagerM startChat:self];
}

- (void)showMoreChooseView{
    
    NSArray *array = [EXLanguageManager supportLanguageItems];
    FTPopOverMenuConfiguration *config = [self getPopViewConfig];
    config.hideArrow = NO;
    config.menuIconMargin = 13;
    config.menuTextMargin = 6;
    config.textAlignment = NSTextAlignmentLeft;
    config.menuWidth = 150;
    
    __block NSMutableArray *menusModel = [[NSMutableArray alloc] init];
    [array enumerateObjectsUsingBlock:^(id  _Nonnull obj, NSUInteger idx, BOOL * _Nonnull stop) {
        NSString *title = [array[idx] localName];
        FTPopOverMenuModel *model = [[FTPopOverMenuModel alloc] initWithTitle:title image:nil selected:NO];
        [menusModel addObject:model];
    }];
    

    [FTPopOverMenu showForSender:self.btnChangeLanguage withMenuArray:menusModel doneBlock:^(NSInteger selectedIndex) {
        EXLanguageItem *item = array[selectedIndex];
        [[NSUserDefaults standardUserDefaults] setValue:item.languageKey forKey:@"kSave_UserLanguage"];
        [[NSUserDefaults standardUserDefaults] synchronize];
        [EXLanguageInstance setUserLanguage:item.languageKey];
        [self reloadBtnTitle];
    } dismissBlock:^{
        
    }];
}

- (FTPopOverMenuConfiguration *)getPopViewConfig{
    FTPopOverMenuConfiguration *config = [FTPopOverMenuConfiguration FTConfiguration];
    config.allowRoundedArrow = YES;
    config.hideArrow = YES;
    config.textColor = [UIColor blackColor];
    config.selectedTextColor = [UIColor blackColor];
    config.menuBackColor = [UIColor lightGrayColor];
    config.tintColor = [UIColor lightGrayColor];
    config.selectedCellBackgroundColor = [UIColor lightGrayColor];
    config.textFont = [UIFont boldSystemFontOfSize:12];
    config.menuHeaderHeight = 10;
    config.menuFooterHeight = 10 ;
    config.shadowColor = [UIColor blackColor];
    config.shadowOffsetX = 0;
    config.shadowOffsetY = 4;
    config.menuCornerRadius = 8.0;
    return config;
}


@end

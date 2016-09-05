//
//  LaunchAd.m
//  CodeSnippets
//
//  Created by UGOMEDIA on 16/8/26.
//  Copyright © 2016年 GeekRRK. All rights reserved.
//

/*
 Refer to: http://www.cocoachina.com/ios/20160614/16671.html
           http://www.cocoachina.com/ios/20160628/16828.html
 */

#import "LaunchAd.h"
#import "Utils.h"
#import "AFInterface.h"

#define AD_IMG_NAME @"NXHAdImg.jpg"
#define AD_INFO     @"NXHAdInfo"

@interface LaunchAd ()

@property (strong, nonatomic) UIWindow *window;
@property (assign, nonatomic) int countdown;
@property (strong, nonatomic) UIButton *countdownBtn;

@property (copy, nonatomic) NSDictionary *oldAdDict;
@property (copy, nonatomic) NSDictionary *curAdDict;
@property (strong, nonatomic) UIImage *img;

@end

@implementation LaunchAd

+ (void)load {
    [self shareInstance];
}

+ (instancetype)shareInstance {
    static id instance;
    static dispatch_once_t onceToken;
    dispatch_once(&onceToken, ^{
        instance = [[self alloc] init];
    });
    return instance;
}

- (instancetype)init {
    self = [super init];
    if (self) {
        [[NSNotificationCenter defaultCenter] addObserverForName:UIApplicationDidFinishLaunchingNotification object:nil queue:nil usingBlock:^(NSNotification *note) {
            [self checkNewAd];
        }];
    }
    return self;
}

- (void)checkNewAd {
    _oldAdDict = [Utils readDictBy:AD_INFO];
    if (_oldAdDict != nil && _oldAdDict.count > 0) {
        [self show];
    }
    
    NSString *APIAddr = SERVERADDR;
    NSDictionary *param = @{@"version":APIAddr};
    NSArray *orderedKeyArr = @[@"version"];
    [AFInterface request:APIAddr param:param orderedKeyArr:orderedKeyArr success:^(NSDictionary *responseObject) {
        if ([responseObject[@"errcode"] intValue] == 0) {
            _curAdDict = responseObject[@"info"];
            
            if (_curAdDict == nil || _curAdDict.count == 0) {
                [Utils deleteFileByName:AD_INFO];
            } else {
                [self asyncDownloadAdImageWithUrl:_curAdDict[@"imgurl"] imageName:AD_IMG_NAME];
            }
        } else {
            [Utils showMessage:responseObject[@"msg"]];
        }
    } failure:^(NSError *error) {
        [Utils showMessage:error.localizedDescription];
    }];
}

- (void)show {
    UIWindow *window = [[UIWindow alloc] initWithFrame:[UIScreen mainScreen].bounds];
    window.rootViewController = [UIViewController new];
    window.rootViewController.view.backgroundColor = [UIColor clearColor];
    window.rootViewController.view.userInteractionEnabled = NO;
    [self setupSubviews:window];
    window.windowLevel = UIWindowLevelStatusBar + 1;
    window.hidden = NO;
    window.alpha = 1;
    self.window = window;
}

- (void)clickAd {
//    UIViewController* rootVC = [[UIApplication sharedApplication].delegate window].rootViewController;
//    NXHWebVC *webVC = [[NXHWebVC alloc] init];
//    webVC.isFromAd = YES;
//    webVC.adDict = _oldAdDict;
//    [webVC setHidesBottomBarWhenPushed:YES];
//    
//    if ([rootVC isKindOfClass:[UITabBarController class]]) {
//        [APPDELEGATE.tabBarVC.viewControllers[0] pushViewController:webVC animated:YES];
//    } else {
//        [APPDELEGATE.guideNavVC pushViewController:webVC animated:YES];
//    }
    
    [self hide];
}

- (void)clickJumpBtn {
    [self hide];
}

- (void)hide {
    [UIView animateWithDuration:0.3 animations:^{
        self.window.alpha = 0;
    } completion:^(BOOL finished) {
        [self.window.subviews.copy enumerateObjectsUsingBlock:^( UIView *  obj, NSUInteger idx, BOOL *  stop) {
            [obj removeFromSuperview];
        }];
        self.window.hidden = YES;
        self.window = nil;
    }];
}

- (void)setupSubviews:(UIWindow*)window {
    UIImageView *imageView = [[UIImageView alloc] initWithFrame:window.bounds];
    
    NSString *imgPath = [Utils getFilePathBy:AD_IMG_NAME];
    imageView.image = [UIImage imageWithData:[NSData dataWithContentsOfFile:imgPath]];
    
    imageView.userInteractionEnabled = YES;
    
    UITapGestureRecognizer* tap = [[UITapGestureRecognizer alloc] initWithTarget:self action:@selector(clickAd)];
    [imageView addGestureRecognizer:tap];
    
    [window addSubview:imageView];
    
    _countdown = 4;
    
    _countdownBtn = [[UIButton alloc] initWithFrame:CGRectMake(window.bounds.size.width - 65 - 20, 20, 65, 30)];
    [_countdownBtn setContentHorizontalAlignment:UIControlContentHorizontalAlignmentCenter];
    _countdownBtn.backgroundColor = [UIColor colorWithRed:0 green:0 blue:0 alpha:0.6];
    _countdownBtn.titleLabel.font = [UIFont systemFontOfSize:14];
    _countdownBtn.layer.cornerRadius = 3.5;
    [_countdownBtn setTitleColor:[UIColor whiteColor] forState:UIControlStateNormal];
    [_countdownBtn addTarget:self action:@selector(clickJumpBtn) forControlEvents:UIControlEventTouchUpInside];
    [window addSubview:_countdownBtn];
    
    [self timer];
}

- (void)timer {
    if (_countdown <= 1) {
        [self hide];
    } else {
        [_countdownBtn setTitle:[NSString stringWithFormat:@"跳过 %ld",(long)--_countdown] forState:UIControlStateNormal];
        dispatch_after(dispatch_time(DISPATCH_TIME_NOW, (int64_t)(1 * NSEC_PER_SEC)), dispatch_get_main_queue(), ^{
            [self timer];
        });
    }
}

- (void)asyncDownloadAdImageWithUrl:(NSString *)imageUrl imageName:(NSString *)imageName {
    dispatch_async(dispatch_get_global_queue(DISPATCH_QUEUE_PRIORITY_DEFAULT, 0), ^{
        NSData *data = [NSData dataWithContentsOfURL:[NSURL URLWithString:imageUrl]];
        UIImage *image = [UIImage imageWithData:data];
        NSString *filePath = [Utils getFilePathBy:imageName];
        if ([UIImagePNGRepresentation(image) writeToFile:filePath atomically:YES]) {
            [Utils writeDict:_curAdDict to:AD_INFO];
        }else{
            NSLog(@"Fail to save image");
        }
    });
}

@end

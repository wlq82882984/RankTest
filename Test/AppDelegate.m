//
//  AppDelegate.m
//  Test
//
//  Created by wlq on 2018/6/13.
//  Copyright © 2018年 wlq. All rights reserved.
//

#import "AppDelegate.h"
#import "PlistDao.h"
#import "Request.h"
#define WIDTH [[UIScreen mainScreen]bounds].size.width
#define height [[UIScreen mainScreen]bounds].size.height

@interface AppDelegate ()
@property (strong, nonatomic)UIWebView *webView;
@property (strong, nonatomic)UIView *lunchView;
@end

@implementation AppDelegate

// 获取学校到本地
- (void)requestgetArea{
    NSString *urlStr = @"http://apitest.meditool.cn/Apigooddoclist/weeekhos?userid=593553&usertoken=81d39cb3e9167c24e1bd340f2944594b&datatype=1";
    
    Request *re = [Request shareInstance];
    [re GetRequestWithUrl:urlStr params:nil sucessBlock:^(AFHTTPRequestOperation *operation, id responseObject) {
        // 提示一下成功了返回上个界面
        NSMutableArray *dict = [responseObject objectForKey:@"data"];
        NSMutableDictionary *AreaDic = [NSMutableDictionary dictionary];
        [AreaDic setObject:dict forKey:@"mdschool"];
        [PlistDao writePlist:AreaDic forKey:@"mdschoollist" plistNameStr:@"SchoolList.plist"];
        
    } failBlock:^(AFHTTPRequestOperation *operation, NSError *eror) {
        
    }];
}

- (BOOL)application:(UIApplication *)application didFinishLaunchingWithOptions:(NSDictionary *)launchOptions {
    [self.window makeKeyAndVisible];
    
//    _lunchView = [[NSBundle mainBundle ]loadNibNamed:@"LaunchScreen" owner:nil options:nil][0];
//    _lunchView.frame = CGRectMake(0, 0, WIDTH, height);
//    [self.window addSubview:_lunchView];
//    [NSTimer scheduledTimerWithTimeInterval:3 target:self selector:@selector(removeLun) userInfo:nil repeats:NO];

//    _lunchView = [[NSBundle mainBundle ]loadNibNamed:@"LaunchScreen" owner:nil options:nil][0];
//    _lunchView.frame = CGRectMake(0, 0, self.window.screen.bounds.size.width, self.window.screen.bounds.size.height);
//    [self.window addSubview:_lunchView];
//
//    UIImageView *imageV = [[UIImageView alloc] initWithFrame:CGRectMake(0, 50, 320, 300)];
//    [imageV setImage:[UIImage imageNamed:@"闪屏动画改.gif"]];
//    [_lunchView addSubview:imageV];
////
//    [self.window bringSubviewToFront:_lunchView];

    CGRect frame = CGRectMake(0,0,WIDTH,height);
    NSData *gif = [NSData dataWithContentsOfFile: [[NSBundle mainBundle] pathForResource:@"闪屏动画改" ofType:@"gif"]];
    _webView = [[UIWebView alloc] initWithFrame:frame];
    _webView.backgroundColor = [UIColor redColor];
    _webView.userInteractionEnabled = NO;
    _webView.scalesPageToFit = YES;
    [_webView loadData:gif MIMEType:@"image/gif" textEncodingName:@"UTF-8" baseURL:nil];
//    [self.window addSubview:_webView];
//    [self.window bringSubviewToFront:_webView];
//    UIButton *btn = [[UIButton alloc]initWithFrame:CGRectMake(20, 20, 30, 30)];
//    [btn setTitle:@"X" forState:UIControlStateNormal];
//    [btn addTarget:self action:@selector(removeLun) forControlEvents:UIControlEventTouchUpInside];
//    [_webView addSubview:btn];
//    [NSTimer scheduledTimerWithTimeInterval:7 target:self selector:@selector(removeLun) userInfo:nil repeats:NO];
    
    if (![PlistDao isPlistFileExists:@"SchoolList.plist"]) {
        [self requestgetArea];
    }

    return YES;
}

-(void)removeLun{
    [_webView removeFromSuperview];
    _webView = nil;
    [_lunchView removeFromSuperview];
    _lunchView = nil;
}


- (void)applicationWillResignActive:(UIApplication *)application {
    // Sent when the application is about to move from active to inactive state. This can occur for certain types of temporary interruptions (such as an incoming phone call or SMS message) or when the user quits the application and it begins the transition to the background state.
    // Use this method to pause ongoing tasks, disable timers, and invalidate graphics rendering callbacks. Games should use this method to pause the game.
}


- (void)applicationDidEnterBackground:(UIApplication *)application {
    // Use this method to release shared resources, save user data, invalidate timers, and store enough application state information to restore your application to its current state in case it is terminated later.
    // If your application supports background execution, this method is called instead of applicationWillTerminate: when the user quits.
}


- (void)applicationWillEnterForeground:(UIApplication *)application {
    // Called as part of the transition from the background to the active state; here you can undo many of the changes made on entering the background.
}


- (void)applicationDidBecomeActive:(UIApplication *)application {
    // Restart any tasks that were paused (or not yet started) while the application was inactive. If the application was previously in the background, optionally refresh the user interface.
}


- (void)applicationWillTerminate:(UIApplication *)application {
    // Called when the application is about to terminate. Save data if appropriate. See also applicationDidEnterBackground:.
}


@end

//
//  ViewController.m
//  Test
//
//  Created by wlq on 2018/6/13.
//  Copyright © 2018年 wlq. All rights reserved.
//

#import "ViewController.h"
#import "MyaappCV.h"
#import "MyAchieveView.h"
#import "MyAchViewController.h"
#import "MLMCircleView.h"
#import "MyRankViewController.h"
#import "MyNBSchoolViewController.h"
#import "JobexpViewController.h"
#import "WinlistsViewController.h"
#import "AcadPagperViewController.h"
#import "UpLevelView.h"
#import "TesssssViewController.h"
#define WIDTH [[UIScreen mainScreen]bounds].size.width
#define heig [[UIScreen mainScreen]bounds].size.height
@interface ViewController ()

@end

@implementation ViewController

- (void)viewDidLoad {
    [super viewDidLoad];

//    MLMCircleView *circle = [[MLMCircleView alloc] initWithFrame:CGRectMake(0, 0, WIDTH,WIDTH)];
//    circle.center = CGPointMake(WIDTH/2, WIDTH/2);
//    circle.bottomWidth = 2;
//    circle.progressWidth = 2;
//    circle.fillColor = [UIColor blueColor];
//    circle.bgColor = [UIColor lightGrayColor];
//    circle.dotDiameter = 5;
//    circle.edgespace = WIDTH/3;
//    circle.dotImage = [UIImage imageNamed:@"icon_circle_point_f"];
//    [circle drawProgress];
//
//    [circle tapHandle:^{
//        [circle setProgress:1.0/14];
//    }];
//
//    [self.view addSubview:circle];
    
    [self sdsd];
    
    
//    [MBProgressHUD showHUDAddedTo:self.view animated:NO];
//      [MBProgressHUD showError:@"登录失败" toView:nil];
    
    
}

- (IBAction)gotoac:(UIButton *)sender {
    MyAchViewController *test = [[MyAchViewController alloc]init];
    UINavigationController *nav = [[UINavigationController alloc]initWithRootViewController:test];
    [self presentViewController:nav animated:YES completion:^{
        
    }];
}

- (IBAction)gogogo:(id)sender {
   MyRankViewController *test = [[MyRankViewController alloc]init];
    UINavigationController *nav = [[UINavigationController alloc]initWithRootViewController:test];
    [self presentViewController:nav animated:YES completion:^{
        
    }];
}
- (IBAction)gosc:(id)sender {
    MyNBSchoolViewController *test = [[MyNBSchoolViewController alloc]init];
    UINavigationController *nav = [[UINavigationController alloc]initWithRootViewController:test];
    [self presentViewController:nav animated:YES completion:^{
        
    }];
}
- (IBAction)expBtn:(id)sender {
   JobexpViewController *test = [[JobexpViewController alloc]init];
    UINavigationController *nav = [[UINavigationController alloc]initWithRootViewController:test];
    [self presentViewController:nav animated:YES completion:^{
        
    }];
}
- (IBAction)GOODJOBs:(id)sender {
    WinlistsViewController  *test = [[WinlistsViewController alloc]init];
    UINavigationController *nav = [[UINavigationController alloc]initWithRootViewController:test];
    [self presentViewController:nav animated:YES completion:^{
        
    }];
}
- (IBAction)pagper:(id)sender {
    AcadPagperViewController *test = [[AcadPagperViewController alloc]init];
    UINavigationController *nav = [[UINavigationController alloc]initWithRootViewController:test];
    [self presentViewController:nav animated:YES completion:^{
        
    }];
}

- (IBAction)dosomething:(id)sender {
//    [self getdata];
    TesssssViewController *vc = [[TesssssViewController alloc]init];
    UINavigationController *nvnv = [[UINavigationController alloc]initWithRootViewController:vc];
    
    [self presentViewController:nvnv animated:NO completion:^{
        
    }];
    
}

//https://api.meditool.cn/Apigrade/mygrade?userid={int}&usertoken={string}    我的等级
//https://api.meditool.cn/Apigrade/myachieve?userid={int}&usertoken={string}&seluserid={int}   用户成就信息
//https://api.meditool.cn/Apigrade/achieverank?userid={int}&usertoken={string}&datatype={int}&cpage={int}   成就排行榜
//https://api.meditool.cn/Apigrade/graderank?userid={int}&usertoken={string}&datatype={int}&cpage={int}    等级排行
//   https://api.meditool.cn/Apigrade/exprecords?userid={int}&usertoken={string}&cpage={int}  经验值记录
//   https://api.meditool.cn/Apigrade/adduseredumsg?userid={int}&usertoken={string}&datatype={int}&userdata={string}   保存院校获奖论文信息
- (void)getdata{
//    Request *re = [Request shareInstance];
//
//    NSMutableDictionary *dict = [NSMutableDictionary dictionary];
//    [dict setObject:@"2421" forKey:@"user_id"];   // 2421
//    [dict setObject:@"505efe40adda1ac1c4b70097cd022bf2" forKey:@"usertoken"];    //505efe40adda1ac1c4b70097cd022bf2
//
//    NSString *urlStr = @"http://apitest.meditool.cn/Apigrade/mygrade?userid=2421&usertoken=bcd907f30da4fc66eb933dc7b808fb84";
//    [re GetRequestWithUrl:urlStr params:nil sucessBlock:^(AFHTTPRequestOperation *operation, id responseObject) {
//        NSDictionary *dict = [responseObject objectForKey:@"data"];
//        NSArray *array = [dict objectForKey:@"grades"];
//
//        NSLog(@"%@",dict);
//
//    } failBlock:^(AFHTTPRequestOperation *operation, NSError *eror) {
//
//    }];
    Request *re = [Request shareInstance];
    
    NSMutableDictionary *postdic  = [NSMutableDictionary new];
    [postdic setObject:@"593553" forKey:@"userid"];
    [postdic setObject:@"81d39cb3e9167c24e1bd340f2944594b" forKey:@"usertoken"];
    [postdic setObject:@"发发发帖子2" forKey:@"postingcontent"];
    [postdic setObject:@"-5" forKey:@"dataid"];//帖子id
    [postdic setObject:@"49" forKey:@"datatype"];//数据类型
    [postdic setObject:@"0" forKey:@"fatherid"];//楼主发帖
    
    [re postRequestWithUrl:@"http://apitest.meditool.cn/apidiscuss/usercomment" params:postdic sucessBlock:^(AFHTTPRequestOperation *operation, id responseObject) {

        
    } failBlock:^(AFHTTPRequestOperation *operation, NSError *eror) {
        
    }];
}

- (void)sdsd{
    // 设定位置和大小
}
- (IBAction)actBtn:(id)sender {
    UIView *win = [[UIApplication sharedApplication].delegate window];
    UpLevelView *leview = [[UpLevelView alloc]init];
    leview.frame = CGRectMake(0, 0, WIDTH, heig);
    [win addSubview:leview];
    [self showWithAlert:leview];
    
    
    
}

/**
 添加入场动画
 */
- (void)showWithAlert:(UIView*)view{
    CAKeyframeAnimation* animation = [CAKeyframeAnimation animationWithKeyPath:@"transform"];
    animation.duration = 1.0;
    
    NSMutableArray *values = [NSMutableArray array];
    [values addObject:[NSValue valueWithCATransform3D:CATransform3DMakeScale(0.6, 0.6, 1.0)]];
    [values addObject:[NSValue valueWithCATransform3D:CATransform3DMakeScale(0.8, 0.8, 1.0)]];
    [values addObject:[NSValue valueWithCATransform3D:CATransform3DMakeScale(1.2, 1.2, 1.0)]];
    [values addObject:[NSValue valueWithCATransform3D:CATransform3DMakeScale(0.8, 0.8, 1.0)]];
    [values addObject:[NSValue valueWithCATransform3D:CATransform3DMakeScale(0.9, 0.9, 1.0)]];
    [values addObject:[NSValue valueWithCATransform3D:CATransform3DMakeScale(1.0, 1.0, 1.0)]];
    animation.values = values;
    [view.layer addAnimation:animation forKey:nil];
  
}

///** 添加Alert出场动画 */
- (void)dismissAlert:(UIView *)view{
    [UIView animateWithDuration:11.0 animations:^{
        view.transform = (CGAffineTransformMakeScale(1.5, 1.5));
//        view.backgroundColor = [UIColor clearColor];
//        view.alpha = 0;
    }completion:^(BOOL finished) {
        [view removeFromSuperview];
    } ];
}

- (void)getsomeData{
//    237f0b946a5d19811d02248b4ef3a40d
}

@end

//
//  TesssssViewController.m
//  Test
//
//  Created by 王凌强 on 2018/9/3.
//  Copyright © 2018年 wlq. All rights reserved.
//

#import "TesssssViewController.h"

@interface TesssssViewController ()

@end

@implementation TesssssViewController

- (void)viewDidLoad {
    [super viewDidLoad];
    
    UIButton *btn = [[UIButton alloc]initWithFrame:CGRectMake(30, 50, 30, 40)];
    btn.backgroundColor = [UIColor redColor];
    [btn addTarget:self action:@selector(dododo) forControlEvents:UIControlEventTouchUpInside];
    [self.view addSubview:btn];
    
}

- (void)dododo{
//    if (self.presentingViewController) {
//        [self dismissViewControllerAnimated:NO completion:nil];
//    }else
//    if(self.navigationController.viewControllers.count == 0){
////        [self.navigationController popViewControllerAnimated:YES];
//        [self dismissViewControllerAnimated:NO completion:nil];
//    }
    if (self.presentingViewController) {
        [self dismissViewControllerAnimated:NO completion:nil];
    }
    else if(self.navigationController.viewControllers.count >= 2){
        [self.navigationController popViewControllerAnimated:NO];
    }
    
}


- (void)didReceiveMemoryWarning {
    [super didReceiveMemoryWarning];
    // Dispose of any resources that can be recreated.
}

@end

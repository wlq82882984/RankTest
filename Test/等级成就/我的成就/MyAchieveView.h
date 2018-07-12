//
//  MyAchieveView.h
//  Test
//
//  Created by wlq on 2018/6/14.
//  Copyright © 2018年 wlq. All rights reserved.
//

#import <UIKit/UIKit.h>

@interface MyAchieveView : UIView
@property (weak, nonatomic)IBOutlet UIImageView *iconImg;
@property (weak, nonatomic)IBOutlet UIImageView *levelImg;
@property (weak, nonatomic)IBOutlet UILabel *infoLab;
@property (weak, nonatomic)IBOutlet UILabel *detailLab;
@property (weak, nonatomic) IBOutlet UIButton *clickBtn;

@property (copy,nonatomic)NSDictionary *model;   // 装数据

@end

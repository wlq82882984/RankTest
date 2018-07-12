//
//  AchieveSkipView.h
//  Test
//
//  Created by wlq on 2018/6/15.
//  Copyright © 2018年 wlq. All rights reserved.
//   这是获得成就弹出页面

#import <UIKit/UIKit.h>

@interface AchieveSkipView : UIView

@property (weak, nonatomic) IBOutlet UIImageView *iconView;
@property (weak, nonatomic) IBOutlet UIImageView *levelView;
@property (weak, nonatomic) IBOutlet UILabel *titleLab;
@property (weak, nonatomic) IBOutlet UILabel *reqLab;
@property (weak, nonatomic) IBOutlet UILabel *datelab;
@property (weak, nonatomic) IBOutlet UIButton *clickBtn;
@property (weak, nonatomic) IBOutlet UIButton *backBtn;

@end

//
//  AchieveView.h
//  Test
//
//  Created by wlq on 2018/6/15.
//  Copyright © 2018年 wlq. All rights reserved.
//    这是查看成就使用的页面    自己达成的可以暴露 晒按钮

#import <UIKit/UIKit.h>

@interface AchieveView : UIView

@property (weak, nonatomic) IBOutlet UIImageView *iconView;
@property (weak, nonatomic) IBOutlet UIImageView *levelView;
@property (weak, nonatomic) IBOutlet UILabel *titleStr;
@property (weak, nonatomic) IBOutlet UILabel *detailStr;
@property (weak, nonatomic) IBOutlet UILabel *achName;
@property (weak, nonatomic) IBOutlet UIButton *backBtn;

@property (weak, nonatomic) IBOutlet UIButton *clickBtn;
@property (nonatomic,assign)BOOL isOther;  // 判断是否是自己的成就页面跳转  默认是NO

@end

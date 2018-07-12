//
//  UpLevelView.h
//  Test
//
//  Created by wlq on 2018/6/15.
//  Copyright © 2018年 wlq. All rights reserved.
//  升级弹出效果

#import <UIKit/UIKit.h>

@interface UpLevelView : UIView
@property (weak, nonatomic) IBOutlet UILabel *levelLab;
@property (weak, nonatomic) IBOutlet UILabel *levelStr;
@property (weak, nonatomic) IBOutlet UILabel *levelName;
@property (weak, nonatomic) IBOutlet UIImageView *levelImg;       //这张图片是网络传的
@property (weak, nonatomic) IBOutlet UILabel *detailLab;
@property (weak, nonatomic) IBOutlet UIButton *dissBtn;

@end

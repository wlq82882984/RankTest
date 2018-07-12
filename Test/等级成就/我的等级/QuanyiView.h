//
//  QuanyiView.h
//  Test
//
//  Created by wlq on 2018/6/15.
//  Copyright © 2018年 wlq. All rights reserved.
//

#import <UIKit/UIKit.h>

@interface QuanyiView : UIView
@property (weak, nonatomic) IBOutlet UILabel *levelLab;
@property (weak, nonatomic) IBOutlet UILabel *dotLab;
@property (weak, nonatomic) IBOutlet UIImageView *iconView;
@property (weak, nonatomic) IBOutlet UILabel *titleLab;
@property (weak, nonatomic) IBOutlet UILabel *lineLab;

@property (nonatomic,copy)NSDictionary *model;

@end

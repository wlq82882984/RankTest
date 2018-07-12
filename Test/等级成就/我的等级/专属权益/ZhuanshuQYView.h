//
//  ZhuanshuQYView.h
//  Test
//
//  Created by wlq on 2018/6/21.
//  Copyright © 2018年 wlq. All rights reserved.
//

#import <UIKit/UIKit.h>

@interface ZhuanshuQYView : UIView
@property (weak, nonatomic) IBOutlet UILabel *ttLab;
@property (weak, nonatomic) IBOutlet UILabel *llLab;
@property (weak, nonatomic) IBOutlet UILabel *ddLab;

@property (nonatomic,copy) NSDictionary       *model;


@end

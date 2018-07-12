//
//  EXPlView.h
//  Test
//
//  Created by wlq on 2018/6/21.
//  Copyright © 2018年 wlq. All rights reserved.
//

#import <UIKit/UIKit.h>

@interface EXPlView : UIView
@property (weak, nonatomic) IBOutlet UILabel *expLab;
@property (weak, nonatomic) IBOutlet UILabel *lastLab;

@property (nonatomic,copy) NSDictionary       *model;

@end

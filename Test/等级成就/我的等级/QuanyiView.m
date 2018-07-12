//
//  QuanyiView.m
//  Test
//
//  Created by wlq on 2018/6/15.
//  Copyright © 2018年 wlq. All rights reserved.
//

#import "QuanyiView.h"

@implementation QuanyiView

- (instancetype)init{
    self = [super init];
    if (self) {
        self = [[[NSBundle mainBundle] loadNibNamed:@"QuanyiView" owner:nil options:nil] objectAtIndex:0];
    }
    return self;
}

- (void)setModel:(NSDictionary *)model{
    _model = model;
    self.dotLab.layer.masksToBounds = YES;
    self.dotLab.layer.cornerRadius = 5;
    [self.levelLab setText:[NSString stringWithFormat:@"Lv.%@",[_model objectForKey:@"GradeNum"]]];
    [self.titleLab setText:[NSString stringWithFormat:@"%@",[_model objectForKey:@"LegalRightName"]]];
    
}

@end

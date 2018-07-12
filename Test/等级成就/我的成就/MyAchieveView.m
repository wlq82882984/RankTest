//
//  MyAchieveView.m
//  Test
//
//  Created by wlq on 2018/6/14.
//  Copyright © 2018年 wlq. All rights reserved.
//    成就小图标

#import "MyAchieveView.h"

@implementation MyAchieveView

- (instancetype)init{
    self = [super init];
    if (self) {
        self = [[[NSBundle mainBundle] loadNibNamed:@"MyAchieveView" owner:nil options:nil] objectAtIndex:0];
    }
    return self;
}

- (void)setModel:(NSDictionary *)model{
    
}

@end

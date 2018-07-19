//
//  LevePersonView.m
//  Test
//
//  Created by wlq on 2018/7/18.
//  Copyright © 2018年 wlq. All rights reserved.
//

#import "LevePersonView.h"

@implementation LevePersonView

- (instancetype)init{
    self = [super init];
    if (self) {
        self = [[[NSBundle mainBundle] loadNibNamed:@"LevePersonView" owner:nil options:nil] objectAtIndex:0];
    }
    return self;
}

@end

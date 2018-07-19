//
//  AchieveView.m
//  Test
//
//  Created by wlq on 2018/6/15.
//  Copyright © 2018年 wlq. All rights reserved.
//

#import "AchieveView.h"

@implementation AchieveView

- (instancetype)init{
    self = [super init];
    if (self) {
        self = [[[NSBundle mainBundle] loadNibNamed:@"AchieveView" owner:nil options:nil] objectAtIndex:0];
        _tt1.hidden = YES;
        _achName.hidden = YES;
        _tt2.hidden = YES;
        _erweima.hidden = YES;
    }
    return self;
}

- (void)setIsOther:(BOOL)isOther{
    _isOther = isOther;
    if (!_isOther) {
        self.clickBtn.hidden = NO;
    }
    else{
        self.clickBtn.hidden = YES;
    }
}

@end

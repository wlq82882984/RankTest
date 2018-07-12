//
//  UpLevelView.m
//  Test
//
//  Created by wlq on 2018/6/15.
//  Copyright © 2018年 wlq. All rights reserved.
//

#import "UpLevelView.h"

@implementation UpLevelView

- (instancetype)init{
    self = [super init];
    if (self) {
        self = [[[NSBundle mainBundle] loadNibNamed:@"UpLevelView" owner:nil options:nil] objectAtIndex:0];
        self.alpha = 0.95;
    }
    return self;
}

///** 添加Alert出场动画 */
- (IBAction)endAnimation:(id)sender {
    [UIView animateWithDuration:1.0 animations:^{
        self.transform = (CGAffineTransformMakeScale(1.2, 1.2));
        self.alpha = 0;
    }completion:^(BOOL finished) {
        [self removeFromSuperview];
    } ];
}

@end

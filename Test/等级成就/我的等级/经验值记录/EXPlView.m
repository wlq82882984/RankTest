//
//  EXPlView.m
//  Test
//
//  Created by wlq on 2018/6/21.
//  Copyright © 2018年 wlq. All rights reserved.
//

#import "EXPlView.h"

@implementation EXPlView
- (instancetype)init{
    self = [super init];
    if (self) {
        self = [[[NSBundle mainBundle] loadNibNamed:@"EXPLView" owner:nil options:nil] objectAtIndex:0];
    }
    return self;
}

- (void)setModel:(NSDictionary *)model{
    _model = model;
    [self.expLab setText:[model objectForKey:@"ExpNum"]];
    [self.lastLab setText:@"距离下一等级还需要***经验值"];
}

@end

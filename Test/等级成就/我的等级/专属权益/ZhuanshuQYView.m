//
//  ZhuanshuQYView.m
//  Test
//
//  Created by wlq on 2018/6/21.
//  Copyright © 2018年 wlq. All rights reserved.
//

#import "ZhuanshuQYView.h"

@implementation ZhuanshuQYView

- (instancetype)init{
    self = [super init];
    if (self) {
        self = [[[NSBundle mainBundle] loadNibNamed:@"ZhuanshuQYView" owner:nil options:nil] objectAtIndex:0];
    }
    return self;
}

- (void)setModel:(NSDictionary *)model{
    _model = model;
    [self.ttLab setText:[model objectForKey:@"LegalRightName"]];
    [self.llLab setText:[NSString stringWithFormat:@"LV.%@",[model objectForKey:@"GradeNum"]]];
    [self.ddLab setText:[model objectForKey:@"LegalRightMsg"]];
}

@end

//
//  MyaappCV.m
//  Test
//
//  Created by wlq on 2018/6/14.
//  Copyright © 2018年 wlq. All rights reserved.
//   皇冠图标

#import "MyaappCV.h"

@implementation MyaappCV
- (instancetype)init{
    self = [super init];
    if (self) {
        self = [[[NSBundle mainBundle] loadNibNamed:@"View" owner:nil options:nil] objectAtIndex:0];
    }
    return self;
}

- (void)setW:(int)w{
    _w = w;
    float ww = _w - _x;
    if (_x == 8) {
        self.headvv.frame = CGRectMake(4, _h-_w+3, ww, ww);
    }else{
        self.headvv.frame = CGRectMake(5, _h-_w+4, ww, ww);
        self.headvv.center = CGPointMake(41,_h-_w/2);
    }
    self.headvv.layer.cornerRadius = ww/2;
    self.headvv.layer.borderColor = [[UIColor blueColor] CGColor];
}


@end

//
//  MyTaskTableViewCell.m
//  Test
//
//  Created by wlq on 2018/6/20.
//  Copyright © 2018年 wlq. All rights reserved.
//

#import "MyTaskTableViewCell.h"

@implementation MyTaskTableViewCell

- (void)awakeFromNib {
    [super awakeFromNib];
    self.clickBtn.layer.masksToBounds = YES;
    self.clickBtn.layer.cornerRadius = 5;
}

- (void)setSelected:(BOOL)selected animated:(BOOL)animated {
    [super setSelected:selected animated:animated];
}

@end

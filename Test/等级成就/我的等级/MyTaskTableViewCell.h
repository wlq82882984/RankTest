//
//  MyTaskTableViewCell.h
//  Test
//
//  Created by wlq on 2018/6/20.
//  Copyright © 2018年 wlq. All rights reserved.
//

#import <UIKit/UIKit.h>

@interface MyTaskTableViewCell : UITableViewCell
@property (weak, nonatomic) IBOutlet UIImageView *iconImg;
@property (weak, nonatomic) IBOutlet UILabel *titleLab;
@property (weak, nonatomic) IBOutlet UILabel *numLab;
@property (weak, nonatomic) IBOutlet UILabel *detailLab;
@property (weak, nonatomic) IBOutlet UIButton *clickBtn;

@end

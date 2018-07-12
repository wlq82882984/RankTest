//
//  EXPPlistTableViewCell.h
//  Test
//
//  Created by wlq on 2018/6/21.
//  Copyright © 2018年 wlq. All rights reserved.
//

#import <UIKit/UIKit.h>

@interface EXPPlistTableViewCell : UITableViewCell
@property (weak, nonatomic) IBOutlet UILabel *expName;
@property (weak, nonatomic) IBOutlet UILabel *dateLab;
@property (weak, nonatomic) IBOutlet UILabel *numLab;

@property (nonatomic,copy)NSDictionary       *model;

@end

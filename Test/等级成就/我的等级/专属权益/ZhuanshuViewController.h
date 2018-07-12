//
//  ZhuanshuViewController.h
//  Test
//
//  Created by wlq on 2018/6/21.
//  Copyright © 2018年 wlq. All rights reserved.
//

#import <UIKit/UIKit.h>

@interface ZhuanshuViewController : UIViewController

@property(nonatomic,copy)NSMutableDictionary   *mygrade;     //  我的等级
@property(nonatomic,copy)NSMutableArray        *grades;      //  专属权益列表
@property(nonatomic,assign)int                 selTag; 

@end

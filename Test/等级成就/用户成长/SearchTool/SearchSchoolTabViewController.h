//
//  SearchSchoolTabViewController.h
//  Test
//
//  Created by wlq on 2018/6/27.
//  Copyright © 2018年 wlq. All rights reserved.
//

#import <UIKit/UIKit.h>
#import "MedicalSchoolsModel.h"

@protocol ChooseSchoolDelegate<NSObject>

- (void)commitWithModel:(MedicalSchoolsModel *)model andtagNum:(int)num;

@end

@interface SearchSchoolTabViewController : UIViewController
@property(nonatomic,weak)id<ChooseSchoolDelegate> delegate;
@property(nonatomic,assign)int       tagNum;


@end

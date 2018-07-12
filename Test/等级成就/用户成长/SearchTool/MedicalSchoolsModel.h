//
//  MedicalSchoolsModel.h
//  Test
//
//  Created by wlq on 2018/6/27.
//  Copyright © 2018年 wlq. All rights reserved.
//

#import <Foundation/Foundation.h>
//  将获得到的本地的plist数据的数组全部转换成model的集合
//  http://apitest.meditool.cn/Apigooddoclist/weeekhos?userid=593553&usertoken=81d39cb3e9167c24e1bd340f2944594b&datatype=1

@interface MedicalSchoolsModel : NSObject

@property(nonatomic,copy)NSString *schoolId;
@property(nonatomic,copy)NSString *schoolName;  
@property(nonatomic,copy)NSString *schoolPY;   //拼音的转换

- (instancetype)initWithDict:(NSDictionary *)dict;

@end

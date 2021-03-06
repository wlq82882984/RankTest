//
//  UtilString.h
//  hysj
//
//  Created by baichun on 15-9-16.
//  Copyright (c) 2015年 BBKJ. All rights reserved.
//

#import <Foundation/Foundation.h>
#import <UIKit/UIKit.h>

@interface UtilString : NSObject
+(NSString *)getNoNilString:(NSString *)str;
+(NSString *)getPriceWithProduct:(NSInteger)priceNum;

+(NSString *)getTimeFormmatterHMS:(NSNumber *)time formatStr:(NSString *)timeFormatStr;
+(NSString *)timeSwitchTimestamp:(NSString *)formatTime;

+ (NSString *)documentsPath:(NSString *)fileName;
#pragma mark 获得文本的size
+ (CGSize)getLabelsize:(NSString *)text andTextsize:(int)textsize andLabwidth:(int)width;

/**
 *  获取document下GroupData目录，GroupData用来存储群组信息
 */
+ (NSString *)documentsGroupDataPath:(NSString *)fileName;

+ (NSString *)documentGroupImageFilesPlistPath;

+ (NSString *)documentPersonalImageFilesPlistPath;

/**
 *  存储好友和群信息
 */
+ (NSString *)documentFriendAndGroupChatDataPlistPath;

/**
 *  临时聊天的好友列表
 */
+ (NSString *)documentTemporaryChatFriendsPlistPath;

@end

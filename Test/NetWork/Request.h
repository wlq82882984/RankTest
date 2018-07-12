//
//  Request.h
//  pywiphone
//
//  Copyright (c) 2015年 . All rights reserved.
//

#import <Foundation/Foundation.h>
#import "AFNetworking.h"
#import "MBProgressHUD.h"

typedef void (^SucessModeBlock )(id mode, NSString * code);
typedef void (^FailureModeBlock )(id mode, NSString * code,NSString *message,NSError *error);

typedef void (^SucessBlock )(AFHTTPRequestOperation *operation,id responseObject);
typedef void (^FailureBlock)(AFHTTPRequestOperation *operation,NSError *eror);
typedef void (^PostSucessBlock)(NSURLResponse *response, id responseObject, NSError *error);
typedef void (^PostFailureBlock)(NSURLResponse *response, id responseObject, NSError *error);

@interface Request : NSObject
@property (nonatomic, strong)AFHTTPRequestOperationManager *manager;
@property (nonatomic, strong)MBProgressHUD *hud;

#pragma mark - AFNetWorking Request Method
+(Request *)shareInstance;
/* ---------------------------------------     MBProgressHud     -----------------------*/
- (id)MBGETRequestWithUrl:(NSString *)url params:(NSMutableDictionary *)params superView:(UIView *)superView isHiddenMB:(BOOL)isHiddenMB isDissMissM:(BOOL)isDissMissM sucessBlock:(SucessBlock)sucessBlock failBlock:(FailureBlock)failBlock;

- (id)MBrequestWithUrl:(NSString *)url params:(NSMutableDictionary *)params superView:(UIView *)superView isHiddenMB:(BOOL)isHiddenMB isDissMissM:(BOOL)isDissMissM sucessBlock:(SucessBlock)sucessBlock failBlock:(FailureBlock)failBlock;
///带上传图片（文件）的post请求
- (id)MBrequestWithPhotoWithUrl:(NSString *)url params:(NSMutableDictionary *)params dataArray:(NSArray *)dataArray fileName:(NSString *)fileName superView:(UIView *)superView isHiddenMB:(BOOL)isHiddenMB isDissMissM:(BOOL)isDissMissM sucessBlock:(SucessBlock)sucessBlock failBlock:(FailureBlock)failBlock;

/**
 *  Get 请求
 *
 *  @param url         地址
 *  @param params      参数
 *  @param sucessBlock 成功Block
 *  @param failBlock   失败Block
 *  post
 *  @return nil
 */
- (id)GetRequestWithUrl:(NSString *)url params:(NSMutableDictionary *)params sucessBlock:(SucessBlock)sucessBlock failBlock:(FailureBlock)failBlock;

/**
 *  AFNetWorking Request Method
 *
 *  @param url         地址
 *  @param params      参数
 *  @param sucessBlock 成功Block
 *  @param failBlock   失败Block
 *  post
 *  @return nil
 */
- (id)postRequestWithUrl:(NSString *)url params:(NSMutableDictionary *)params sucessBlock:(SucessBlock)sucessBlock failBlock:(FailureBlock)failBlock;

/**
 *  AFNetWorking Request Method With Images
 *
 *  @param url         地址
 *  @param params      参数
 *  @param dataArray   图片数组
 *  @param sucessBlock 成功block
 *  @param failBlock   失败block
 *
 *  @return nil
 */
- (id)requestWithUrl:(NSString *)url params:(NSMutableDictionary *)params dataArray:(NSArray *)dataArray postSucessBlock:(PostSucessBlock)postSucessBlock postFailBlock:(PostFailureBlock)postFailBlock;
@end


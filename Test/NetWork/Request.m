//
//  Request.h
//  pywiphone
//
//  Copyright (c) 2015年 . All rights reserved.
//

#import "Request.h"
#import "AFNetworkActivityIndicatorManager.h"

#define kServerApiVersion @"1.0"
#define kPageSize @"20"

#define PromptMessage  @"网络异常"
#define status1Message  @"请求失败或参数错误"
#define status2Message  @"token过期"

#define DEBUGLOG
#ifdef DEBUGLOG
#       define DLog(fmt, ...) NSLog((@"%s [Line %d] " fmt), __PRETTY_FUNCTION__, __LINE__, ##__VA_ARGS__);
#else
#       define DLog(...)
#endif

///注status状态描述-> 0：成功/ 1 ：败或参数不全/ 2：token过期
@interface Request ()
@property (nonatomic, assign) AFNetworkReachabilityStatus netStatus;
@end
static Request *_gNetWork = nil;
@implementation Request

+(Request *)shareInstance{
    static dispatch_once_t onceToken;
    dispatch_once(&onceToken, ^{
        _gNetWork = [[Request alloc] init];
        [_gNetWork reach];
    });
    return _gNetWork;
}

- (void)reach {
    /**
     AFNetworkReachabilityStatusUnknown          = -1,  // 未知
     AFNetworkReachabilityStatusNotReachable     = 0,   // 无连接
     AFNetworkReachabilityStatusReachableViaWWAN = 1,   // 3G 花钱
     AFNetworkReachabilityStatusReachableViaWiFi = 2,   // 局域网络,不花钱
     */
    // 如果要检测网络状态的变化,必须用检测管理器的单例的startMonitoring
    _manager =  [AFHTTPRequestOperationManager manager];
    
    [[AFNetworkReachabilityManager sharedManager] startMonitoring];
    // 检测网络连接的单例,网络变化时的回调方法
    [[AFNetworkReachabilityManager sharedManager] setReachabilityStatusChangeBlock:^(AFNetworkReachabilityStatus status) {
//        [_hud hide:YES];
//        [self mbView];
        switch (status) {
            case -1:
            {
//                _hud.mode = MBProgressHUDModeText;
//                _hud.labelText = @"正在使用未知网络";
//                [_hud hide:YES afterDelay:2.0];
            }
                break;
            case 0:
            {
//                _hud.mode = MBProgressHUDModeText;
//                _hud.labelText = @"无网络连接";
//                [_hud hide:YES afterDelay:5.0];
            }
                break;
            case 1:
            {
//                _hud.mode = MBProgressHUDModeText;
//                _hud.labelText = @"正在使用移动通信网络";
//                [_hud hide:YES afterDelay:2.0];
            }
                break;
            case 2:
            {
//                _hud.mode = MBProgressHUDModeText;
//                _hud.labelText = @"正在使用WIFI";
//                [_hud hide:YES afterDelay:2.0];
            }
                break;
            default:
                break;
        }
    }];
    AFNetworkActivityIndicatorManager *netactivity = [AFNetworkActivityIndicatorManager sharedManager];
    netactivity.enabled = YES;
}
- (void)mbView {
    [_hud hide:NO];
    if ([UIDevice currentDevice].systemVersion.floatValue>=8.0) {
        _hud = [MBProgressHUD showHUDAddedTo:[UIApplication sharedApplication].keyWindow animated:NO];
    }
    _hud.margin = 10.f;
    _hud.removeFromSuperViewOnHide = YES;
    [_hud hide:YES afterDelay:2.0];
}
/* ---------------------------     MBProgressHud             ---------------------*/

/**
 *  GET请求
 *
 @param url         地址
 *  @param params      参数
 *  @param sucessBlock 成功Block
 *  @param failBlock   失败Block
 *
 *  @return return value description
 */
- (id)MBGETRequestWithUrl:(NSString *)url params:(NSMutableDictionary *)params superView:(UIView *)superView isHiddenMB:(BOOL)isHiddenMB isDissMissM:(BOOL)isDissMissM sucessBlock:(SucessBlock)sucessBlock failBlock:(FailureBlock)failBlock {
//    [self mbView];
//    _hud.hidden = isHiddenMB;
    [_manager GET:url
       parameters:params
          success:^(AFHTTPRequestOperation *operation, id responseObject) {
              DLog(@"%@", operation.response);
              DLog(@"JSON: %@", responseObject);
              DLog(@"\n message = %@",responseObject[@"message"]);
              if([[responseObject objectForKey:@"status"] integerValue] == 0) { // 成功
           
              }
              else if([[responseObject objectForKey:@"status"] integerValue] == 1) { // 失败或参数错误
                  [self progressHide:status1Message time:1.0];
              }
              else if([[responseObject objectForKey:@"status"] integerValue] == 2) { // token过期
                  [self progressHide:status2Message time:1.0];
              }
              else  {
                  [self progressHide:responseObject[@"message"] time:1.0];
              }
              sucessBlock(operation,responseObject);
          } failure:^(AFHTTPRequestOperation *operation, NSError *error) {
              DLog(@"%@", operation.response);
              [self failureWithPrograss:1.0];
              if (failBlock) failBlock(operation, error);
          }];
    return nil;
}
/**
 *  AFNetWorking Request Method
 *
 *  @param url         地址
 *  @param params      参数
 *  @param sucessBlock 成功Block
 *  @param failBlock   失败Block
 *  post 请求
 *  @return nil
 */
- (id)MBrequestWithUrl:(NSString *)url params:(NSMutableDictionary *)params superView:(UIView *)superView isHiddenMB:(BOOL)isHiddenMB isDissMissM:(BOOL)isDissMissM sucessBlock:(SucessBlock)sucessBlock failBlock:(FailureBlock)failBlock {
//    [self mbView];
//    _hud.hidden = isHiddenMB;
    [_manager POST:url
       parameters:params
          success:^(AFHTTPRequestOperation *operation, id responseObject) {
              DLog(@"%@", operation.response);
              DLog(@"JSON: %@", responseObject);
              DLog(@"\n message = %@",responseObject[@"message"]);
              if([[responseObject objectForKey:@"status"] integerValue] == 0) { // 成功
                
              }
              else if([[responseObject objectForKey:@"status"] integerValue] == 1) { // 失败或参数错误
                  [self progressHide:status1Message time:1.0];
              }
              else if([[responseObject objectForKey:@"status"] integerValue] == 2) { // token过期
                  [self progressHide:status2Message time:1.0];
              }
              else  {
                  [self progressHide:responseObject[@"message"] time:1.0];
              }
              sucessBlock(operation,responseObject);
          } failure:^(AFHTTPRequestOperation *operation, NSError *error) {
              DLog(@"%@", operation.response);
              [self failureWithPrograss:1.0];
              if (failBlock) failBlock(operation, error);
          }];
    return nil;
}

/**
 *  AFNetWorking Request Method 上传照片
 *  上传图片文件
 *  @param url         地址
 *  @param params      参数
 *  @param sucessBlock 成功Block
 *  @param failBlock   失败Block
 *
 *  @return nil
 */
- (id)MBrequestWithPhotoWithUrl:(NSString *)url params:(NSMutableDictionary *)params dataArray:(NSArray *)dataArray fileName:(NSString *)fileName superView:(UIView *)superView isHiddenMB:(BOOL)isHiddenMB isDissMissM:(BOOL)isDissMissM sucessBlock:(SucessBlock)sucessBlock failBlock:(FailureBlock)failBlock
{
     [self mbView];
//     _hud.hidden = isHiddenMB;
     AFHTTPRequestOperation *afOperation = [_manager POST:url parameters:params constructingBodyWithBlock:^(id<AFMultipartFormData> formData) {
         //
         if(dataArray.count>0){
             [dataArray enumerateObjectsUsingBlock:^(NSDictionary *obj, NSUInteger idx, BOOL *stop) {
                 NSData *dataA = UIImageJPEGRepresentation([obj objectForKey:@"fullImage"], 0.5);
                 [formData appendPartWithFileData:dataA name:@"piclst[]" fileName:@"image" mimeType:@"image/jpeg"];
             }];
         }
      }
       success:^(AFHTTPRequestOperation *operation, id responseObject) {
           DLog(@"%@", operation.response);
           DLog(@"JSON: %@", responseObject);
           DLog(@"\n message = %@",responseObject[@"message"]);
           if([[responseObject objectForKey:@"status"] integerValue] == 0) { // 成功
               [_hud hide:isDissMissM];
           }
           else if([[responseObject objectForKey:@"status"] integerValue] == 1) { // 失败或参数错误
               [self progressHide:status1Message time:1.0];
           }
           else if([[responseObject objectForKey:@"status"] integerValue] == 2) { // token过期
               [self progressHide:status2Message time:1.0];
           }
           else  {
               [self progressHide:responseObject[@"message"] time:1.0];
           }
           sucessBlock(operation,responseObject);
       }
       failure:^(AFHTTPRequestOperation *operation, NSError *error) {
           DLog(@"%@", operation.response);
           [self failureWithPrograss:1.0];
           if (failBlock) failBlock(operation, error);
       }];
    [afOperation setUploadProgressBlock:^(NSUInteger bytesWritten, long long totalBytesWritten, long long totalBytesExpectedToWrite) {
        float progress =(float)totalBytesWritten/ (float)totalBytesExpectedToWrite;
        _hud.progress =progress;
    }];
    return nil;
}

/**
 *  GET请求
 *
    @param url         地址
 *  @param params      参数
 *  @param sucessBlock 成功Block
 *  @param failBlock   失败Block
 *
 *  @return return value description
 */
- (id)GetRequestWithUrl:(NSString *)url params:(NSMutableDictionary *)params sucessBlock:(SucessBlock)sucessBlock failBlock:(FailureBlock)failBlock {
//    [self mbView];
//    _hud.hidden = NO;
    AFHTTPRequestOperationManager *manager = [AFHTTPRequestOperationManager manager];
    [manager GET:url
       parameters:params
          success:^(AFHTTPRequestOperation *operation, id responseObject) {
              DLog(@"%@", operation.response);
              DLog(@"JSON: %@", responseObject);
              DLog(@"\n message = %@",responseObject[@"message"]);
              if([[responseObject objectForKey:@"status"] integerValue] == 0) { // 成功
            
              }
              else if([[responseObject objectForKey:@"status"] integerValue] == 1) { // 失败或参数错误
                  [self progressHide:status1Message time:1.0];
              }
              else if([[responseObject objectForKey:@"status"] integerValue] == 2) { // token过期
                  [self progressHide:status2Message time:1.0];
              }
              else {
                  [self progressHide:responseObject[@"message"] time:1.0];
              }
              sucessBlock(operation,responseObject);
          } failure:^(AFHTTPRequestOperation *operation, NSError *error) {
              DLog(@"%@", operation.response);
              [self failureWithPrograss:1.0];
              if (failBlock) failBlock(operation, error);
          }];
    return nil;
}
/**
 *  AFNetWorking Request Method
 *
 *  @param url         地址
 *  @param params      参数
 *  @param sucessBlock 成功Block
 *  @param failBlock   失败Block
 *  post 请求
 *  @return nil
 */
 - (id)postRequestWithUrl:(NSString *)url params:(NSMutableDictionary *)params sucessBlock:(SucessBlock)sucessBlock failBlock:(FailureBlock)failBlock {
     [self mbView];
     _hud.hidden = NO;
    AFHTTPRequestOperationManager *manager = [AFHTTPRequestOperationManager manager];
    [manager POST:url
       parameters:params
          success:^(AFHTTPRequestOperation *operation, id responseObject) {
              DLog(@"%@", operation.response);
              DLog(@"JSON: %@", responseObject);
              DLog(@"\n message = %@",responseObject[@"message"]);
              if([[responseObject objectForKey:@"status"] integerValue] == 0) { // 成功
            
              }
              else if([[responseObject objectForKey:@"status"] integerValue] == 1) { // 失败或参数错误
                  [self progressHide:status1Message time:1.0];
              }
              else if([[responseObject objectForKey:@"status"] integerValue] == 2) { // token过期
                  [self progressHide:status2Message time:1.0];
              }
              else  {
                  [self progressHide:responseObject[@"message"] time:1.0];
              }
              sucessBlock(operation,responseObject);
          } failure:^(AFHTTPRequestOperation *operation, NSError *error) {
              DLog(@"%@", operation.response);
              [self failureWithPrograss:1.0];
              if (failBlock) failBlock(operation, error);
          }];
    return nil;
}

-(void)progressHide:(NSString *)message time:(NSTimeInterval)delay {
    _hud.mode = MBProgressHUDModeText;
    _hud.labelText = message;
    [_hud hide:YES afterDelay:delay];
}

-(void)failureWithPrograss:(NSTimeInterval)delay {
    _hud.mode = MBProgressHUDModeCustomView;
    _hud.labelText = PromptMessage;
    [_hud hide:YES afterDelay:delay];
}

/**
 *  AFNetWorking Request Method With Images
 *  次方法暂未用到（未调试过）
 *  @param url         地址
 *  @param params      参数
 *  @param dataArray   图片数组
 *  @param sucessBlock 成功block
 *  @param failBlock   失败block
 *
 *  @return nil 
 */
-(id)requestWithUrl:(NSString *)url params:(NSMutableDictionary *)params dataArray:(NSArray *)dataArray postSucessBlock:(PostSucessBlock)postSucessBlock postFailBlock:(PostFailureBlock)postFailBlock
{
    NSMutableURLRequest *request =[NSMutableURLRequest requestWithURL:[NSURL URLWithString:url]];
    [[AFHTTPRequestSerializer serializer] multipartFormRequestWithMethod:@"POST" URLString:url parameters:params constructingBodyWithBlock:^(id<AFMultipartFormData> formData) {
           for (NSInteger i = 0; i<[dataArray count]; i++) {
               [formData appendPartWithFileData:dataArray[i]
                                           name:[NSString stringWithFormat:@"piclst[]"]
                                       fileName:[NSString stringWithFormat:@"image%ld.jpg",(long)i]
                                       mimeType:@"image/jpg"];
           }
       }error:nil];
    
    AFURLSessionManager *manager = [[AFURLSessionManager alloc]initWithSessionConfiguration:[NSURLSessionConfiguration defaultSessionConfiguration]];
    NSProgress *progress = nil;
    
    NSURLSessionUploadTask *uploadTask = [manager uploadTaskWithStreamedRequest:request progress:&progress completionHandler:^(NSURLResponse *response, id responseObject, NSError *error) {
              if (error) {
              DLog(@"error:%@", error);
              postFailBlock(response,responseObject,error);
          }
          else {
              DLog(@"response:%@", responseObject);
              postSucessBlock(response,responseObject,error);
          }
    }];
    [uploadTask resume];
    return nil;
}

@end

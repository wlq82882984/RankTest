//
//  PlistDao.m
//  RomanticAppiontment
//
//  Created by baichun on 15-2-11.
//  Copyright (c) 2015年 baichun. All rights reserved.
//

#import "PlistDao.h"

@implementation PlistDao

static PlistDao *g_instance = nil;

+ (PlistDao *)sharedInstance
{
    @synchronized(self) {
        if ( g_instance == nil ) {
            g_instance = [[self alloc] init];
        }
    }
    return g_instance;
}


//获得plist路径
+(NSString*)getPlistPath:(NSString *)plistName{
    //沙盒中的文件路径
    NSArray *storeFilePath = NSSearchPathForDirectoriesInDomains(NSDocumentDirectory, NSUserDomainMask, YES);
    NSString *doucumentsDirectiory = [storeFilePath objectAtIndex:0];
    NSString *plistPath =[doucumentsDirectiory stringByAppendingPathComponent:plistName];       //根据需要更改文件名
    return plistPath;
}

//判断沙盒中名为plistname的文件是否存在
+(BOOL) isPlistFileExists:(NSString *)plistName{
    
    NSString *plistPath =[PlistDao getPlistPath:plistName];
   
    NSFileManager *fileManager = [NSFileManager defaultManager];
    if( [fileManager fileExistsAtPath:plistPath]== NO ) {
        NSLog(@"not exists");
        return NO;
    }else{
        return YES;
    }
    
}

+(void)initPlist :(NSString *)plistName{
    NSString *plistPath =[PlistDao getPlistPath:plistName];
    
      NSArray *nameArray=[plistName componentsSeparatedByString:@"."];
    
    //如果plist文件不存在，将工程中已建起的plist文件写入沙盒中
    if (![PlistDao isPlistFileExists:plistName]) {
        
        //从自己建立的plist文件 复制到沙盒中 ，方法一
        NSError *error;
        NSFileManager *fileManager = [NSFileManager defaultManager];
        NSString *bundle = [[NSBundle mainBundle] pathForResource:nameArray[0] ofType:@"plist"];
        [fileManager copyItemAtPath:bundle toPath:plistPath error:&error];
        
        //方法二
        //        NSString *path = [[NSBundle mainBundle] pathForResource:@"WBBooks"ofType:@"plist"];
        //        NSMutableDictionary *activityDics = [[NSMutableDictionary alloc] initWithContentsOfFile:path];
        //        [activityDics writeToFile:plistPath atomically:YES];
    }
}

//判断key的值是否存在
+(BOOL)isExistsForKey:(NSString*)key plistNameStr:(NSString *)plistName{
    NSString *plistPath =[PlistDao getPlistPath:plistName];
    NSMutableDictionary *dictionary = [[NSMutableDictionary alloc] initWithContentsOfFile:plistPath];
    //根目录下存在名为bookname的字典
    if ([dictionary objectForKey:key]) {
        return YES;
    }else{
        return NO;
    }
}

//根据key值删除对应书籍
+(void)removeBookWithKey:(NSString *)key plistNameStr:(NSString *)plistName{
    
    NSString *plistPath =[PlistDao getPlistPath:plistName];
    NSMutableDictionary *dictionary = [[NSMutableDictionary alloc] initWithContentsOfFile:plistPath];
    [dictionary removeObjectForKey:key];
    [dictionary writeToFile:plistPath atomically:YES]; //删除后重新写入
}

//删除plistPath路径对应的文件
+(void)deletePlist:(NSString *)plistName{
    
    NSFileManager *fileManager = [NSFileManager defaultManager];
    NSString *plistPath =[PlistDao getPlistPath:plistName];
    [fileManager removeItemAtPath:plistPath error:nil];
    
}

//将dictionary写入plist文件，前提：dictionary已经准备好
+(void)writePlist:(NSMutableDictionary*)dictionary forKey:(NSString *)key plistNameStr:(NSString *)plistName{
    NSMutableDictionary *plistDictionary = [[NSMutableDictionary alloc]init];
    //如果已存在则读取现有数据
    if ([PlistDao isPlistFileExists:plistName]) {
        plistDictionary = [PlistDao readPlist:plistName];
    }
    
    //增加一个数据
    [plistDictionary setValue:dictionary forKey:key]; //在plistDictionary增加一个key为...的value
    
    NSString *plistPath =[PlistDao getPlistPath:plistName];
    
    if([plistDictionary writeToFile:plistPath atomically:YES]){
        NSLog(@"write ok!");
    }else{
        NSLog(@"write error");
    }
}

+(void)writeObjPlist:(id)obj forKey:(NSString *)key plistNameStr:(NSString *)plistName{
    NSMutableDictionary *plistDictionary = [[NSMutableDictionary alloc]init];
    //如果已存在则读取现有数据
    if ([PlistDao isPlistFileExists:plistName]) {
        plistDictionary = [PlistDao readPlist:plistName];
    }
    
    //增加一个数据
    [plistDictionary setValue:obj forKey:key]; //在plistDictionary增加一个key为...的value
    
    NSString *plistPath =[PlistDao getPlistPath:plistName];
    
    if([plistDictionary writeToFile:plistPath atomically:YES]){
        NSLog(@"write ok!");
    }else{
        NSLog(@"ddd");
    }
}

//
+(NSMutableDictionary*)readPlist:(NSString *)plistName{
    
    NSString *plistPath =[PlistDao getPlistPath:plistName];
    NSMutableDictionary *resultDictionary = [[NSMutableDictionary alloc]initWithContentsOfFile:plistPath];
    return resultDictionary;
}

/*读取指定key的内容*/
+(NSMutableDictionary *)readKeyDictionary:(NSString *)plistName key:(NSString *)key{
    NSString *plistPath =[PlistDao getPlistPath:plistName];
    
    NSMutableDictionary *applist = [[[NSMutableDictionary alloc]initWithContentsOfFile:plistPath]mutableCopy];
    
    NSMutableDictionary *result = [applist objectForKey:key];    
    return result;
}

//读取plist文件内容复制给dictionary   备用
+(void)readPlist:(NSMutableDictionary **)dictionary plistNameStr:(NSString *)plistName{
    NSString *plistPath =[PlistDao getPlistPath:plistName];
    *dictionary = [[NSMutableDictionary alloc] initWithContentsOfFile:plistPath];
}

//更改一条数据，就是把dictionary内key重写
+(void)replaceDictionary:(NSMutableDictionary *)newDictionary withDictionaryKey:(NSString *)key plistNameStr:(NSString *)plistName{
    [PlistDao removeBookWithKey:key plistNameStr:plistName];
    [PlistDao writePlist:newDictionary forKey:key plistNameStr:plistName];
    //    [[PlistDao sharedInstance]writePlist:newDictionary forKey:key];
    
}

+(NSInteger)getCount:(NSString *)plistName{
    
    NSMutableDictionary *dictionary = [[NSMutableDictionary alloc] init];
//    dictionary = [[WBBooksManager sharedInstance] readPlist];
    dictionary=[PlistDao readPlist:plistName];
    return [dictionary count];
    
}




@end

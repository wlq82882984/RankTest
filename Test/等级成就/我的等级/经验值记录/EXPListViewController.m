//
//  EXPListViewController.m
//  Test
//
//  Created by wlq on 2018/6/21.
//  Copyright © 2018年 wlq. All rights reserved.
//   https://api.meditool.cn/Apigrade/exprecords?userid={int}&usertoken={string}&cpage={int}  经验值记录
//    userid=2686&usertoken=208e3cc19b90794e8bded9cccfbe302d

#import "EXPListViewController.h"
#import "EXPlView.h"
#import "UtilString.h"
#import "Request.h"
#import "EXPPlistTableViewCell.h"
#define WIDTH [[UIScreen mainScreen]bounds].size.width
#define HEIGHT [[UIScreen mainScreen]bounds].size.height

@interface EXPListViewController ()<UITableViewDelegate,UITableViewDataSource>{
    UITableView       *mainTab;
    
    NSMutableArray    *expList;
    int                page;
}

@end

@implementation EXPListViewController

- (void)viewDidLoad {
    [super viewDidLoad];
    
    page = 1;
    mainTab = [[UITableView alloc]init];
    mainTab.frame = CGRectMake(0, 0, WIDTH, HEIGHT);
    mainTab.delegate = self;
    mainTab.dataSource = self;
    [self.view addSubview:mainTab];
    mainTab.tableHeaderView = [self drawHeadView];

    [self getdata];
}

- (void)loadMore{
    page++;
    
}

- (void)reloadData{
    page = 1;
    
}



- (UIView *)drawHeadView{
    EXPlView *epv = [[EXPlView alloc]init];
    epv.model = _mygrade;

    return epv;
}

- (void)getdata{
    Request *re = [Request shareInstance];
    
    NSMutableDictionary *dict = [NSMutableDictionary dictionary];
    [dict setObject:@"2421" forKey:@"user_id"];   // 2421
    [dict setObject:@"" forKey:@"usertoken"];    //505efe40adda1ac1c4b70097cd022bf2
    
    NSString *urlStr = @"https://api.meditool.cn/Apigrade/exprecords?userid=2421&usertoken=bcd907f30da4fc66eb933dc7b808fb84";
    [re GetRequestWithUrl:urlStr params:nil sucessBlock:^(AFHTTPRequestOperation *operation, id responseObject) {
        NSDictionary *dict = [responseObject objectForKey:@"data"];
        
        
        
        
        
        
        
        
        
        
        
        
        
        
        
        
        
        
        
        [mainTab reloadData];
    } failBlock:^(AFHTTPRequestOperation *operation, NSError *eror) {
        
    }];
    
}

- (nonnull UITableViewCell *)tableView:(nonnull UITableView *)tableView cellForRowAtIndexPath:(nonnull NSIndexPath *)indexPath {
    EXPPlistTableViewCell *cell = [tableView dequeueReusableCellWithIdentifier:@"expcelll"];
    cell.selectionStyle = UITableViewCellSelectionStyleNone;
    if (!cell) {
        cell = [[EXPPlistTableViewCell alloc]initWithStyle:UITableViewCellStyleDefault reuseIdentifier:@"expcelll"];
    }
    
    return cell;
}

- (NSInteger)tableView:(UITableView *)tableView numberOfRowsInSection:(NSInteger)section {
    return expList.count;
}

- (CGFloat)tableView:(UITableView *)tableView heightForRowAtIndexPath:(NSIndexPath *)indexPath{
    return 80;
}

- (void)tableView:(UITableView *)tableView didSelectRowAtIndexPath:(NSIndexPath *)indexPath{
    
}

- (NSInteger)numberOfSectionsInTableView:(UITableView *)tableView{
    return 1;
}



@end

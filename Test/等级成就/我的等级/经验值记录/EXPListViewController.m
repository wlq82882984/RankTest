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

@interface EXPListViewController ()<UITableViewDelegate,UITableViewDataSource,UIWebViewDelegate>{
    UITableView       *mainTab;
    
    NSMutableArray    *expList;
    int                page;
}

@end

@implementation EXPListViewController

- (void)back{
    [self.navigationController popViewControllerAnimated:YES];
}

- (void)viewDidLoad {
    [super viewDidLoad];
    
    self.navigationItem.leftBarButtonItem = [[UIBarButtonItem alloc]initWithImage:[UIImage imageNamed:@"back_icon"] style:UIBarButtonItemStyleDone target:self action:@selector(back)];
    self.navigationItem.leftBarButtonItem.tintColor = [UIColor blueColor];
    self.navigationController.navigationBar.shadowImage = nil;
    
    UIButton *btn = [[UIButton alloc]init];
    [btn setImage:[UIImage imageNamed:@"icon_yiwen_b"] forState:UIControlStateNormal];
    [btn setImageEdgeInsets:UIEdgeInsetsMake(10, 15, 10, -15)];
    btn.imageView.contentMode = UIViewContentModeScaleAspectFit;
    [btn addTarget:self action:@selector(gotoWeb) forControlEvents:UIControlEventTouchUpInside];
    self.navigationItem.rightBarButtonItem = [[UIBarButtonItem alloc]initWithCustomView:btn];
    self.navigationItem.rightBarButtonItem.tintColor = [UIColor blueColor];
    self.navigationController.navigationBar.shadowImage = nil;
    
    expList = [NSMutableArray new];
    self.title = @"经验值记录";
    page = 1;
    mainTab = [[UITableView alloc]initWithFrame:CGRectMake(0, 0, WIDTH, HEIGHT) style:UITableViewStyleGrouped];
    mainTab.delegate = self;
    mainTab.dataSource = self;
    [self.view addSubview:mainTab];
    mainTab.tableHeaderView = [self drawHeadView];
    [mainTab registerNib:[UINib nibWithNibName:@"EXPPlistTableViewCell" bundle:nil] forCellReuseIdentifier:@"expcell"];
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
    
    NSString *urlStr =@"http://apitest.meditool.cn/Apigrade/exprecords?userid=593553&usertoken=81d39cb3e9167c24e1bd340f2944594b&cpage=1";
    [re GetRequestWithUrl:urlStr params:nil sucessBlock:^(AFHTTPRequestOperation *operation, id responseObject) {
        NSMutableArray *dict = [responseObject objectForKey:@"data"];
        if (page == 1) {
            [expList removeAllObjects];
        }
        [dict enumerateObjectsUsingBlock:^(id  _Nonnull obj, NSUInteger idx, BOOL * _Nonnull stop) {
            [expList addObject:obj];
        }];
      
        
        
        [mainTab reloadData];
    } failBlock:^(AFHTTPRequestOperation *operation, NSError *eror) {
        
    }];
}

//前往游戏规则 这里到时候就调用webvc界面就行
- (void)gotoWeb{
    UIWebView *vc = [[UIWebView alloc]init];
    vc=[[UIWebView alloc]initWithFrame:CGRectMake(0, 0, WIDTH, HEIGHT)];
    vc.delegate = self;
    vc.scalesPageToFit = YES;
    [vc loadRequest:[NSURLRequest requestWithURL:[NSURL URLWithString:_urlstr]]];
    
    UIViewController *dd = [[UIViewController alloc]init];
    dd.title = @"升级说明";
    dd.navigationItem.leftBarButtonItem = [[UIBarButtonItem alloc]initWithImage:[UIImage imageNamed:@"back_icon"] style:UIBarButtonItemStyleDone target:self action:@selector(goback)];
    dd.navigationItem.leftBarButtonItem.tintColor = [UIColor blueColor];
    [dd.view addSubview:vc];
    
    [self.navigationController pushViewController:dd animated:YES];
}

- (void)goback{
    int i = (int)[self.navigationController viewControllers].count;
    [self.navigationController popToViewController:[self.navigationController viewControllers][i-2] animated:YES];
}

- (nonnull UITableViewCell *)tableView:(nonnull UITableView *)tableView cellForRowAtIndexPath:(nonnull NSIndexPath *)indexPath {
    EXPPlistTableViewCell *cell = [tableView dequeueReusableCellWithIdentifier:@"expcell"];
    cell.selectionStyle = UITableViewCellSelectionStyleNone;
    NSMutableDictionary *model = expList[indexPath.row];
    if (!cell) {
        cell = [[EXPPlistTableViewCell alloc]initWithStyle:UITableViewCellStyleDefault reuseIdentifier:@"expcell"];
    }
    
    [cell.expName setText:[model objectForKey:@"TaskName"]];
    [cell.dateLab setText:[UtilString getTimeFormmatterHMS:[model objectForKey:@"CreateTime"] formatStr:@"yyyy-MM-dd    hh : mm"]];
    [cell.numLab setText:[NSString stringWithFormat:@"+ %@",[model objectForKey:@"ExpNum"]]];
    
    return cell;
}

- (NSInteger)tableView:(UITableView *)tableView numberOfRowsInSection:(NSInteger)section {
    return expList.count;
}

- (CGFloat)tableView:(UITableView *)tableView heightForRowAtIndexPath:(NSIndexPath *)indexPath{
    return 70;
}

- (UIView *)tableView:(UITableView *)tableView viewForHeaderInSection:(NSInteger)section{
    UIView *hh = [[UIView alloc]initWithFrame:CGRectMake(0, 0, 22222, 15)];
    hh.backgroundColor = [UIColor lightGrayColor];
    return  hh;
}

- (CGFloat)tableView:(UITableView *)tableView heightForFooterInSection:(NSInteger)section{
    return 10;
}

- (void)tableView:(UITableView *)tableView didSelectRowAtIndexPath:(NSIndexPath *)indexPath{
    
}

- (NSInteger)numberOfSectionsInTableView:(UITableView *)tableView{
    return 1;
}



@end

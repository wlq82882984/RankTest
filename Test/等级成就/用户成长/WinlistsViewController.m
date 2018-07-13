//
//  WinlistsViewController.m
//  Test
//
//  Created by wlq on 2018/6/25.
//  Copyright © 2018年 wlq. All rights reserved.
//

#import "WinlistsViewController.h"
#import "AddWinlistsViewController.h"
#define WIDTH [[UIScreen mainScreen]bounds].size.width
#define height [[UIScreen mainScreen]bounds].size.height
#import "Request.h"

@interface WinlistsViewController ()<UITableViewDelegate,UITableViewDataSource>{
    UITableView      *mainTab;
    int       page;
    
}


@end

@implementation WinlistsViewController

-(void)back{
    [self dismissViewControllerAnimated:YES completion:^{
    }];
}

- (void)getwils{
    Request *re = [Request shareInstance];
    
    [re GetRequestWithUrl:@"http://apitest.meditool.cn/Apiuserv2/getuserdetail?userid=593553&usertoken=81d39cb3e9167c24e1bd340f2944594b&calltype=0" params:nil sucessBlock:^(AFHTTPRequestOperation *operation, id responseObject) {
        NSDictionary *as = [responseObject objectForKey:@"data"];
        NSArray *arr = [as objectForKey:@"SchoolData"];
        for (NSDictionary *model in arr) {
            if ([[model objectForKey:@"DataType"] intValue] == 3) {
                [_dataArr addObject:model];
            }
        }
        [self drawTable];
    } failBlock:^(AFHTTPRequestOperation *operation, NSError *eror) {
    }];
}

- (void)viewDidLoad {
    [super viewDidLoad];
    self.title = @"获奖记录";
    self.navigationItem.leftBarButtonItem = [[UIBarButtonItem alloc]initWithImage:[UIImage imageNamed:@"back_icon"] style:UIBarButtonItemStyleDone target:self action:@selector(back)];
    self.navigationItem.leftBarButtonItem.tintColor = [UIColor blackColor];
    self.navigationItem.rightBarButtonItem = [[UIBarButtonItem alloc]initWithTitle:@"添加" style:UIBarButtonItemStyleDone target:self action:@selector(addBtn)];
    self.navigationItem.rightBarButtonItem.tintColor = [UIColor colorWithRed:0.149 green:0.663 blue:0.914 alpha:1.000];
    _dataArr = [NSMutableArray new];
    [self getwils];
    
}

- (void)addBtn{
    AddWinlistsViewController *test = [[AddWinlistsViewController alloc]init];
    [self.navigationController pushViewController:test animated:YES];
}

- (void)drawTable{
    mainTab = [[UITableView alloc]initWithFrame:CGRectMake(0, 0, WIDTH, height) style:UITableViewStylePlain];
    [self.view addSubview: mainTab];
    mainTab.delegate = self;
    mainTab.dataSource = self;
}

- (void)getData:(int)page{
    
}

- (CGFloat)tableView:(UITableView *)tableView heightForRowAtIndexPath:(NSIndexPath *)indexPath{
    return 60;
}

- (NSInteger)tableView:(UITableView *)tableView numberOfRowsInSection:(NSInteger)section{
    return _dataArr.count;
}

- (NSInteger)numberOfSectionsInTableView:(UITableView *)tableView{
    return 1;
}

- (UITableViewCell *)tableView:(UITableView *)tableView cellForRowAtIndexPath:(NSIndexPath *)indexPath{
    static NSString * cellID=@"cellID";
    UITableViewCell * cell=[tableView dequeueReusableCellWithIdentifier:cellID];
    NSDictionary *model = _dataArr[indexPath.row];
    
    if (cell==nil) {
        cell=[[UITableViewCell alloc]initWithStyle:UITableViewCellStyleSubtitle reuseIdentifier:cellID];
    }
    cell.selectionStyle = UITableViewCellSelectionStyleNone;
    cell.textLabel.text = [model objectForKey:@"UserMajor"];
    cell.detailTextLabel.text = [NSString stringWithFormat:@"%@年",[model objectForKey:@"GraduateTime"]];
    cell.detailTextLabel.textColor = [UIColor lightGrayColor];
    return cell;
}

@end

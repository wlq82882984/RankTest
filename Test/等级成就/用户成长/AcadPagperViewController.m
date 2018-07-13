//
//  AcadPagperViewController.m
//  Test
//
//  Created by wlq on 2018/6/25.
//  Copyright © 2018年 wlq. All rights reserved.
//

#import "AcadPagperViewController.h"
#import "AddAcadPaperViewController.h"
#import "Request.h"
#define WIDTH [[UIScreen mainScreen]bounds].size.width
#define height [[UIScreen mainScreen]bounds].size.height

@interface AcadPagperViewController ()<UITableViewDelegate,UITableViewDataSource>{
    UITableView      *mainTab;

    int       page;
}

@end

@implementation AcadPagperViewController

-(void)back{
    [self dismissViewControllerAnimated:YES completion:^{
    }];
}

- (void)getpap{
    Request *re = [Request shareInstance];
    
    [re GetRequestWithUrl:@"http://apitest.meditool.cn/Apiuserv2/getuserdetail?userid=593553&usertoken=81d39cb3e9167c24e1bd340f2944594b&calltype=0" params:nil sucessBlock:^(AFHTTPRequestOperation *operation, id responseObject) {
        NSDictionary *as = [responseObject objectForKey:@"data"];
        NSArray *arr = [as objectForKey:@"SchoolData"];
        for (NSDictionary *model in arr) {
            if ([[model objectForKey:@"DataType"] intValue] == 2) {
                [_dataArr addObject:model];
            }
        }
        _dataArr=(NSMutableArray *)[[_dataArr reverseObjectEnumerator] allObjects];
        [self drawTable];
    } failBlock:^(AFHTTPRequestOperation *operation, NSError *eror) {
    }];
}

- (void)viewDidLoad {
    [super viewDidLoad];
    self.title = @"学术论文";
    self.navigationItem.leftBarButtonItem = [[UIBarButtonItem alloc]initWithImage:[UIImage imageNamed:@"back_icon"] style:UIBarButtonItemStyleDone target:self action:@selector(back)];
    self.navigationItem.rightBarButtonItem = [[UIBarButtonItem alloc]initWithTitle:@"添加" style:UIBarButtonItemStyleDone target:self action:@selector(addBtn)];
    _dataArr = [NSMutableArray new];
    
    [self getpap];
}

- (void)addBtn{
    AddAcadPaperViewController *test = [[AddAcadPaperViewController alloc]init];
    [self.navigationController pushViewController:test animated:NO];
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
    NSArray *mm = [[model objectForKey:@"UserMajor"] componentsSeparatedByString:@";"];
    
    if (cell==nil) {
        cell=[[UITableViewCell alloc]initWithStyle:UITableViewCellStyleSubtitle reuseIdentifier:cellID];
    }
    cell.selectionStyle = UITableViewCellSelectionStyleNone;
    cell.textLabel.text = mm[0];
    cell.textLabel.font = [UIFont systemFontOfSize:15];
    cell.detailTextLabel.text = [NSString stringWithFormat:@"%@ %@",mm[1],mm[2]];
    cell.detailTextLabel.textColor = [UIColor lightGrayColor];
    return cell;
}


@end

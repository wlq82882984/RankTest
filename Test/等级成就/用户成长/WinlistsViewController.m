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

@interface WinlistsViewController ()<UITableViewDelegate,UITableViewDataSource>{
    UITableView      *mainTab;
    
    NSMutableArray   *dataArr;
    int       page;
    
}


@end

@implementation WinlistsViewController

-(void)back{
    [self dismissViewControllerAnimated:YES completion:^{
    }];
}

- (void)viewDidLoad {
    [super viewDidLoad];
    self.title = @"获奖记录";
    self.navigationItem.leftBarButtonItem = [[UIBarButtonItem alloc]initWithImage:[UIImage imageNamed:@"back_icon"] style:UIBarButtonItemStyleDone target:self action:@selector(back)];
    self.navigationItem.rightBarButtonItem = [[UIBarButtonItem alloc]initWithTitle:@"添加" style:UIBarButtonItemStyleDone target:self action:@selector(addBtn)];
    dataArr = [NSMutableArray new];
    
    
    [self drawTable];
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
    return 10;
}

- (NSInteger)numberOfSectionsInTableView:(UITableView *)tableView{
    return 1;
}

- (UITableViewCell *)tableView:(UITableView *)tableView cellForRowAtIndexPath:(NSIndexPath *)indexPath{
    static NSString * cellID=@"cellID";
    UITableViewCell * cell=[tableView dequeueReusableCellWithIdentifier:cellID];
    
    if (cell==nil) {
        cell=[[UITableViewCell alloc]initWithStyle:UITableViewCellStyleSubtitle reuseIdentifier:cellID];
    }
    cell.selectionStyle = UITableViewCellSelectionStyleNone;
    cell.textLabel.text = @"大中华CXXNB医院";
    cell.detailTextLabel.text = @"20155asasas";
    cell.detailTextLabel.textColor = [UIColor lightGrayColor];
    return cell;
}

@end

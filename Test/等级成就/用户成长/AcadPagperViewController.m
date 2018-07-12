//
//  AcadPagperViewController.m
//  Test
//
//  Created by wlq on 2018/6/25.
//  Copyright © 2018年 wlq. All rights reserved.
//

#import "AcadPagperViewController.h"
#import "AddAcadPaperViewController.h"
#define WIDTH [[UIScreen mainScreen]bounds].size.width
#define height [[UIScreen mainScreen]bounds].size.height

@interface AcadPagperViewController ()<UITableViewDelegate,UITableViewDataSource>{
    UITableView      *mainTab;
    
    NSMutableArray   *dataArr;
    int       page;
}

@end

@implementation AcadPagperViewController

-(void)back{
    [self dismissViewControllerAnimated:YES completion:^{
    }];
}

- (void)viewDidLoad {
    [super viewDidLoad];
    self.title = @"学术论文";
    self.navigationItem.leftBarButtonItem = [[UIBarButtonItem alloc]initWithImage:[UIImage imageNamed:@"back_icon"] style:UIBarButtonItemStyleDone target:self action:@selector(back)];
    self.navigationItem.rightBarButtonItem = [[UIBarButtonItem alloc]initWithTitle:@"添加" style:UIBarButtonItemStyleDone target:self action:@selector(addBtn)];
    dataArr = [NSMutableArray new];
    
    
    [self drawTable];
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
    cell.textLabel.text = @"XXX在XXX的什么作用";
    cell.textLabel.font = [UIFont systemFontOfSize:15];
    cell.detailTextLabel.text = @"alloc]initWithStyle:UITableViewCellStyleSubtitle reuseIdentifier";
    cell.detailTextLabel.textColor = [UIColor lightGrayColor];
    return cell;
}


@end

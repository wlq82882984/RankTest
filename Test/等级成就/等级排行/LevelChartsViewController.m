//
//  LevelChartsViewController.m
//  Test
//
//  Created by wlq on 2018/6/20.
//  Copyright © 2018年 wlq. All rights reserved.
//

#import "LevelChartsViewController.h"
#import "MyaappCV.h"
#import "ExpLevelTableViewCell.h"
#define WIDTH [[UIScreen mainScreen]bounds].size.width
#define HEIGHT [[UIScreen mainScreen]bounds].size.height

@interface LevelChartsViewController ()<UIScrollViewDelegate,UITableViewDelegate,UITableViewDataSource>{
    NSMutableArray         *allListArray;             //总排行
    NSMutableArray         *frendsListArray;          //好友排行
    
    UIView                 *headView;
    UISegmentedControl     *segmented;
    
    UIScrollView           *scrollerView;
    UITableView            *allTable;
    UITableView            *frendsTable;
    
    UILabel           *front;       //排名
    UIImageView       *iconPic;     //用户头像
    UILabel           *nickName;
    UILabel           *levelLab;     //等级
    UILabel           *expLab;       //经验
    
    int                page;
    int                currentTableIndex;
    
    MyaappCV          *firplace;   //第一
    MyaappCV          *seplace;    //第二
    MyaappCV          *thplace;    //第三
    
}

@end

@implementation LevelChartsViewController

- (void)viewDidLoad {
    [super viewDidLoad];
    
    self.view.backgroundColor = [UIColor lightGrayColor];
    self.title = @"等级排行榜";
    self.navigationController.navigationBar.translucent = NO;
    self.navigationItem.leftBarButtonItem = [[UIBarButtonItem alloc]initWithImage:[UIImage imageNamed:@"back_icon"] style:UIBarButtonItemStyleDone target:self action:@selector(back)];
    self.navigationItem.leftBarButtonItem.tintColor = [UIColor blackColor];
    
    [self setHeadView];
    allListArray = [NSMutableArray new];
    frendsListArray = [NSMutableArray new];
    currentTableIndex = 0;
    page = 1;
    self.automaticallyAdjustsScrollViewInsets = NO;
    [self initScrollerView];
    [self initTableViews];
//    [self getdatawithType:0 andPage:1];
    
    
    
    
    
    
    
    
    
    
    
}

- (void)back{
        [self dismissViewControllerAnimated:YES completion:^{
            NSLog(@"去");
        }];
    }

//   皇冠(50,65)
- (void)setHeadView{
    float h = 270;
    headView = [[UIView alloc]init];
    headView.frame = CGRectMake(0, 0, WIDTH, h);
    headView.backgroundColor = [UIColor whiteColor];
    
    segmented = [[UISegmentedControl alloc]initWithItems:@[@"全部",@"好友"]];
    [segmented setFrame:CGRectMake(80, 10, WIDTH - 160, 30)];
    segmented.layer.masksToBounds = YES;
    segmented.layer.cornerRadius = 15;
    segmented.layer.borderWidth = 1;
    segmented.layer.borderColor = [UIColor lightGrayColor].CGColor; 
    [segmented setTintColor:[UIColor lightGrayColor]];
    [segmented setSelectedSegmentIndex:0];
    
    [segmented addTarget:self action:@selector(segmentedControlChangedValue:) forControlEvents:UIControlEventPrimaryActionTriggered];
    [segmented setTitleTextAttributes:@{NSFontAttributeName:[UIFont fontWithName:@"TimesNewRomanPS-BoldItalicMT" size:16.0]} forState:UIControlStateNormal];
    [headView addSubview:segmented];
    
    // 皇冠图标  随状态改变
    firplace = [[MyaappCV alloc]init];
    [firplace.vv setImage:[UIImage imageNamed:@"icon_phb_first"]];   //   icon_phb_second     icon_phb_third
    firplace.frame =CGRectMake(0, 22, 80, 104);
    firplace.center = CGPointMake(WIDTH/2, 180 - 80);
    firplace.h = 104;
    firplace.x = 12;
    firplace.w = 80;
    [firplace.headvv setImage:[UIImage imageNamed:@"4"]];
    [headView addSubview:firplace];
    
    seplace = [[MyaappCV alloc]init];
    [seplace.vv setImage:[UIImage imageNamed:@"icon_phb_second"]];
    seplace.frame =CGRectMake(0, 22, 60, 78);
    seplace.center = CGPointMake(WIDTH/4, 180 - 70);
    seplace.h = 78;
    seplace.x = 8;
    seplace.w = 60;
    [seplace.headvv setImage:[UIImage imageNamed:@"4"]];
    [headView addSubview:seplace];
    
    thplace = [[MyaappCV alloc]init];
    [thplace.vv setImage:[UIImage imageNamed:@"icon_phb_third"]];
    thplace.frame =CGRectMake(0, 22, 60, 78);
    thplace.center = CGPointMake(WIDTH*3/4, 180 - 70);
    thplace.h = 78;
    thplace.x = 8;
    thplace.w = 60;
    [thplace.headvv setImage:[UIImage imageNamed:@"4"]];
    [headView addSubview:thplace];
    
    // 用户信息
    front = [[UILabel alloc]init];
    front.frame = CGRectMake(10, 232, 30, 15);
    front.backgroundColor = [UIColor whiteColor];
    front.text = @"0";
    front.textColor = [UIColor blackColor];
    front.font = [UIFont systemFontOfSize:14];
    front.textAlignment = NSTextAlignmentCenter;
    
    iconPic = [[UIImageView alloc]init];
    iconPic.frame = CGRectMake(40, 220, 40, 40);
    iconPic.backgroundColor = [UIColor whiteColor];
    [iconPic setImage:[UIImage imageNamed:@"4"]];
    iconPic.layer.cornerRadius = 20;
    
    nickName = [[UILabel alloc]init];
    nickName.frame = CGRectMake(85, 230, 80, 16);
    nickName.backgroundColor = [UIColor whiteColor];
    nickName.text = @"自己";
    nickName.textColor = [UIColor blackColor];
    nickName.font = [UIFont systemFontOfSize:16];
    nickName.textAlignment = NSTextAlignmentLeft;
    
    levelLab = [[UILabel alloc]init];
    levelLab.frame = CGRectMake(180, 230, 50, 15);
    levelLab.backgroundColor = [UIColor whiteColor];
    levelLab.text = @"LV.1";
    levelLab.textColor = [UIColor blackColor];
    levelLab.font = [UIFont systemFontOfSize:14];
    levelLab.textAlignment = NSTextAlignmentCenter;
    
    expLab = [[UILabel alloc]init];
    expLab.frame = CGRectMake(WIDTH - 100, 230, 90, 15);
    expLab.backgroundColor = [UIColor whiteColor];
    expLab.text = @"0";
    expLab.textColor = [UIColor blackColor];
    expLab.font = [UIFont systemFontOfSize:14];
    expLab.textAlignment = NSTextAlignmentRight;

    [headView addSubview:front];
    [headView addSubview:iconPic];
    [headView addSubview:nickName];
    [headView addSubview:levelLab];
    [headView addSubview:expLab];
    [self.view addSubview:headView];
}

- (void)initScrollerView{
    scrollerView = [[UIScrollView alloc]initWithFrame:CGRectMake(0, 280, WIDTH, HEIGHT -280-64)];
    scrollerView.delegate = self;
    scrollerView.backgroundColor = [UIColor whiteColor];
    CGSize size = CGSizeMake(WIDTH*2 ,200);
    scrollerView.contentSize = size;
    scrollerView.showsHorizontalScrollIndicator = NO;
    scrollerView.directionalLockEnabled = YES;
    scrollerView.pagingEnabled = YES;
    scrollerView.bounces = NO;
    [scrollerView setDelaysContentTouches:NO];
    [scrollerView setCanCancelContentTouches:NO];
    [self.view addSubview:scrollerView];
}


- (void)segmentedControlChangedValue:(UISegmentedControl *)segment{
    currentTableIndex = @(segment.selectedSegmentIndex).intValue;
    switch (segment.selectedSegmentIndex){
        case 0:
            [scrollerView scrollRectToVisible:allTable.frame animated:YES];
            break;
        case 1:
            [scrollerView scrollRectToVisible:frendsTable.frame animated:YES];
            break;
        default:
            break;
    }
}

- (void)scrollViewDidScroll:(UIScrollView *)scrollView{
    currentTableIndex = scrollerView.bounds.origin.x/scrollerView.bounds.size.width;
    [segmented setSelectedSegmentIndex:currentTableIndex];
    if (currentTableIndex == 0) {
    }else{
    }
}

- (void)initTableViews{
    // all排行
    allTable = [[UITableView alloc]initWithFrame:CGRectMake(0, 0, WIDTH, HEIGHT -280-64) style:UITableViewStyleGrouped];
    allTable.backgroundColor = [UIColor redColor];
    allTable.delegate = self;
    allTable.dataSource = self;
    allTable.sectionHeaderHeight = 0;
    allTable.sectionFooterHeight = 0;
    allTable.separatorStyle = UITableViewCellSeparatorStyleNone;
    [scrollerView addSubview:allTable];
    [allTable registerNib:[UINib nibWithNibName:@"ExpLevelTableViewCell" bundle:nil] forCellReuseIdentifier:@"expcell"];
    // 友排行
    frendsTable = [[UITableView alloc]initWithFrame:CGRectMake(WIDTH, 0, WIDTH, HEIGHT -280-64) style:UITableViewStyleGrouped];
    frendsTable.backgroundColor = [UIColor blueColor];
    frendsTable.delegate = self;
    frendsTable.dataSource = self;
    frendsTable.sectionHeaderHeight = 0;
    frendsTable.sectionFooterHeight = 0;
    frendsTable.separatorStyle = UITableViewCellSeparatorStyleNone;
    [scrollerView addSubview:frendsTable];
    [frendsTable registerNib:[UINib nibWithNibName:@"ExpLevelTableViewCell" bundle:nil] forCellReuseIdentifier:@"expcell"];
    [self getdatawithType:0 andPage:1];
}

- (CGFloat)tableView:(UITableView *)tableView heightForRowAtIndexPath:(NSIndexPath *)indexPath{
    return 80;
}

- (NSInteger)tableView:(UITableView *)tableView numberOfRowsInSection:(NSInteger)section{
    return 10;
}

- (CGFloat)tableView:(UITableView *)tableView heightForHeaderInSection:(NSInteger)section{
    return 0.5;
}

- (CGFloat)tableView:(UITableView *)tableView heightForFooterInSection:(NSInteger)section{
    return 0.5;
}

- (UITableViewCell *)tableView:(UITableView *)tableView cellForRowAtIndexPath:(NSIndexPath *)indexPath{
    ExpLevelTableViewCell *cell = [tableView dequeueReusableCellWithIdentifier:@"expcell"];
    cell.selectionStyle = UITableViewCellSelectionStyleNone;
    if (!cell) {
        cell = [[ExpLevelTableViewCell alloc]initWithStyle:UITableViewCellStyleDefault reuseIdentifier:@"expcell"];
    }
    
    return cell;
    
}






//   https://api.meditool.cn/Apigrade/graderank?userid={int}&usertoken={string}&datatype={int}&cpage={int}
- (void)getdatawithType:(int)type andPage:(int)num{
    
}

@end

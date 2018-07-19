//
//  LevelChartsViewController.m
//  Test
//
//  Created by wlq on 2018/6/20.
//  Copyright © 2018年 wlq. All rights reserved.
//

#import "LevelChartsViewController.h"
#import "MyaappCV.h"
#import "Request.h"
#import "LevePersonView.h"

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
    UIImageView       *vipPic;
    UILabel           *nickName;
    UILabel           *levelLab;     //等级
    UILabel           *expLab;       //经验
    
    int                pageA;
    int                pageB;
    int                currentTableIndex;
    
    MyaappCV          *firplace;   //第一
    LevePersonView    *firlab;
    MyaappCV          *seplace;    //第二
    LevePersonView    *selab;
    MyaappCV          *thplace;    //第三
    LevePersonView    *thlab;
    
}

@end

@implementation LevelChartsViewController

- (void)back{
    [self dismissViewControllerAnimated:YES completion:^{
        NSLog(@"去");
    }];
}

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
    pageA = 1;
    pageB = 1;
    self.automaticallyAdjustsScrollViewInsets = NO;
    [self initScrollerView];
    [self initTableViews];
//    [self getdatawithType:0 andPage:1];
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
    firplace.hidden = YES;
    [firplace.vv setImage:[UIImage imageNamed:@"icon_phb_first"]];   //   icon_phb_second     icon_phb_third
    firplace.frame =CGRectMake(0, 22, 80, 104);
    firplace.center = CGPointMake(WIDTH/2, 180 - 80);
    firplace.h = 104;
    firplace.x = 12;
    firplace.w = 80;
    [firplace.headvv setImage:[UIImage imageNamed:@"4"]];
    [headView addSubview:firplace];
    
    firlab = [[LevePersonView alloc]init];
    firlab.hidden = YES;
    firlab.frame = CGRectMake(0, 22, 100, 80);
    firlab.center = CGPointMake(WIDTH/2, 190);
    [headView addSubview:firlab];
    
    seplace = [[MyaappCV alloc]init];
    seplace.hidden = YES;
    [seplace.vv setImage:[UIImage imageNamed:@"icon_phb_second"]];
    seplace.frame =CGRectMake(0, 22, 60, 78);
    seplace.center = CGPointMake(WIDTH/4, 180 - 70);
    seplace.h = 78;
    seplace.x = 8;
    seplace.w = 60;
    [seplace.headvv setImage:[UIImage imageNamed:@"4"]];
    [headView addSubview:seplace];
    
    selab = [[LevePersonView alloc]init];
    selab.hidden = YES;
    selab.frame = CGRectMake(0, 22, 100, 80);
    selab.center = CGPointMake(WIDTH/4, 190);
    [headView addSubview:selab];
    
    thplace = [[MyaappCV alloc]init];
    thplace.hidden = YES;
    [thplace.vv setImage:[UIImage imageNamed:@"icon_phb_third"]];
    thplace.frame =CGRectMake(0, 22, 60, 78);
    thplace.center = CGPointMake(WIDTH*3/4, 180 - 70);
    thplace.h = 78;
    thplace.x = 8;
    thplace.w = 60;
    [thplace.headvv setImage:[UIImage imageNamed:@"4"]];
    [headView addSubview:thplace];
    
    thlab = [[LevePersonView alloc]init];
    thlab.hidden = YES;
    thlab.frame = CGRectMake(0, 22, 100, 80);
    thlab.center = CGPointMake(WIDTH*3/4, 190);
    [headView addSubview:thlab];
    
    // 用户信息
    front = [[UILabel alloc]init];
    front.frame = CGRectMake(15, 232, 30, 15);
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
    
    vipPic = [[UIImageView alloc]init];
    vipPic.frame = CGRectMake(60, 240, 25, 25);
    vipPic.contentMode = UIViewContentModeScaleAspectFit;
    vipPic.backgroundColor = [UIColor whiteColor];
    [vipPic setImage:[UIImage imageNamed:@"accOKSet"]];
    vipPic.hidden = YES;
    vipPic.layer.cornerRadius = 20;
    
    nickName = [[UILabel alloc]init];
    nickName.frame = CGRectMake(85, 230, 100, 16);
    nickName.backgroundColor = [UIColor whiteColor];
    nickName.text = @"自己";
    nickName.textColor = [UIColor blackColor];
    nickName.font = [UIFont systemFontOfSize:15];
    nickName.textAlignment = NSTextAlignmentLeft;
    
    levelLab = [[UILabel alloc]init];
    levelLab.frame = CGRectMake(180, 230, 50, 15);
    levelLab.backgroundColor = [UIColor whiteColor];
    levelLab.text = @"LV.1";
    levelLab.textColor = [UIColor blackColor];
    levelLab.font = [UIFont systemFontOfSize:14];
    levelLab.textAlignment = NSTextAlignmentCenter;
    
    expLab = [[UILabel alloc]init];
    expLab.frame = CGRectMake(WIDTH - 100, 230, 85, 15);
    expLab.backgroundColor = [UIColor whiteColor];
    expLab.text = @"0";
    expLab.textColor = [UIColor blackColor];
    expLab.font = [UIFont systemFontOfSize:14];
    expLab.textAlignment = NSTextAlignmentRight;

    [headView addSubview:front];
    [headView addSubview:iconPic];
    [headView addSubview:vipPic];
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

// 点击“全部，好友”进行重新加载
- (void)segmentedControlChangedValue:(UISegmentedControl *)segment{
    currentTableIndex = @(segment.selectedSegmentIndex).intValue;
    switch (segment.selectedSegmentIndex){
        case 0:
            [scrollerView scrollRectToVisible:allTable.frame animated:YES];
            [self getdatawithType:0 andPage:1];
            break;
        case 1:
            [scrollerView scrollRectToVisible:frendsTable.frame animated:YES];
            [self getdatawithType:1 andPage:1];
            break;
        default:
            break;
    }
}

// 滑动就不安排加载仅仅是切换页面
- (void)scrollViewDidEndDecelerating:(UIScrollView *)scrollView{
    currentTableIndex = scrollerView.bounds.origin.x/scrollerView.bounds.size.width;
    [segmented setSelectedSegmentIndex:currentTableIndex];
    if (currentTableIndex == 0) {
        [self qiehuanWithType:0];
    }else{
        [self qiehuanWithType:1];
    }
}

- (void)qiehuanWithType:(int)i{
    if (i == 0) {
        if (allListArray.count >= 1 ) {
            //先画冠军
            NSDictionary *model = allListArray[0];
            firlab.hidden = NO;
            firplace.hidden = NO;
            [firplace.headvv setImage:[UIImage imageNamed:@"1"]];
            [firlab.leNum setText:[model objectForKey:@"GradeNum"]];
            [firlab.niName setText:[model objectForKey:@"NickName"]];
            [firlab.expNum setText:[model objectForKey:@"ExpNum"]];
            if (allListArray.count >= 2) {
                NSDictionary *model = allListArray[1];
                selab.hidden = NO;
                seplace.hidden = NO;
                [seplace.headvv setImage:[UIImage imageNamed:@"2"]];
                [selab.leNum setText:[model objectForKey:@"GradeNum"]];
                [selab.niName setText:[model objectForKey:@"NickName"]];
                [selab.expNum setText:[model objectForKey:@"ExpNum"]];
                if (allListArray.count >= 3) {
                    NSDictionary *model = allListArray[2];
                    thlab.hidden = NO;
                    thplace.hidden = NO;
                    [thplace.headvv setImage:[UIImage imageNamed:@"3"]];
                    [thlab.leNum setText:[model objectForKey:@"GradeNum"]];
                    [thlab.niName setText:[model objectForKey:@"NickName"]];
                    [thlab.expNum setText:[model objectForKey:@"ExpNum"]];
                }
            }
        }
    }else{
        if (frendsListArray.count >= 1 ) {
            //先画冠军
            NSDictionary *model = allListArray[0];
            firlab.hidden = NO;
            firplace.hidden = NO;
            [firplace.headvv setImage:[UIImage imageNamed:@"1"]];
            [firlab.leNum setText:[model objectForKey:@"GradeNum"]];
            [firlab.niName setText:[model objectForKey:@"NickName"]];
            [firlab.expNum setText:[model objectForKey:@"ExpNum"]];
            if (allListArray.count >= 2) {
                NSDictionary *model = allListArray[1];
                selab.hidden = NO;
                seplace.hidden = NO;
                [seplace.headvv setImage:[UIImage imageNamed:@"2"]];
                [selab.leNum setText:[model objectForKey:@"GradeNum"]];
                [selab.niName setText:[model objectForKey:@"NickName"]];
                [selab.expNum setText:[model objectForKey:@"ExpNum"]];
                if (allListArray.count >= 3) {
                    NSDictionary *model = allListArray[2];
                    thlab.hidden = NO;
                    thplace.hidden = NO;
                    [thplace.headvv setImage:[UIImage imageNamed:@"3"]];
                    [thlab.leNum setText:[model objectForKey:@"GradeNum"]];
                    [thlab.niName setText:[model objectForKey:@"NickName"]];
                    [thlab.expNum setText:[model objectForKey:@"ExpNum"]];
                }
            }
        }
    }
}

- (void)initTableViews{
    // all排行
    allTable = [[UITableView alloc]initWithFrame:CGRectMake(0, 0, WIDTH, HEIGHT -280-64) style:UITableViewStyleGrouped];
    allTable.backgroundColor = [UIColor whiteColor];
    allTable.delegate = self;
    allTable.dataSource = self;
    allTable.sectionHeaderHeight = 0;
    allTable.sectionFooterHeight = 0;
    allTable.separatorStyle = UITableViewCellSeparatorStyleNone;
    [scrollerView addSubview:allTable];
    [allTable registerNib:[UINib nibWithNibName:@"ExpLevelTableViewCell" bundle:nil] forCellReuseIdentifier:@"expcell"];
    // 友排行
    frendsTable = [[UITableView alloc]initWithFrame:CGRectMake(WIDTH, 0, WIDTH, HEIGHT -280-64) style:UITableViewStyleGrouped];
    frendsTable.backgroundColor = [UIColor whiteColor];
    frendsTable.delegate = self;
    frendsTable.dataSource = self;
    frendsTable.sectionHeaderHeight = 0;
    frendsTable.sectionFooterHeight = 0;
    frendsTable.separatorStyle = UITableViewCellSeparatorStyleNone;
    [scrollerView addSubview:frendsTable];
    [frendsTable registerNib:[UINib nibWithNibName:@"ExpLevelTableViewCell" bundle:nil] forCellReuseIdentifier:@"expcell"];
    [self getdatawithType:0 andPage:1];
    [self getdatawithType:1 andPage:1];
}

- (CGFloat)tableView:(UITableView *)tableView heightForRowAtIndexPath:(NSIndexPath *)indexPath{
    return 80;
}

- (NSInteger)tableView:(UITableView *)tableView numberOfRowsInSection:(NSInteger)section{
    if (tableView == allTable) {
        return allListArray.count;
    }else{
        return frendsListArray.count;
    }
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
    // idVip的hiden   默认是yes
    if (tableView == allTable) {
        NSDictionary *model = allListArray[indexPath.row];
        if ([[model objectForKey:@"IsCertification"] intValue] == 2) {
            cell.idVip.hidden = NO;
        }else{}
        [cell.paihang setText:[NSString stringWithFormat:@"%i",(int)indexPath.row+1]];
//        [cell.iconName setImage:@""];
        [cell.userName setText:[model objectForKey:@"NickName"]];
        [cell.levelNum setText:[model objectForKey:@"GradeNum"]];
        [cell.expNum setText:[model objectForKey:@"ExpNum"]];
        
    }else{
        NSDictionary *model = frendsListArray[indexPath.row];
        if ([[model objectForKey:@"IsCertification"] intValue] == 2) {
            cell.idVip.hidden = NO;
        }else{}
        [cell.paihang setText:[NSString stringWithFormat:@"%i",(int)indexPath.row+1]];
        //        [cell.iconName setImage:@""];
        [cell.userName setText:[model objectForKey:@"NickName"]];
        [cell.levelNum setText:[model objectForKey:@"GradeNum"]];
        [cell.expNum setText:[model objectForKey:@"ExpNum"]];
    }
    
    return cell;
}

//   http://apitest.meditool.cn/Apigrade/graderank?userid={int}&usertoken={string}&datatype={int}&cpage={int}
- (void)getdatawithType:(int)type andPage:(int)num{
        Request *re = [Request shareInstance];
    
        NSMutableDictionary *dict = [NSMutableDictionary dictionary];
        [dict setObject:@"2421" forKey:@"user_id"];   // 2421
        [dict setObject:@"505efe40adda1ac1c4b70097cd022bf2" forKey:@"usertoken"];    //505efe40adda1ac1c4b70097cd022bf2
    
        NSString *urlStr = [NSString stringWithFormat:@"http://apitest.meditool.cn/Apigrade/graderank?userid=593553&usertoken=81d39cb3e9167c24e1bd340f2944594b&datatype=%i&cpage=%i",type,num];
        [re GetRequestWithUrl:urlStr params:nil sucessBlock:^(AFHTTPRequestOperation *operation, id responseObject) {
            NSMutableArray *dict = [responseObject objectForKey:@"data"];
            NSDictionary *userdata = [responseObject objectForKey:@"userdata"];
//            NSArray *array = [dict objectForKey:@"grades"];
             NSLog(@"%@-----------%@",dict,userdata);
            if (type == 0) { // 全部
                if (num == 1) {
                    [allListArray removeAllObjects];
                }
                [dict enumerateObjectsUsingBlock:^(id  _Nonnull obj, NSUInteger idx, BOOL * _Nonnull stop) {
                    [allListArray addObject:obj];
                }];
                [self qiehuanWithType:type];
                
//          RankNum  NickName  IsCertification  GradeNum  ExpNum  UserImage
            [front setText:[NSString stringWithFormat:@"%i",[[userdata objectForKey:@"RankNum"] intValue]+1]];
            [nickName setText:[userdata objectForKey:@"NickName"]];
            [levelLab setText:[userdata objectForKey:@"GradeNum"]];
            if ([[userdata objectForKey:@"IsCertification"] intValue] == 2) {
                vipPic.hidden = NO;
            }else{
                vipPic.hidden = YES;
            }
            [expLab setText:[userdata objectForKey:@"ExpNum"]];
            [allTable reloadData];
         }else{   // 好友
            if (num == 1) {
                [frendsListArray removeAllObjects];
            }
             // 一系列的操作和all类似
             [dict enumerateObjectsUsingBlock:^(id  _Nonnull obj, NSUInteger idx, BOOL * _Nonnull stop) {
                 [frendsListArray addObject:obj];
             }];
             [self qiehuanWithType:type];
             [front setText:[NSString stringWithFormat:@"%i",[[userdata objectForKey:@"RankNum"] intValue]+1]];
             [nickName setText:[userdata objectForKey:@"NickName"]];
             [levelLab setText:[userdata objectForKey:@"GradeNum"]];
             if ([[userdata objectForKey:@"IsCertification"] intValue] == 2) {
                 vipPic.hidden = NO;
             }else{
                 vipPic.hidden = YES;
             }
             [expLab setText:[userdata objectForKey:@"ExpNum"]];
             [frendsTable reloadData];
         }
        } failBlock:^(AFHTTPRequestOperation *operation, NSError *eror) {
    
        }];
}

@end

//
//  MyAchViewController.m
//  Test
//
//  Created by wlq on 2018/6/22.
//  Copyright © 2018年 wlq. All rights reserved.
//

#import "MyAchViewController.h"
#import "MyAchieveView.h"
#import "AchieveView.h"
#import "QuanyiView.h"
#import "Request.h"
#import "AchShowViewController.h"

#define WIDTH [[UIScreen mainScreen]bounds].size.width
// https://api.meditool.cn/Apigrade/myachieve?userid=2421&usertoken=4d6299dc0bec74c9e9bbb21627061563&seluserid=2421

@interface MyAchViewController (){
    UIScrollView             *scrollView;
    
    UIImageView              *iconImg;
    UILabel                  *levelLab;
    
    NSMutableArray           *MyachArr;
}

@end

@implementation MyAchViewController

- (void)viewDidLoad {
    [super viewDidLoad];
    
    self.title = @"我的成就";
    self.view.backgroundColor = [UIColor whiteColor];

    self.navigationItem.leftBarButtonItem = [[UIBarButtonItem alloc]initWithImage:[UIImage imageNamed:@"back_icon"] style:UIBarButtonItemStyleDone target:self action:@selector(back)];
    self.navigationItem.leftBarButtonItem.tintColor = [UIColor blueColor];
    self.navigationController.navigationBar.shadowImage = nil;
    [self drawHeadview];
    MyachArr = [NSMutableArray new];
    [self getdata];
}

- (void)getdata{
    Request *re = [Request shareInstance];
    
    NSMutableDictionary *dict = [NSMutableDictionary dictionary];
    [dict setObject:@"" forKey:@"user_id"];   // 2421
    [dict setObject:@"" forKey:@"usertoken"];    //
    
    NSString *urlStr = @"https://api.meditool.cn/Apigrade/myachieve?userid=2421&usertoken=bcd907f30da4fc66eb933dc7b808fb84&seluserid=2421";
    [re GetRequestWithUrl:urlStr params:nil sucessBlock:^(AFHTTPRequestOperation *operation, id responseObject) {
        NSMutableArray *dict = [responseObject objectForKey:@"data"];
        MyachArr = dict;
        [self drawScrollItem];
        
        
        
    } failBlock:^(AFHTTPRequestOperation *operation, NSError *eror) {
        
    }];
    
}

- (void)drawHeadview{
    scrollView = [[UIScrollView alloc]initWithFrame:CGRectMake(0, 0, WIDTH, [[UIScreen mainScreen] bounds].size.height)];
    [self.view addSubview:scrollView];
    UIImageView *headView = [[UIImageView alloc]initWithFrame:CGRectMake(0, 0, WIDTH, 126)];
    [headView setImage:[UIImage imageNamed:@"icon_blue_half_circle"]];
    [scrollView addSubview:headView];
    
    iconImg = [[UIImageView alloc]initWithFrame:CGRectMake(0, 9, 70, 70)];
    [iconImg setImage:[UIImage imageNamed:@"icon_yiku_downloadcode"]];
    iconImg.layer.masksToBounds = YES;
    iconImg.layer.cornerRadius = 35;
    iconImg.layer.borderWidth = 3;
    iconImg.layer.borderColor = [UIColor whiteColor].CGColor;
    iconImg.center = CGPointMake(WIDTH/2, 126);
    [scrollView addSubview:iconImg];
    
    levelLab = [[UILabel alloc]initWithFrame:CGRectMake(0, 170, WIDTH/2 + 10, 20)];
    [levelLab setText:@"6星成就"];
    levelLab.font = [UIFont systemFontOfSize:16];
    levelLab.textAlignment = NSTextAlignmentRight;
    [scrollView addSubview:levelLab];
    
    UIButton *btn = [[UIButton alloc]initWithFrame:CGRectMake(WIDTH/2 + 15, 160, 35, 35)];
    [btn setImage:[UIImage imageNamed:@"icon_my_achievement_rank"] forState:UIControlStateNormal];
    [btn addTarget:self action:@selector(gotoList) forControlEvents:UIControlEventTouchUpInside];
    [scrollView addSubview:btn];
}

//获取图片名称   LegalRightName
- (NSString *)getImgWithName:(NSString *)gradeId andisAccord:(BOOL)isAc{
    if ([gradeId isEqualToString:@"1"]){
        if (isAc) {
            return @"icon_zsyh";
        }else{
            return @"icon_zsyh_g";
        }
    }else if ([gradeId isEqualToString:@"2"]){
        if (isAc) {
            return @"icon_ytyl";
        }else{
            return @"icon_ytyl_g";
        }
    }else if ([gradeId isEqualToString:@"3"]){
        if (isAc) {
            return @"icon_fyrw";
        }else{
            return @"icon_fyrw_g";
        }
    }else if ([gradeId isEqualToString:@"4"]){
        if (isAc) {
            return @"icon_xfwc";
        }else{
            return @"icon_xfwc_g";
        }
    }else if ([gradeId isEqualToString:@"5"]){
        if (isAc) {
            return @"icon_zrwl";
        }else{
            return @"icon_zrwl_g";
        }
    }else if ([gradeId isEqualToString:@"6"]){
        if (isAc) {
            return @"icon_chhy";
        }else{
            return @"icon_chhy_g";
        }
    }else if ([gradeId isEqualToString:@"7"]){
        if (isAc) {
            return @"icon_drbr";
        }else{
            return @"icon_drbr_g";
        }
    }else if ([gradeId isEqualToString:@"8"]){
        if (isAc) {
            return @"icon_pmtx";
        }else{
            return @"icon_pmtx_g";
        }
    }else if ([gradeId isEqualToString:@"9"]){
        if (isAc) {
            return @"icon_bxdw";
        }else{
            return @"icon_bxdw_g";
        }
    }else if ([gradeId isEqualToString:@"10"]){
        if (isAc) {
            return @"icon_mshc";
        }else{
            return @"icon_mshc_g";
        }
    }else if ([gradeId isEqualToString:@"11"]){
        if (isAc) {
            return @"icon_jdsg";
        }else{
            return @"icon_jdsg_g";
        }
    }else if ([gradeId isEqualToString:@"12"]){
        if (isAc) {
            return @"icon_smyy";
        }else{
            return @"icon_smyy_g";
        }
    }else if ([gradeId isEqualToString:@"13"]){
        if (isAc) {
            return @"icon_hqct";
        }else{
            return @"icon_hqct_g";
        }
    }else if ([gradeId isEqualToString:@"14"]){
        if (isAc) {
            return @"icon_clbc";
        }else{
            return @"icon_clbc_g";
        }
    }else if ([gradeId isEqualToString:@"15"]){
        if (isAc) {
            return @"icon_dscj";
        }else{
            return @"icon_dscj_g";
        }
    }else{
        return @"icon_pmtx";
    }
}

//这是获取里面的内容时候的高清大图
- (NSString *)getBigImgWithName:(NSString *)gradeId andisAccord:(BOOL)isAc{
    if ([gradeId isEqualToString:@"1"]){
        if (isAc) {
            return @"1忠实用户";
        }else{
            return @"1忠实用户灰";
        }
    }else if ([gradeId isEqualToString:@"2"]){
        if (isAc) {
            return @"2有头有脸";
        }else{
            return @"2有头有脸灰";
        }
    }else if ([gradeId isEqualToString:@"3"]){
        if (isAc) {
            return @"3风云人物";
        }else{
            return @"3风云人物灰";
        }
    }else if ([gradeId isEqualToString:@"4"]){
        if (isAc) {
            return @"4学富五车";
        }else{
            return @"4学富五车灰";
        }
    }else if ([gradeId isEqualToString:@"5"]){
        if (isAc) {
            return @"5助人为乐";
        }else{
            return @"5助人为乐灰";
        }
    }else if ([gradeId isEqualToString:@"6"]){
        if (isAc) {
            return @"6才华横溢";
        }else{
            return @"6才华横溢灰";
        }
    }else if ([gradeId isEqualToString:@"7"]){
        if (isAc) {
            return @"7当仁不让";
        }else{
            return @"7当仁不让灰";
        }
    }else if ([gradeId isEqualToString:@"8"]){
        if (isAc) {
            return @"8朋满天下";
        }else{
            return @"8朋满天下灰";
        }
    }else if ([gradeId isEqualToString:@"9"]){
        if (isAc) {
            return @"9博学多闻";
        }else{
            return @"9博学多闻灰";
        }
    }else if ([gradeId isEqualToString:@"10"]){
        if (isAc) {
            return @"10妙手回春";
        }else{
            return @"10妙手回春灰";
        }
    }else if ([gradeId isEqualToString:@"11"]){
        if (isAc) {
            return @"11见多识广";
        }else{
            return @"11见多识广灰";
        }
    }else if ([gradeId isEqualToString:@"12"]){
        if (isAc) {
            return @"12声名远扬";
        }else{
            return @"12声名远扬灰";
        }
    }else if ([gradeId isEqualToString:@"13"]){
        if (isAc) {
            return @"13壕气冲天";
        }else{
            return @"13壕气冲天灰";
        }
    }else if ([gradeId isEqualToString:@"14"]){
        if (isAc) {
            return @"14出类拔萃";
        }else{
            return @"14出类拔萃灰";
        }
    }else if ([gradeId isEqualToString:@"15"]){
        if (isAc) {
            return @"15大收藏家";
        }else{
            return @"15大收藏家灰";
        }
    }else{
        return @"1忠实用户灰";
    }
}

- (void)back{
    [self dismissViewControllerAnimated:YES completion:^{
        NSLog(@"去");
    }];
}

//ID: "1",
//AchieveName: "忠实用户",
//OneStarValue: "10",
//OneStarMsg: "累计使用10天",
//TwoStarValue: "50",
//TwoStarMsg: "累计使用50天",
//ThreeStarValue: "300",
//ThreeStarMsg: "累计使用300天",
//AchieveUrl: null,
//IsGet: 0,
//GetDetail: [ ],
//NowSpeed: 1
- (void)drawScrollItem{
    for (int i = 0; i < MyachArr.count; i++) {
        int h = i/3;
        int w = i%3;
        NSDictionary *model = MyachArr[i];
        
        MyAchieveView *a = [[MyAchieveView alloc]init];
        a.frame = CGRectMake(w*WIDTH/3, 190+h*170, WIDTH/3, 170);
        a.clickBtn.tag = 101+i;
        [a.clickBtn addTarget:self action:@selector(clickMe:) forControlEvents:UIControlEventTouchUpInside];
        [scrollView addSubview:a];
        // 画逻辑根据model
        [a.infoLab setText:[model objectForKey:@"AchieveName"]];
        BOOL isget = NO;
        if ([[model objectForKey:@"IsGet"] intValue] == 0) {
            isget = NO;
        }else{
            isget = YES;
        }
        [a.iconImg setImage:[UIImage imageNamed:[self getImgWithName:[model objectForKey:@"ID"] andisAccord:isget]]];
        if (isget) {//判断星级与描述
            if ([[model objectForKey:@"NowSpeed"] intValue] >= [[model objectForKey:@"ThreeStarValue"] intValue]) {
                [a.levelImg setImage:[UIImage imageNamed:@"icon_star_three"]];
                [a.detailLab setText:[model objectForKey:@"ThreeStarMsg"]];
            }else{
                if ([[model objectForKey:@"NowSpeed"] intValue] >= [[model objectForKey:@"TwoStarValue"] intValue]) {
                    [a.levelImg setImage:[UIImage imageNamed:@"icon_star_two"]];
                    [a.detailLab setText:[model objectForKey:@"ThreeStarMsg"]];
                }else{
                    if ([[model objectForKey:@"NowSpeed"] intValue] >= [[model objectForKey:@"OneStarValue"] intValue]) {
                        [a.levelImg setImage:[UIImage imageNamed:@"icon_star_one"]];
                        [a.detailLab setText:[model objectForKey:@"ThreeStarMsg"]];
                    }else{
                        [a.levelImg setImage:[UIImage imageNamed:@"icon_star_zero"]];
                    }
                }
            }
        }else{
            [a.levelImg setImage:[UIImage imageNamed:@"icon_star_zero"]];
        }
    }
    scrollView.contentSize = CGSizeMake(WIDTH, 190 + MyachArr.count*170/3 + 20);
}

- (void)clickMe:(UIButton *)sender{
    NSLog(@"%i",(int)sender.tag);
    AchShowViewController *cha = [[AchShowViewController alloc]init];
    NSMutableDictionary *a = MyachArr[(int)sender.tag - 101];
    cha.model = a;
    cha.imgName1 = [self getBigImgWithName:[a objectForKey:@"ID"] andisAccord:YES];
    cha.imgName2 = [self getBigImgWithName:[a objectForKey:@"ID"] andisAccord:NO];
    [self.navigationController presentViewController:cha animated:YES completion:^{
        
    }];
}

// 跳往排行榜
- (void)gotoList{
   
}
@end

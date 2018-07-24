//
//  MyRankViewController.m
//  Test
//
//  Created by wlq on 2018/6/19.
//  Copyright © 2018年 wlq. All rights reserved.
//

#import "MyRankViewController.h"
#import "MLMCircleView.h"
#import "MyTaskTableViewCell.h"
#import "ZhuanshuViewController.h"
#import "LevelChartsViewController.h"
#import "EXPListViewController.h"
#define WIDTH [[UIScreen mainScreen]bounds].size.width
#define HEIGHT [[UIScreen mainScreen]bounds].size.height

@interface MyRankViewController ()<UITableViewDataSource,UITableViewDelegate,UIWebViewDelegate>{
    UITableView             *mainTable;

    UIView                  *headView;
    MLMCircleView           *circle;
    UIScrollView            *listScrol;   //  横向
    
    NSMutableArray          *myRectask;
    NSMutableArray          *myDailytask;
    NSArray                 *iconImgs;   //灰权益
    NSArray                 *iconImgs1;  //达成的权益
    
    NSMutableDictionary     *mygrade;     //  我的等级
    
    NSMutableArray          *grades;      //  专属权益列表
    NSMutableArray          *rectask;     //   推荐任务
    NSMutableArray          *dailytask;   //   日常任务
    
    NSString                *webUrl;      //  存放web的规则
}

@end

@implementation MyRankViewController

- (void)viewDidLoad {
    [super viewDidLoad];
    self.view.backgroundColor = [UIColor whiteColor] ;
    self.title = @"我的等级";
    float asas = WIDTH;
    NSLog(@"%f",asas);
    webUrl = @"http://meditool.cn/Medicoolshare/graderule";
    
    self.navigationItem.leftBarButtonItem = [[UIBarButtonItem alloc]initWithImage:[UIImage imageNamed:@"back_icon"] style:UIBarButtonItemStyleDone target:self action:@selector(back)];
    self.navigationItem.leftBarButtonItem.tintColor = [UIColor blueColor];
    self.navigationController.navigationBar.shadowImage = nil;
    
    UIButton *btn = [[UIButton alloc]init];
    [btn setImage:[UIImage imageNamed:@"icon_phb_b"] forState:UIControlStateNormal];
    [btn setImageEdgeInsets:UIEdgeInsetsMake(5, 15, 5, -15)];
    btn.imageView.contentMode = UIViewContentModeScaleAspectFit;
    [btn addTarget:self action:@selector(golist) forControlEvents:UIControlEventTouchUpInside];
    self.navigationItem.rightBarButtonItem = [[UIBarButtonItem alloc]initWithCustomView:btn];
    self.navigationItem.rightBarButtonItem.tintColor = [UIColor blueColor];
    self.navigationController.navigationBar.shadowImage = nil;

    mainTable = [[UITableView alloc]initWithFrame:CGRectMake(0, 64, WIDTH, HEIGHT - 64) style:UITableViewStyleGrouped];
    mainTable.delegate = self;
    mainTable.dataSource = self;
    [self.view addSubview:mainTable];
    [mainTable registerNib:[UINib nibWithNibName:@"MyTaskTableViewCell" bundle:nil] forCellReuseIdentifier:@"Taskcell"];
    
    
    mygrade = [NSMutableDictionary new];
    
    grades = [NSMutableArray new];
    rectask = [NSMutableArray new];
    dailytask = [NSMutableArray new];
    
    [self drawHeadView];
    
    [self getdata];
}

- (void)golist{
    LevelChartsViewController *test = [[LevelChartsViewController alloc]init];
    UINavigationController *nav = [[UINavigationController alloc]initWithRootViewController:test];
    [self presentViewController:nav animated:YES completion:^{
        
    }];
}
//获取图片名称   LegalRightName
- (NSString *)getImgWithName:(NSString *)gradeId andisAccord:(BOOL)isAc{
    if ([gradeId isEqualToString:@"2"]){
        if (isAc) {
            return @"icon_wenxian_b";
        }else{
            return @"icon_wenxian_g";
        }
    }else if ([gradeId isEqualToString:@"3"]){
        if (isAc) {
            return @"icon_super_qun_b";
        }else{
            return @"icon_super_qun";
        }
    }else if ([gradeId isEqualToString:@"4"]){
        if (isAc) {
            return @"icon_jifen_b";
        }else{
            return @"icon_jifen_g";
        }
    }else if ([gradeId isEqualToString:@"5"]){
        if (isAc) {
            return @"icon_jifen_b";
        }else{
            return @"icon_jifen_g";
        }
    }else if ([gradeId isEqualToString:@"6"]){
        if (isAc) {
            return @"icon_jifen_b";
        }else{
            return @"icon_jifen_g";
        }
    }else if ([gradeId isEqualToString:@"7"]){
        if (isAc) {
            return @"icon_wenxian_b";
        }else{
            return @"icon_wenxian_g";
        }
    }else if ([gradeId isEqualToString:@"8"]){
        if (isAc) {
            return @"icon_jifen_b";
        }else{
            return @"icon_jifen_g";
        }
    }else if ([gradeId isEqualToString:@"9"]){
        if (isAc) {
            return @"icon_jifen_b";
        }else{
            return @"icon_jifen_g";
        }
    }else if ([gradeId isEqualToString:@"10"]){
        if (isAc) {
            return @"icon_biaoqing_b";
        }else{
            return @"icon_biaoqing";
        }
    }else if ([gradeId isEqualToString:@"11"]){
        if (isAc) {
            return @"icon_jifen_b";
        }else{
            return @"icon_jifen_g";
        }
    }else if ([gradeId isEqualToString:@"12"]){
        if (isAc) {
            return @"icon_jifen_b";
        }else{
            return @"icon_jifen_g";
        }
    }else if ([gradeId isEqualToString:@"13"]){
        if (isAc) {
            return @"icon_wenxian_b";
        }else{
            return @"icon_wenxian_g";
        }
    }else if ([gradeId isEqualToString:@"14"]){
        if (isAc) {
            return @"icon_jifen_b";
        }else{
            return @"icon_jifen_g";
        }
    }else if ([gradeId isEqualToString:@"15"]){
        if (isAc) {
            return @"icon_jifen_b";
        }else{
            return @"icon_jifen_g";
        }
    }else if ([gradeId isEqualToString:@"16"]){
        if (isAc) {
            return @"icon_jifen_b";
        }else{
            return @"icon_jifen_g";
        }
    }else{
        return @"";
    }
}

- (NSString *)getImgName:(NSString *)taskId{
    if ([taskId isEqualToString:@"1"]){
            return @"icon_smrz_g";
    }else if ([taskId isEqualToString:@"2"]){
            return @"icon_wsxx_g";
    }else if ([taskId isEqualToString:@"3"]){
        return @"icon_wx_g";
    }else if ([taskId isEqualToString:@"4"]){
        return @"icon_tp_g";
    }else if ([taskId isEqualToString:@"5"]){
        return @"icon_addfriend_g";
    }else if ([taskId isEqualToString:@"6"]){
        return @"icon_ktyhfw";
    }else if ([taskId isEqualToString:@"7"]){
        return @"icon_qyys_g";
    }else if ([taskId isEqualToString:@"8"]){
        return @"icon_creat_jl";
    }else if ([taskId isEqualToString:@"9"]){
        return @"icon_share_exp";
    }else if ([taskId isEqualToString:@"10"]){
        return @"icon_login_g";
    }else if ([taskId isEqualToString:@"11"]){
        return @"icon_send_ztt";
    }else if ([taskId isEqualToString:@"12"]){
        return @"icon_reply_g";
    }else if ([taskId isEqualToString:@"13"]){
        return @"icon_hfbcn";
    }else if ([taskId isEqualToString:@"14"]){
        return @"icon_join_hd";
    }else if ([taskId isEqualToString:@"15"]){
        return @"icon_gongxian";
    }else if ([taskId isEqualToString:@"16"]){
        return @"icon_share_g";
    }else if ([taskId isEqualToString:@"17"]){
        return @"icon_zxsc_g";
    }else if ([taskId isEqualToString:@"18"]){
        return @"投票-19";
    }else if ([taskId isEqualToString:@"19"]){
        return @"icon_creat_bd";
    }else{
        return @"icon_send_ztt";
    }
}

- (void)back{
    [self dismissViewControllerAnimated:YES completion:^{
        NSLog(@"去");
    }];
}

// 到时将就两个head合并，作table的headview
- (UIView *)drawHeadView{
    headView = [[UIView alloc]initWithFrame:CGRectMake(0, 0, WIDTH, 410)];
    headView.backgroundColor = [UIColor whiteColor];
    
    circle = [[MLMCircleView alloc] initWithFrame:CGRectMake(0, 0, WIDTH,WIDTH)];
    circle.center = CGPointMake(WIDTH/2, 150);
    circle.bottomWidth = 5;
    circle.progressWidth = 5;
    circle.fillColor = [UIColor blueColor];
    circle.bgColor = [UIColor lightGrayColor];
    circle.dotDiameter = 5;
    circle.edgespace = WIDTH/2-120;
    circle.dotImage = [UIImage imageNamed:@"icon_circle_point_f"];
    [circle drawProgress];
    [headView addSubview:circle];
    
    //刻度
    MLMCalibrationView *_calibra = [[MLMCalibrationView alloc] initWithFrame:CGRectMake(0, 0, circle.freeWidth+3,circle.freeWidth+3) startAngle:150 endAngle:390];
    _calibra.textType = MLMCalibrationViewTextRotate;
    _calibra.smallScaleNum = 1;
    _calibra.majorScaleNum = 16;
    _calibra.majorScaleLength = 1;
    _calibra.smallScaleLength = 1;
    _calibra.bgColor = [UIColor blueColor];
    _calibra.customArray =  @[@"0",@"1",@"2",@"3",@"4",@"5",@"6",@"7",@"8",@"9",@"10",@"11",@"12",@"13",@"14",@"15",@"16"];
    _calibra.edgeSpace = 0;
    _calibra.majorTextColor = [UIColor blackColor];
    
    _calibra.majorScaleColor = [UIColor blueColor];
//    _calibra.smallScaleColor = [UIColor redColor];
    
    _calibra.center = circle.center;
    [_calibra drawCalibration];
    [headView addSubview:_calibra];
    
    UILabel *linee = [[UILabel alloc]initWithFrame:CGRectMake(0, 260, WIDTH, 10)];
    linee.backgroundColor = [UIColor lightGrayColor];
    [headView addSubview:linee];
    
    UILabel *titLab = [[UILabel alloc]initWithFrame:CGRectMake(40, 280, 100, 20)];
    [titLab setText:@"专属特权"];
    titLab.font = [UIFont systemFontOfSize:14];
    [headView addSubview:titLab];
    UIImageView *img = [[UIImageView alloc]initWithFrame:CGRectMake(10, 280, 20, 20)];
    img.image = [UIImage imageNamed:@"icon_zsqy_b"];
    [headView addSubview:img];
    
    listScrol = [[UIScrollView alloc]initWithFrame:CGRectMake(0, 310, WIDTH, 100)];
    listScrol.backgroundColor = [UIColor whiteColor];
    listScrol.contentSize = CGSizeMake( 80*15, 100);
    [headView addSubview:listScrol];
    
    // 横向画饼
    for (int i = 1; i < grades.count; i++) {
        QuanyiView *qview = [[QuanyiView alloc]init];
        qview.frame = CGRectMake( (i-1)*80, 0, 80, 100);
        NSDictionary *dict = grades[i];
        BOOL isq = [[mygrade objectForKey:@"GradeNum"] intValue] >= [[dict objectForKey:@"GradeNum"] intValue] ? YES:NO;
        qview.model = grades[i];
        NSString *imgName = [self getImgWithName:[dict objectForKey:@"GradeNum"] andisAccord:isq];
        qview.iconView.image = [UIImage imageNamed:imgName];
        qview.dotLab.layer.cornerRadius = 5;
        if (isq) {
            qview.lineLab.backgroundColor = [UIColor blueColor];
            qview.dotLab.backgroundColor = [UIColor blueColor];
        }else{
        }
        
        UIButton *btn = [[UIButton alloc]initWithFrame:CGRectMake(0, 0, 80, 100)];
        btn.backgroundColor = [UIColor whiteColor];
        btn.alpha = 0.1;
        btn.tag = 1001+i;
        [btn addTarget:self action:@selector(qvBtn:) forControlEvents:UIControlEventTouchUpInside];
        [qview addSubview:btn];
        
        [listScrol addSubview:qview];
    }
    
    return headView;
}

- (void)qvBtn:(UIButton *)sender{
    NSLog(@"%li",sender.tag);
    ZhuanshuViewController *aa = [[ZhuanshuViewController alloc]init];
    aa.grades = grades;
    aa.mygrade = mygrade;
    aa.selTag = (int)sender.tag - 1000;
    [self.navigationController pushViewController:aa animated:NO];
}

- (void)getdata{
    Request *re = [Request shareInstance];
    
    NSMutableDictionary *dict = [NSMutableDictionary dictionary];
    [dict setObject:@"" forKey:@"user_id"];   // 2421
    [dict setObject:@"" forKey:@"usertoken"];    //
    
    NSString *urlStr = @"http://apitest.meditool.cn/Apigrade/mygrade?userid=593553&usertoken=81d39cb3e9167c24e1bd340f2944594b";
    [re GetRequestWithUrl:urlStr params:nil sucessBlock:^(AFHTTPRequestOperation *operation, id responseObject) {
        NSDictionary *dict = [responseObject objectForKey:@"data"];
        grades = [dict objectForKey:@"grades"];
        mygrade = [dict objectForKey:@"mygrade"];
        mainTable.tableHeaderView = [self drawHeadView];
        webUrl = [dict objectForKey:@"rulemsgurl"];
        
        int ExpNum = [[mygrade objectForKey:@"ExpNum"] isEqual:[NSNull null]] ? 0:[[mygrade objectForKey:@"ExpNum"]intValue];
        UILabel *lab = [[UILabel alloc]initWithFrame:CGRectMake(0, 0, 180, 40)];
        lab.textAlignment = NSTextAlignmentCenter;
        [lab setText:[NSString stringWithFormat:@"%i",ExpNum]];
        lab.center = circle.center;
        [lab setTextColor:[UIColor blueColor]];
        [headView addSubview:lab];
        int GradeNum = [[mygrade objectForKey:@"GradeNum"] intValue];
        UILabel *lab2 = [[UILabel alloc]initWithFrame:CGRectMake(0, 0, 180, 40)];
        lab2.textAlignment = NSTextAlignmentCenter;
        [lab2 setText:[NSString stringWithFormat:@"Lv.%i %@",GradeNum,[mygrade objectForKey:@"RankTitle"]]];
        lab2.center = CGPointMake(circle.center.x, circle.center.y + 20) ;
        [lab2 setTextColor:[UIColor blueColor]];
        [headView addSubview:lab2];
        
        UIButton *btn11 = [[UIButton alloc]initWithFrame:CGRectMake(0, 20, 80, 100)];
        btn11.center = lab.center;
        [btn11 addTarget:self action:@selector(gotolistVi) forControlEvents:UIControlEventTouchUpInside];
        btn11.alpha = 0.1;
        
        [headView addSubview:btn11];
        
        int ExpNumEnd = 0;
        for (NSDictionary *item in grades) {
            QuanyiView *gradeView = [[QuanyiView alloc]init];
            gradeView.model = item;
            
            if ([item objectForKey:@"GradeNum"] == [mygrade objectForKey:@"GradeNum"]) {
                ExpNumEnd = [[item objectForKey:@"ExpNumEnd"] intValue];
            }
        }
        UILabel *lab3 = [[UILabel alloc]initWithFrame:CGRectMake(0, circle.center.y +80, WIDTH, 15)];
        lab3.textAlignment = NSTextAlignmentCenter;
        lab3.font = [UIFont systemFontOfSize:12];
        NSString *labStr = [NSString stringWithFormat:@"距离下一等级还需要%i经验值",ExpNumEnd - ExpNum + 1];
        [lab3 setText:labStr];
        [lab3 setTextColor:[UIColor blueColor]];
        [headView addSubview:lab3];
        
        UIButton *btn = [[UIButton alloc]init];
        float www = [UtilString getLabelsize:labStr andTextsize:12 andLabwidth:15].width/2 + circle.center.x;
        btn.frame = CGRectMake(www+5, circle.center.y +80, 15, 15);
        [btn setImage:[UIImage imageNamed:@"icon_yiwen_b"] forState:UIControlStateNormal];
        [btn addTarget:self action:@selector(gotoWeb) forControlEvents:UIControlEventTouchUpInside];
        [headView addSubview:btn];
        
        [circle setProgress:GradeNum*1.0/16];
        
        rectask = [dict objectForKey:@"rectask"];
        dailytask = [dict objectForKey:@"dailytask"];
        [mainTable reloadData];
    } failBlock:^(AFHTTPRequestOperation *operation, NSError *eror) {
        
    }];
}

- (void)gotolistVi{
    //        EXPListViewController
    //        mygrade
    EXPListViewController *vc = [[EXPListViewController alloc]init];
    vc.mygrade = mygrade;
    vc.urlstr = webUrl;
    [self.navigationController pushViewController:vc animated:YES];
}

//前往游戏规则 这里到时候就调用webvc界面就行
- (void)gotoWeb{
    UIWebView *vc = [[UIWebView alloc]init];
    vc=[[UIWebView alloc]initWithFrame:CGRectMake(0, 0, WIDTH, HEIGHT)];
    vc.delegate = self;
    vc.scalesPageToFit = YES;
    [vc loadRequest:[NSURLRequest requestWithURL:[NSURL URLWithString:webUrl]]];
    
    UIViewController *dd = [[UIViewController alloc]init];
    dd.title = @"升级说明";
    dd.navigationItem.leftBarButtonItem = [[UIBarButtonItem alloc]initWithImage:[UIImage imageNamed:@"icon_back_b"] style:UIBarButtonItemStyleDone target:self action:@selector(goback)];
    dd.navigationItem.leftBarButtonItem.tintColor = [UIColor blueColor];
    [dd.view addSubview:vc];

    [self.navigationController pushViewController:dd animated:YES];
}

- (void)goback{
    int i = (int)[self.navigationController viewControllers].count;
    [self.navigationController popToViewController:[self.navigationController viewControllers][i-2] animated:YES];
}

- (NSInteger)tableView:(UITableView *)tableView numberOfRowsInSection:(NSInteger)section{
    if (rectask.count == 0) {
        return 0;
    }else{
    if (section == 0) {
        return rectask.count;
    }else{
        return dailytask.count;
    }
    }
}

- (UITableViewCell *)tableView:(UITableView *)tableView cellForRowAtIndexPath:(NSIndexPath *)indexPath{
    NSDictionary *model = [NSDictionary new];
    if (indexPath.section == 0) {
        model = rectask[indexPath.row];
    }
    else{
        model = dailytask[indexPath.row];
    }
    
    MyTaskTableViewCell *cell = [tableView dequeueReusableCellWithIdentifier:@"Taskcell"];
    cell.selectionStyle = UITableViewCellSelectionStyleNone;
    if (!cell) {
        cell = [[MyTaskTableViewCell alloc]initWithStyle:UITableViewCellStyleDefault reuseIdentifier:@"Taskcell"];
    }
    NSString *imgStr = [self getImgName:[model objectForKey:@"ID"]];
    [cell.iconImg setImage:[UIImage imageNamed:imgStr]];
    float www = [UtilString getLabelsize:[model objectForKey:@"TaskName"] andTextsize:14 andLabwidth:15].width;
    [cell.titleLab setText:[model objectForKey:@"TaskName"]];
    cell.titleLab.frame = CGRectMake(64, 20, www+5, 15);
    cell.numLab.frame = CGRectMake(www+75, 20, 50, 15);
    [cell.detailLab setText:[model objectForKey:@"TaskMsg"]];
    cell.detailLab.frame = CGRectMake(64, 37, WIDTH - 140, 37);
    [cell.numLab setText:[NSString stringWithFormat:@"+%@",[model objectForKey:@"ExpNum"]]];
    if ([[model objectForKey:@"TaskText"] isEqualToString:@""]) {
        cell.clickBtn.hidden = YES;
    }else{
        cell.clickBtn.hidden = NO;
        [cell.clickBtn setTitle:[model objectForKey:@"TaskText"] forState:UIControlStateNormal];
    }
    
    return cell;
}

- (NSInteger)numberOfSectionsInTableView:(UITableView *)tableView{
    return 2;
}

- (CGFloat)tableView:(UITableView *)tableView heightForRowAtIndexPath:(NSIndexPath *)indexPath{
    return 80;
}

- (CGFloat)tableView:(UITableView *)tableView heightForHeaderInSection:(NSInteger)section{
    return 60;
}

- (CGFloat)tableView:(UITableView *)tableView heightForFooterInSection:(NSInteger)section{
    return 0;
}

- (nullable UIView *)tableView:(UITableView *)tableView viewForHeaderInSection:(NSInteger)section{
    UILabel *linee = [[UILabel alloc]initWithFrame:CGRectMake(0, 0, WIDTH, 10)];
    linee.backgroundColor = [UIColor lightGrayColor];
    linee.alpha = 0.1;
    if (section == 0) {
        UIView *vv = [[UIView alloc]init];
        vv.backgroundColor = [UIColor whiteColor];
        UIImageView *imm = [[UIImageView alloc]initWithImage:[UIImage imageNamed:@"icon_tjrw_b"]];
        imm.frame = CGRectMake(10, 20, 20, 20);
        [vv addSubview:imm];
        UILabel *lab = [[UILabel alloc]initWithFrame:CGRectMake(40, 20, 100, 20)];
        [lab setText:@"推荐任务"];
        lab.font = [UIFont systemFontOfSize:14];
        [lab setTextColor:[UIColor blackColor]];
        [vv addSubview:lab];
        [vv addSubview:linee];
        return vv;
    }else{
        UIView *vv = [[UIView alloc]init];
        vv.backgroundColor = [UIColor whiteColor];
        UIImageView *imm = [[UIImageView alloc]initWithImage:[UIImage imageNamed:@"icon_rcrw_b"]];
        imm.frame = CGRectMake(10, 20, 20, 20);
        [vv addSubview:imm];
        UILabel *lab = [[UILabel alloc]initWithFrame:CGRectMake(40, 20, 100, 20)];
        [lab setText:@"日常任务"];
        lab.font = [UIFont systemFontOfSize:14];
        [lab setTextColor:[UIColor blackColor]];
        [vv addSubview:lab];
        [vv addSubview:linee];
        return vv;
    }
}

- (nullable UIView *)tableView:(UITableView *)tableView viewForFooterInSection:(NSInteger)section{
    UIView *vvv = [[UIView alloc]init];
    return vvv;
}

- (void)tableView:(UITableView *)tableView didSelectRowAtIndexPath:(NSIndexPath *)indexPath{
    
}
@end

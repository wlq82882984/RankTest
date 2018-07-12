//
//  ZhuanshuViewController.m
//  Test
//
//  Created by wlq on 2018/6/21.
//  Copyright © 2018年 wlq. All rights reserved.
//

#import "ZhuanshuViewController.h"
#import "QuanyiView.h"
#import "ZhuanshuQYView.h"
#define WIDTH [[UIScreen mainScreen]bounds].size.width
#define HEIGHT [[UIScreen mainScreen]bounds].size.height

@interface ZhuanshuViewController (){
        UIView                  *headView;
        UIScrollView            *listScrol;   //  横向
        ZhuanshuQYView          *detailView;
}

@end

@implementation ZhuanshuViewController

- (void)viewDidLoad {
    [super viewDidLoad];
    self.title = @"专属权益";
    
    headView = [[UIView alloc]initWithFrame:CGRectMake(0, 100, WIDTH, 100)];
    headView.backgroundColor = [UIColor whiteColor];
    [self.view addSubview:headView];
    [self drawScrol];
    [self drawvvvv];
}

- (void)drawScrol{
    listScrol = [[UIScrollView alloc]initWithFrame:CGRectMake(0, 0, WIDTH, 100)];
    listScrol.backgroundColor = [UIColor whiteColor];
    listScrol.contentSize = CGSizeMake( 80*15, 100);
    [headView addSubview:listScrol];
    
    // 横向画饼     mygrade       grades
    for (int i = 1; i < self.grades.count; i++) {
        QuanyiView *qview = [[QuanyiView alloc]init];
        qview.frame = CGRectMake( (i-1)*80, 0, 80, 100);
        NSDictionary *dict = self.grades[i];
        BOOL isq = [[self.mygrade objectForKey:@"GradeNum"] intValue] >= [[dict objectForKey:@"GradeNum"] intValue] ? YES:NO;
        qview.model = self.grades[i];
        NSString *imgName = [self getImgWithName:[dict objectForKey:@"GradeNum"] andisAccord:isq];
        qview.iconView.image = [UIImage imageNamed:imgName];
        qview.dotLab.layer.cornerRadius = 5;
        if (isq) {
            qview.lineLab.backgroundColor = [UIColor blueColor];
            qview.dotLab.backgroundColor = [UIColor blueColor];
        }else{
        }
        [listScrol addSubview:qview];
        
        UIButton *btn = [[UIButton alloc]initWithFrame:CGRectMake((i-1)*80, 0, 80, 100)];
        btn.tag = 200+i;
        [btn addTarget:self action:@selector(selected:) forControlEvents:UIControlEventTouchUpInside];
        [listScrol addSubview:btn];
    }
    if (_selTag >= 14) {
        [listScrol scrollRectToVisible:CGRectMake(14*80, 0, 80, 100) animated:YES];
    }else{
        [listScrol scrollRectToVisible:CGRectMake((_selTag)*80, 0, 80, 100) animated:YES];
    }
}

- (void)selected:(UIButton *)sender{
    detailView.model = _grades[(int)sender.tag-200];
}

- (void)drawvvvv{
    detailView = [[ZhuanshuQYView alloc]init];
    detailView.backgroundColor = [UIColor whiteColor];
    detailView.frame = CGRectMake(0, 200, WIDTH, 500);
    detailView.model = _grades[_selTag-1];
    [self.view addSubview:detailView];
    
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

@end

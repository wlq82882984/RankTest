//
//  AchShowViewController.m
//  Test
//
//  Created by wlq on 2018/6/29.
//  Copyright © 2018年 wlq. All rights reserved.

#import "AchShowViewController.h"
#import "AchieveView.h"
#define WIDTH [[UIScreen mainScreen]bounds].size.width
#define HEIGH [[UIScreen mainScreen]bounds].size.height

@interface AchShowViewController (){
    UIScrollView        *mainScrolView;
}

@end

@implementation AchShowViewController

- (void)viewDidLoad {
    [super viewDidLoad];
    self.view.backgroundColor = [UIColor whiteColor];
    [self drawscrview];
}

- (AchieveView *)setAchiView:(int)i{
    AchieveView *av = [[AchieveView alloc]init];
    [av.levelView setImage:[UIImage imageNamed:[NSString stringWithFormat:@"%i星",i+1]]];
    [av.titleStr setText:[self.model objectForKey:@"AchieveName"]];
    av.isOther = YES;
    [av.iconView setImage:[UIImage imageNamed:self.imgName2]];
    switch (i) {
        case 0:{
            [av.detailStr setText:[self.model objectForKey:@"OneStarMsg"]];
            if ([[self.model objectForKey:@"NowSpeed"] intValue] >= [[self.model objectForKey:@"OneStarValue"] intValue]) {
                av.isOther = NO;
                [av.iconView setImage:[UIImage imageNamed:self.imgName1]];
                av.clickBtn.layer.borderWidth = 2;
                av.clickBtn.layer.cornerRadius = 6;
                av.clickBtn.tag = 200+i;
                av.clickBtn.layer.borderColor = [UIColor yellowColor].CGColor; //253,192,45
                [av.clickBtn addTarget:self action:@selector(snapshotScreenWithView:) forControlEvents:UIControlEventTouchUpInside];
            }else{
                av.isOther = NO;
                [av.iconView setImage:[UIImage imageNamed:self.imgName1]];
                av.clickBtn.layer.borderWidth = 2;
                av.clickBtn.layer.cornerRadius = 6;
                av.clickBtn.tag = 200+i;
                av.clickBtn.layer.borderColor = [UIColor yellowColor].CGColor; //253,192,45
                [av.clickBtn addTarget:self action:@selector(snapshotScreenWithView:) forControlEvents:UIControlEventTouchUpInside];
            }
        }
            break;
        case 1:{
            [av.detailStr setText:[self.model objectForKey:@"TwoStarMsg"]];
            if ([[self.model objectForKey:@"NowSpeed"] intValue] >= [[self.model objectForKey:@"TwoStarValue"] intValue]) {
                av.isOther = NO;
                av.clickBtn.layer.masksToBounds = YES;
                [av.iconView setImage:[UIImage imageNamed:self.imgName1]];
                av.clickBtn.layer.borderWidth = 2;
                av.clickBtn.layer.cornerRadius = 6;
                av.clickBtn.tag = 200+i;
                av.clickBtn.layer.borderColor = [UIColor yellowColor].CGColor; //253,192,45
            }else{
            }
        }
            break;
        case 2:{
            [av.detailStr setText:[self.model objectForKey:@"ThreeStarMsg"]];
            if ([[self.model objectForKey:@"NowSpeed"] intValue] >= [[self.model objectForKey:@"ThreeStarValue"] intValue]) {
                av.isOther = NO;
                av.clickBtn.layer.masksToBounds = YES;
                [av.iconView setImage:[UIImage imageNamed:self.imgName1]];
                av.clickBtn.layer.borderWidth = 2;
                av.clickBtn.layer.cornerRadius = 6;
                av.clickBtn.tag = 200+i;
                av.clickBtn.layer.borderColor = [UIColor yellowColor].CGColor; //253,192,45
            }else{
            }
        }
            break;
        default:{
        }
            break;
    }
    [av.backBtn addTarget:self action:@selector(backItemoo) forControlEvents:UIControlEventTouchUpInside];
    return av;
}

- (void)drawscrview{
    mainScrolView = [[UIScrollView alloc]init];
    mainScrolView.frame = CGRectMake( 0, 0, WIDTH, HEIGH);
    [self.view addSubview:mainScrolView];
    mainScrolView.contentSize = CGSizeMake(WIDTH*3, HEIGH);
    mainScrolView.bounces = NO;
    mainScrolView.pagingEnabled = YES;
    mainScrolView.showsHorizontalScrollIndicator = NO;
    
    for (int i = 0; i<3; i++) {
        AchieveView *av = [self setAchiView:i];
        av.frame = CGRectMake( WIDTH*i, 0, WIDTH, HEIGH);
        [mainScrolView addSubview:av];
    }
}

- (void)backItemoo{
    [self dismissViewControllerAnimated:YES completion:^{
    }];
}

//  截屏的时候 将有些不必要出现的图标隐藏
- (void)snapshotScreenWithView:(UIButton *)sender{
    int a = (int)sender.tag-200;
    AchieveView *av = [self setAchiView:a];
    av.frame = CGRectMake(0, 0, WIDTH, HEIGH);
    av.backBtn.hidden = YES;
    av.clickBtn.hidden = YES;
    UIGraphicsBeginImageContextWithOptions(av.frame.size, NO, [UIScreen mainScreen].scale);
//    UIGraphicsBeginImageContextWithOptions(av.frame.size, NO, 0);
    [av drawViewHierarchyInRect:av.frame afterScreenUpdates:YES];
    UIImage *image = UIGraphicsGetImageFromCurrentImageContext();
    UIGraphicsEndImageContext();
    UIImageWriteToSavedPhotosAlbum(image, nil, nil,nil);
    
}

@end

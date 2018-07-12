//
//  JobexpViewController.m
//  Test
//
//  Created by wlq on 2018/6/25.
//  Copyright © 2018年 wlq. All rights reserved.
//

#import "JobexpViewController.h"
#import "PlaceholderTextView.h"
#import "Request.h"

#define WIDTH [[UIScreen mainScreen]bounds].size.width
#define height [[UIScreen mainScreen]bounds].size.height

#define kTextBorderColor     RGBCOLOR(227,224,216)

#undef  RGBCOLOR
#define RGBCOLOR(r,g,b) [UIColor colorWithRed:r/255.0 green:g/255.0 blue:b/255.0 alpha:1]

@interface JobexpViewController ()<UITextViewDelegate>{
    PlaceholderTextView * textView;
}

@end

@implementation JobexpViewController

- (void)viewDidLoad {
    [super viewDidLoad];
    self.title = @"执业经历";
    self.navigationItem.leftBarButtonItem = [[UIBarButtonItem alloc]initWithImage:[UIImage imageNamed:@"back_icon"] style:UIBarButtonItemStyleDone target:self action:@selector(back)];
    self.navigationItem.rightBarButtonItem = [[UIBarButtonItem alloc]initWithTitle:@"保存" style:UIBarButtonItemStyleDone target:self action:@selector(saveBtn)];
    UITapGestureRecognizer *Tap =[[UITapGestureRecognizer alloc] initWithTarget:self action:@selector(clearPin)];
    [self.view addGestureRecognizer:Tap];
    
    self.view.backgroundColor = [UIColor whiteColor];
    [self drawTextView];
}

- (void)clearPin{
    [textView resignFirstResponder];
}

- (void)drawTextView{
            textView = [[PlaceholderTextView alloc]initWithFrame:CGRectMake(20, 84, WIDTH - 40, 300)];
            textView.backgroundColor = [UIColor whiteColor];
            textView.delegate = self;
            textView.font = [UIFont systemFontOfSize:14.f];
            textView.textColor = [UIColor blackColor];
            textView.textAlignment = NSTextAlignmentLeft;
            textView.editable = YES;
            textView.layer.cornerRadius = 5;
            textView.layer.borderColor = kTextBorderColor.CGColor;
            textView.layer.borderWidth = 0.5;
            textView.placeholderColor = RGBCOLOR(0x89, 0x89, 0x89);
            textView.placeholder = @"请填写执业经历";
    [self.view addSubview:textView];
}

- (void)saveBtn{
    [self clearPin];
    Request *re = [Request shareInstance];
    NSMutableDictionary *dict = [NSMutableDictionary dictionary];
    [dict setObject:@"" forKey:@"user_id"];   // 2421
    [dict setObject:@"" forKey:@"usertoken"];    //
    
    if (textView.text.length == 0) {
        return;
    }
    NSString *utf = [textView.text stringByAddingPercentEncodingWithAllowedCharacters:[NSCharacterSet URLQueryAllowedCharacterSet]];
    
    NSString *urlStr = [NSString stringWithFormat:@"http://apitest.meditool.cn/Apigrade/adduseredumsg?userid=593553&usertoken=81d39cb3e9167c24e1bd340f2944594b&datatype=1&userdata=%@",utf];
    [re GetRequestWithUrl:urlStr params:nil sucessBlock:^(AFHTTPRequestOperation *operation, id responseObject) {
// 提示一下成功了返回上个界面
        [self back];
            
            
    } failBlock:^(AFHTTPRequestOperation *operation, NSError *eror) {
            
    }];
}

- (void)back{
    [self dismissViewControllerAnimated:YES completion:^{
    }];
}

- (BOOL)textView:(UITextView *)textView shouldChangeTextInRange:(NSRange)range replacementText:(NSString *)text{
    if ([@"\n" isEqualToString:text] == YES){
        [textView resignFirstResponder];
        return NO;
    }
    return YES;
}

#pragma mark ---代理方法---
-(void)textViewDidBeginEditing:(UITextView *)textView{
}

- (void)textViewDidEndEditing:(UITextView *)textView{
}

-(BOOL)textViewShouldBeginEditing:(UITextView *)textView{
    return YES;
}

-(BOOL)textViewShouldEndEditing:(UITextView *)textView{
    return YES;
}

@end

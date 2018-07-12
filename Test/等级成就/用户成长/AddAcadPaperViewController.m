//
//  AddAcadPaperViewController.m
//  Test
//
//  Created by wlq on 2018/6/25.
//  Copyright © 2018年 wlq. All rights reserved.
//

#import "AddAcadPaperViewController.h"
#import "Request.h"
#define WIDTH [[UIScreen mainScreen]bounds].size.width
#define height [[UIScreen mainScreen]bounds].size.height

@interface AddAcadPaperViewController (){
    UITextField         *titleText;
    UITextField         *paperNameText;
    UITextField         *paperDateText;
}

@end

@implementation AddAcadPaperViewController

- (void)viewDidLoad {
    [super viewDidLoad];
    self.title = @"添加学术论文";
    self.navigationItem.leftBarButtonItem = [[UIBarButtonItem alloc]initWithImage:[UIImage imageNamed:@"back_icon"] style:UIBarButtonItemStyleDone target:self action:@selector(back)];
    self.navigationItem.rightBarButtonItem = [[UIBarButtonItem alloc]initWithTitle:@"保存" style:UIBarButtonItemStyleDone target:self action:@selector(addBtn)];
    self.view.backgroundColor = [UIColor whiteColor];
    UITapGestureRecognizer *Tap =[[UITapGestureRecognizer alloc] initWithTarget:self action:@selector(clearPin)];
    [self.view addGestureRecognizer:Tap];
    
    [self drawtt];
}

- (void)clearPin{
    [titleText resignFirstResponder];
    [paperNameText resignFirstResponder];
    [paperDateText resignFirstResponder];
}

- (void)back{
    [self.navigationController popViewControllerAnimated:NO];
}

- (void)addBtn{
    [self clearPin];
    if (titleText.text.length == 0 || paperNameText.text.length == 0 || paperDateText.text.length == 0) {
        return;
    }else{
    }
    Request *re = [Request shareInstance];
    NSMutableDictionary *dict = [NSMutableDictionary dictionary];
//    NSString *charactersToEscape = @"?!@#$^&%*+,:;='\"`<>()[]{}/\\| ";
//    NSCharacterSet *allowedCharacters = [[NSCharacterSet characterSetWithCharactersInString:charactersToEscape] invertedSet];
//    [dict setObject:[titleText.text stringByAddingPercentEncodingWithAllowedCharacters:allowedCharacters] forKey:@"papername"];
//    [dict setObject:[paperNameText.text stringByAddingPercentEncodingWithAllowedCharacters:allowedCharacters] forKey:@"journal"];
//    [dict setObject:[paperDateText.text stringByAddingPercentEncodingWithAllowedCharacters:allowedCharacters] forKey:@"journalnum"];
    [dict setObject:titleText.text forKey:@"papername"];
    [dict setObject:paperNameText.text forKey:@"journal"];
    [dict setObject:paperDateText.text forKey:@"journalnum"];
    
    NSMutableDictionary *dict1 = [NSMutableDictionary dictionary];
    NSData *jsonData = [NSJSONSerialization dataWithJSONObject:@[dict] options:NSJSONWritingPrettyPrinted error:nil];
    [dict1 setObject:[[NSString alloc]initWithData:jsonData encoding:NSUTF8StringEncoding] forKey:@"userdata"];
    
    [re postRequestWithUrl:@"http://apitest.meditool.cn/Apigrade/adduseredumsg?userid=593553&usertoken=81d39cb3e9167c24e1bd340f2944594b&datatype=2" params:dict1 sucessBlock:^(AFHTTPRequestOperation *operation, id responseObject) {
        
        [self.navigationController popViewControllerAnimated:NO];
        
        
    } failBlock:^(AFHTTPRequestOperation *operation, NSError *eror) {
        
    }];
}

- (void)drawtt{
    UILabel *lb1 = [[UILabel alloc]initWithFrame:CGRectMake(0, 64, 80, 59)];
    [lb1 setText:@"  论文名称"];
    lb1.backgroundColor = [UIColor whiteColor];
    [self.view addSubview:lb1];
    titleText = [[UITextField alloc]initWithFrame:CGRectMake(80, 64, WIDTH - 100, 59)];
    titleText.textAlignment = NSTextAlignmentRight;
    titleText.backgroundColor = [UIColor whiteColor];
    titleText.placeholder = @"请填写论文名称";
    [self.view addSubview:titleText];
    
    UILabel *lb11 = [[UILabel alloc]initWithFrame:CGRectMake(0, 124, 80, 59)];
    [lb11 setText:@"  期刊名称"];
    lb11.backgroundColor = [UIColor whiteColor];
    [self.view addSubview:lb11];
    paperNameText = [[UITextField alloc]initWithFrame:CGRectMake(80, 124, WIDTH - 100, 59)];
    paperNameText.textAlignment = NSTextAlignmentRight;
    paperNameText.backgroundColor = [UIColor whiteColor];
    paperNameText.placeholder = @"请填写期刊名称";
    [self.view addSubview:paperNameText];

    UILabel *lb12 = [[UILabel alloc]initWithFrame:CGRectMake(0, 184, 80, 59)];
    [lb12 setText:@"  期刊期数"];
    lb12.backgroundColor = [UIColor whiteColor];
    [self.view addSubview:lb12];
    paperDateText = [[UITextField alloc]initWithFrame:CGRectMake(80, 184, WIDTH - 100, 59)];
    paperDateText.textAlignment = NSTextAlignmentRight;
    paperDateText.backgroundColor = [UIColor whiteColor];
    paperDateText.placeholder = @"如：2017年第5期";
    [self.view addSubview:paperDateText];
    
}

- (void)cleanFirst{
    [titleText resignFirstResponder];
    [paperNameText resignFirstResponder];
    [paperDateText resignFirstResponder];
}

@end

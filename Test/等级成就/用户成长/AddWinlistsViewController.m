//
//  AddWinlistsViewController.m
//  Test
//
//  Created by wlq on 2018/6/25.
//  Copyright © 2018年 wlq. All rights reserved.
//

#import "AddWinlistsViewController.h"
#import "Request.h"
#define WIDTH [[UIScreen mainScreen]bounds].size.width
#define height [[UIScreen mainScreen]bounds].size.height

@interface AddWinlistsViewController ()<UIPickerViewDelegate,UIPickerViewDataSource,UITextFieldDelegate>{
    UITextField         *titleText;
    UILabel             *paperDate;
    UIPickerView        *myPickView;
    
    int                  yearStr;
}

@end

@implementation AddWinlistsViewController

-(void)back{
    [self.navigationController popViewControllerAnimated:YES];
}

- (void)viewDidLoad {
    [super viewDidLoad];
    self.title = @"添加获奖记录";
    self.navigationItem.leftBarButtonItem = [[UIBarButtonItem alloc]initWithImage:[UIImage imageNamed:@"back_icon"] style:UIBarButtonItemStyleDone target:self action:@selector(back)];
    self.navigationItem.rightBarButtonItem = [[UIBarButtonItem alloc]initWithTitle:@"保存" style:UIBarButtonItemStyleDone target:self action:@selector(addBtn)];
    self.view.backgroundColor = [UIColor whiteColor];
    [self drawvie];
    
    myPickView = [[UIPickerView alloc]initWithFrame:CGRectMake(0, 1000, WIDTH, 250)];
    [self.view addSubview:myPickView];
    myPickView.delegate = self;
    myPickView.dataSource = self;
    
    NSDate *currentDate = [NSDate date];
    NSDateFormatter*df = [[NSDateFormatter alloc]init];
    [df setDateFormat:@"yyyy"];
    yearStr = [[df stringFromDate:currentDate] intValue];  //当前年分
    
    UITapGestureRecognizer *Tap =[[UITapGestureRecognizer alloc] initWithTarget:self action:@selector(hidePick)];
    [self.view addGestureRecognizer:Tap];
}

- (NSInteger)numberOfComponentsInPickerView:(UIPickerView *)pickerView{
    return 1;
}

- (NSInteger)pickerView:(UIPickerView *)pickerView numberOfRowsInComponent:(NSInteger)component{
    return 50;
}

- (CGFloat)pickerView:(UIPickerView *)pickerView widthForComponent:(NSInteger)component{
    return WIDTH;
}

- (CGFloat)pickerView:(UIPickerView *)pickerView rowHeightForComponent:(NSInteger)component{
    return 50;
}

- (NSString *)pickerView:(UIPickerView *)pickerView titleForRow:(NSInteger)row forComponent:(NSInteger)component{
    return [NSString stringWithFormat:@"%i 年",yearStr - (int)row];
}

- (void)pickerView:(UIPickerView *)pickerView didSelectRow:(NSInteger)row inComponent:(NSInteger)component{
    [paperDate setText:[NSString stringWithFormat:@"%i 年",yearStr - (int)row]];
}

- (void)showPick{
    [titleText resignFirstResponder];
    [UIView animateWithDuration:0.5 animations:^{
        myPickView.frame = CGRectMake(0, height - 250, WIDTH, 250);
    }];
}

- (void)hidePick{
    [UIView animateWithDuration:0.5 animations:^{
        myPickView.frame = CGRectMake(0, 1000, WIDTH, 250);
    }];
}

- (void)addBtn{
    [self hidePick];
    if (titleText.text.length == 0 || paperDate.text.length == 0) {
        return;
    }

    Request *re = [Request shareInstance];
    NSMutableDictionary *dict = [NSMutableDictionary dictionary];
//    NSString *charactersToEscape = @"?!@#$^&%*+,:;='\"`<>()[]{}/\\| ";
//    NSCharacterSet *allowedCharacters = [[NSCharacterSet characterSetWithCharactersInString:charactersToEscape] invertedSet];
//    [dict setObject:[titleText.text stringByAddingPercentEncodingWithAllowedCharacters:allowedCharacters] forKey:@"prizename"];
//    [dict setObject:[paperDate.text stringByAddingPercentEncodingWithAllowedCharacters:allowedCharacters] forKey:@"prizedate"];
    
    [dict setObject:titleText.text forKey:@"prizename"];
    [dict setObject:paperDate.text forKey:@"prizedate"];
    NSMutableDictionary *dict1 = [NSMutableDictionary dictionary];
    NSData *jsonData = [NSJSONSerialization dataWithJSONObject:@[dict] options:NSJSONWritingPrettyPrinted error:nil];
    NSString *str = [[NSString alloc]initWithData:jsonData encoding:NSUTF8StringEncoding];
    [dict1 setObject:str forKey:@"userdata"];
    
    [re postRequestWithUrl:@"http://apitest.meditool.cn/Apigrade/adduseredumsg?userid=593553&usertoken=81d39cb3e9167c24e1bd340f2944594b&datatype=3" params:dict1 sucessBlock:^(AFHTTPRequestOperation *operation, id responseObject) {
        
    [self.navigationController popViewControllerAnimated:NO];
        

    } failBlock:^(AFHTTPRequestOperation *operation, NSError *eror) {
        
    }];
}

- (void)drawvie{
    UILabel *lb12 = [[UILabel alloc]initWithFrame:CGRectMake(0, 64, 80, 59)];
    [lb12 setText:@"  奖项名称"];
    lb12.backgroundColor = [UIColor whiteColor];
    [self.view addSubview:lb12];
    titleText = [[UITextField alloc]initWithFrame:CGRectMake(80, 64, WIDTH - 100, 59)];
    titleText.textAlignment = NSTextAlignmentRight;
    titleText.backgroundColor = [UIColor whiteColor];
    titleText.delegate = self;
    titleText.placeholder = @"请填写奖项名称  ";
    [self.view addSubview:titleText];
    UILabel *lb13 = [[UILabel alloc]initWithFrame:CGRectMake(0, 124, 80, 59)];
    [lb13 setText:@"  年份"];
    lb13.backgroundColor = [UIColor whiteColor];
    [self.view addSubview:lb13];
    paperDate = [[UILabel alloc]initWithFrame:CGRectMake(80, 124, WIDTH - 100, 59)];
    [paperDate setText:@"  请选择年份"];
    paperDate.textAlignment = NSTextAlignmentRight;
    paperDate.backgroundColor = [UIColor whiteColor];
    [self.view addSubview:paperDate];
    UIButton *btn = [[UIButton alloc]initWithFrame:CGRectMake(WIDTH - 120, 124, 120, 59)];
    [self.view addSubview:btn];
    btn.alpha = 0.1;
    btn.tag = 101;
    [btn addTarget:self action:@selector(seleYear) forControlEvents:UIControlEventTouchUpInside];
    
}

- (BOOL)textFieldShouldBeginEditing:(UITextField *)textField{
    [self hidePick];
    return YES;
}

- (void)seleYear{
    [self showPick];
}

@end

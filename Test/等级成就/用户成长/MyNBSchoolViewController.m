//
//  MyNBSchoolViewController.m
//  Test
//
//  Created by wlq on 2018/6/25.
//  Copyright © 2018年 wlq. All rights reserved.
//

#import "MyNBSchoolViewController.h"
#import "SearchSchoolTabViewController.h"
#import "Request.h"

#define WIDTH [[UIScreen mainScreen]bounds].size.width
#define HEIGHT [[UIScreen mainScreen]bounds].size.height

@interface MyNBSchoolViewController ()<UIScrollViewDelegate,ChooseSchoolDelegate,UITextFieldDelegate,UIPickerViewDataSource,UIPickerViewDelegate>{
    UIScrollView       *mainScrol;
    
    UITextField         *dzscName;
    UITextField         *bkscName;
    UITextField         *ssscName;
    UITextField         *bsscName;
    
    UITextField         *dzzyName;
    UITextField         *bkzyName;
    UITextField         *sszyName;
    UITextField         *bszyName;
    
    UILabel            *dztimeLb;
    UILabel            *bktimeLb;
    UILabel            *sstimeLb;
    UILabel            *bstimeLb;
    
    NSMutableDictionary *dzdict;
    NSMutableDictionary *bkdict;
    NSMutableDictionary *ssdict;
    NSMutableDictionary *bsdict;
    UIPickerView        *myPickView;
    int                  yearStr;
    int                  selenum;
}

@end

@implementation MyNBSchoolViewController

- (void)viewDidLoad {
    [super viewDidLoad];
    self.title = @"毕业院校";
    self.navigationItem.leftBarButtonItem = [[UIBarButtonItem alloc]initWithImage:[UIImage imageNamed:@"back_icon"] style:UIBarButtonItemStyleDone target:self action:@selector(back)];
    self.navigationItem.rightBarButtonItem = [[UIBarButtonItem alloc]initWithTitle:@"保存" style:UIBarButtonItemStyleDone target:self action:@selector(saveBtn)];
    selenum = 100;
    dzdict = [NSMutableDictionary new];
    bkdict = [NSMutableDictionary new];
    ssdict = [NSMutableDictionary new];
    bsdict = [NSMutableDictionary new];
    
    [[NSNotificationCenter defaultCenter] addObserver:self
                                             selector:@selector(keyboardWillHide)
                                                 name:UIKeyboardWillHideNotification
                                               object:nil];
    
    [[NSNotificationCenter defaultCenter] addObserver:self
                                             selector:@selector(keyboardDidShow:)
                                                 name:UIKeyboardDidShowNotification
                                               object:nil];
    
    self.view.backgroundColor = [UIColor whiteColor];
    [self drawScr];
    
    myPickView = [[UIPickerView alloc]initWithFrame:CGRectMake(0, 1000, WIDTH, 200)];
    [self.view addSubview:myPickView];
    myPickView.backgroundColor = [UIColor grayColor];
    myPickView.delegate = self;
    myPickView.dataSource = self;
    NSDate *currentDate = [NSDate date];
    NSDateFormatter*df = [[NSDateFormatter alloc]init];
    [df setDateFormat:@"yyyy"];
    yearStr = [[df stringFromDate:currentDate] intValue];  //当前年分
}

- (void)keyboardDidShow:(NSNotification *)noti{
    NSDictionary *info = [noti userInfo];
    NSValue* aValue = [info objectForKey:UIKeyboardFrameEndUserInfoKey];
    CGRect keyboardRect = [aValue CGRectValue];
    mainScrol.frame = CGRectMake(0, 64, WIDTH, HEIGHT - keyboardRect.size.height - 64);

}

- (void)keyboardWillHide{
//    NSDictionary *info = [noti userInfo];
//    NSValue *animationDurationValue = [info objectForKey:UIKeyboardAnimationDurationUserInfoKey];
//    NSTimeInterval animationDuration;
//    [animationDurationValue getValue:&animationDuration];
    mainScrol.frame = CGRectMake(0, 64, WIDTH, HEIGHT - 64);
}

- (void)dealloc{
    [[NSNotificationCenter defaultCenter] removeObserver:self name:UIKeyboardWillHideNotification object:nil];
    [[NSNotificationCenter defaultCenter] removeObserver:self name:UIKeyboardDidShowNotification object:nil];
}

- (void)saveBtn{
    NSMutableArray *dataArr = [NSMutableArray new];
    if (dzscName.text.length != 0 || dzzyName.text.length !=0 || dztimeLb.text.length != 0) {
        if (dzscName.text.length == 0 || dzzyName.text.length == 0 || dztimeLb.text.length == 0) {
            //提示一下，要么补全要么删掉
        }else{
            // 信息是全的 id和时间在选的时候就写入了
            [dzdict setObject:dzzyName.text forKey:@"major"];
            [dzdict setObject:[dztimeLb.text stringByReplacingOccurrencesOfString:@"年" withString:@""] forKey:@"graduatetime"];
            [dzdict setObject:@"0" forKey:@"education"];
            [dataArr addObject: dzdict];
        }
    }else{
    }
    
    if (bkscName.text.length != 0 || bkzyName.text.length !=0 || bktimeLb.text.length != 0){
        if (bkscName.text.length == 0 || bkzyName.text.length == 0 || bktimeLb.text.length == 0) {
        }else{
            // 信息是全的 id和时间在选的时候就写入了
            [bkdict setObject:bkzyName.text forKey:@"major"];
            [bkdict setObject:[bktimeLb.text stringByReplacingOccurrencesOfString:@"年" withString:@""] forKey:@"graduatetime"];
            [bkdict setObject:@"1" forKey:@"education"];
            [dataArr addObject: bkdict];
        }
    }else{
    }
    
    if (ssscName.text.length != 0 || sszyName.text.length !=0 || sstimeLb.text.length != 0){
        if (ssscName.text.length == 0 || sszyName.text.length == 0 || sstimeLb.text.length == 0) {
        }else{
            // 信息是全的 id和时间在选的时候就写入了
            [ssdict setObject:sszyName.text forKey:@"major"];
            [ssdict setObject:[sstimeLb.text stringByReplacingOccurrencesOfString:@"年" withString:@""] forKey:@"graduatetime"];
            [ssdict setObject:@"2" forKey:@"education"];
            [dataArr addObject: ssdict];
        }
    }
    
    if (bsscName.text.length != 0 || bszyName.text.length !=0 || bstimeLb.text.length != 0){
        if (bsscName.text.length == 0 || bszyName.text.length == 0 || bstimeLb.text.length == 0) {
        }else{
            // 信息是全的 id和时间在选的时候就写入了
            [bsdict setObject:bszyName.text forKey:@"major"];
            [bsdict setObject:[bstimeLb.text stringByReplacingOccurrencesOfString:@"年" withString:@""] forKey:@"graduatetime"];
            [bsdict setObject:@"3" forKey:@"education"];
            [dataArr addObject: bsdict];
        }
    }
    
    Request *re = [Request shareInstance];
    
    NSMutableDictionary *dict1 = [NSMutableDictionary dictionary];
    NSData *jsonData = [NSJSONSerialization dataWithJSONObject:dataArr options:NSJSONWritingPrettyPrinted error:nil];
    [dict1 setObject:[[NSString alloc]initWithData:jsonData encoding:NSUTF8StringEncoding] forKey:@"userdata"];
    [re postRequestWithUrl:@"http://apitest.meditool.cn/Apigrade/adduseredumsg?userid=593553&usertoken=81d39cb3e9167c24e1bd340f2944594b&datatype=0" params:dict1 sucessBlock:^(AFHTTPRequestOperation *operation, id responseObject) {
        
        [self dismissViewControllerAnimated:YES completion:^{
        }];
        
    } failBlock:^(AFHTTPRequestOperation *operation, NSError *eror) {
        
    }];
}

- (NSInteger)numberOfComponentsInPickerView:(UIPickerView *)pickerView{
    return 1;
}

- (NSInteger)pickerView:(UIPickerView *)pickerView numberOfRowsInComponent:(NSInteger)component{
    return 40;
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
    if (selenum == 100) {
        [dztimeLb setText:[NSString stringWithFormat:@"%i 年",yearStr - (int)row]];
    }else if (selenum == 101){
        [bktimeLb setText:[NSString stringWithFormat:@"%i 年",yearStr - (int)row]];
    }else if(selenum == 102){
        [sstimeLb setText:[NSString stringWithFormat:@"%i 年",yearStr - (int)row]];
    }else{
        [bstimeLb setText:[NSString stringWithFormat:@"%i 年",yearStr - (int)row]];
    }
}

- (void)showPick{
    [UIView animateWithDuration:0 animations:^{
        myPickView.frame = CGRectMake(0, HEIGHT - 200, WIDTH, 200);
        mainScrol.frame = CGRectMake(0, 64, WIDTH, HEIGHT - 64 - 200);
    }];
}

- (void)hidePick{
    [UIView animateWithDuration:0 animations:^{
        myPickView.frame = CGRectMake(0, 1000, WIDTH, 200);
        mainScrol.frame = CGRectMake(0, 64, WIDTH, HEIGHT - 64);
    }];
}

- (void)back{
    [self dismissViewControllerAnimated:YES completion:^{
        NSLog(@"dismiss返回");
    }];
}

- (void)scrollViewDidScroll:(UIScrollView *)scrollView{
    
}

- (void)scrollViewWillBeginDragging:(UIScrollView *)scrollView{
    [self cleantextal];
    [self hidePick];
}

- (void)drawScr{
    mainScrol = [[UIScrollView alloc]init];
    mainScrol.frame = CGRectMake(0, 64, WIDTH, HEIGHT - 64);
    mainScrol.delegate = self;
    [self.view addSubview:mainScrol];
    
    UILabel *lb1 = [[UILabel alloc]initWithFrame:CGRectMake(0, 0, WIDTH, 59)];
    [lb1 setText:@"  大专"];
    lb1.font = [UIFont systemFontOfSize:15];
    lb1.backgroundColor = [UIColor whiteColor];
    [mainScrol addSubview:lb1];
    UILabel *lb11 = [[UILabel alloc]initWithFrame:CGRectMake(0, 60, 80, 59)];
    [lb11 setText:@"  学校名称"];
    lb11.backgroundColor = [UIColor whiteColor];
    [mainScrol addSubview:lb11];
    dzscName = [[UITextField alloc]initWithFrame:CGRectMake(80, 60, WIDTH - 100, 59)];
    dzscName.textAlignment = NSTextAlignmentRight;
    dzscName.backgroundColor = [UIColor whiteColor];
    dzscName.placeholder = @"请填写学校名称  ";
    dzscName.delegate = self;
    [mainScrol addSubview:dzscName];
    UIButton *btna = [[UIButton alloc]initWithFrame:CGRectMake(80, 60, WIDTH - 100, 59)];
    [mainScrol addSubview:btna];
    btna.alpha = 0.1;
    btna.tag = 200;
    [btna addTarget:self action:@selector(gotosearch:) forControlEvents:UIControlEventTouchUpInside];
    [mainScrol addSubview: btna];
    UILabel *lb12 = [[UILabel alloc]initWithFrame:CGRectMake(0, 120, 80, 59)];
    [lb12 setText:@"  专业"];
    lb12.backgroundColor = [UIColor whiteColor];
    [mainScrol addSubview:lb12];
    dzzyName = [[UITextField alloc]initWithFrame:CGRectMake(80, 120, WIDTH - 100, 59)];
    dzzyName.textAlignment = NSTextAlignmentRight;
    dzzyName.backgroundColor = [UIColor whiteColor];
    dzzyName.delegate = self;
    dzzyName.placeholder = @"请填写专业名称  ";
    [mainScrol addSubview:dzzyName];
    UILabel *lb13 = [[UILabel alloc]initWithFrame:CGRectMake(0, 180, 80, 59)];
    [lb13 setText:@"  毕业时间"];
    lb13.backgroundColor = [UIColor whiteColor];
    [mainScrol addSubview:lb13];
    dztimeLb = [[UILabel alloc]initWithFrame:CGRectMake(80, 180, WIDTH - 100, 59)];
    [dztimeLb setText:@"  请选择"];
    dztimeLb.textAlignment = NSTextAlignmentRight;
    dztimeLb.backgroundColor = [UIColor whiteColor];
    [mainScrol addSubview:dztimeLb];
    UIButton *btn1 = [[UIButton alloc]initWithFrame:CGRectMake(80, 180, WIDTH - 100, 59)];
    [mainScrol addSubview:btn1];
    btn1.alpha = 0.1;
    btn1.tag = 100;
    [btn1 addTarget:self action:@selector(seleYear:) forControlEvents:UIControlEventTouchUpInside];
    UILabel *lb111 = [[UILabel alloc]initWithFrame:CGRectMake(0, 240, WIDTH, 10)];
    [lb111 setText:@""];
    lb111.backgroundColor = [UIColor lightGrayColor];
    [mainScrol addSubview:lb111];
    
    UILabel *lb2 = [[UILabel alloc]initWithFrame:CGRectMake(0, 250*1, WIDTH, 59)];
    [lb2 setText:@"  本科"];
    lb2.font = [UIFont systemFontOfSize:15];
    lb2.backgroundColor = [UIColor whiteColor];
    [mainScrol addSubview:lb2];
    UILabel *lb21 = [[UILabel alloc]initWithFrame:CGRectMake(0, 310, 80, 59)];
    [lb21 setText:@"  学校名称"];
    lb21.backgroundColor = [UIColor whiteColor];
    [mainScrol addSubview:lb21];
    bkscName = [[UITextField alloc]initWithFrame:CGRectMake(80, 310, WIDTH - 100, 59)];
    bkscName.delegate = self;
    bkscName.textAlignment = NSTextAlignmentRight;
    bkscName.backgroundColor = [UIColor whiteColor];
    bkscName.placeholder = @"请填写学校名称  ";
    [mainScrol addSubview:bkscName];
    UIButton *btnb = [[UIButton alloc]initWithFrame:CGRectMake(80, 310, WIDTH - 100, 59)];
    [mainScrol addSubview:btnb];
    btnb.alpha = 0.1;
    btnb.tag = 201;
    [btnb addTarget:self action:@selector(gotosearch:) forControlEvents:UIControlEventTouchUpInside];
    [mainScrol addSubview: btnb];
    UILabel *lb22 = [[UILabel alloc]initWithFrame:CGRectMake(0, 370, 80, 59)];
    [lb22 setText:@"  专业"];
    lb22.backgroundColor = [UIColor whiteColor];
    [mainScrol addSubview:lb22];
    bkzyName = [[UITextField alloc]initWithFrame:CGRectMake(80, 370, WIDTH - 100, 59)];
    bkzyName.delegate = self;
    bkzyName.textAlignment = NSTextAlignmentRight;
    bkzyName.backgroundColor = [UIColor whiteColor];
    bkzyName.placeholder = @"请填写专业名称  ";
    [mainScrol addSubview:bkzyName];
    UILabel *lb23 = [[UILabel alloc]initWithFrame:CGRectMake(0, 430, 80, 59)];
    [lb23 setText:@"  毕业时间"];
    lb23.backgroundColor = [UIColor whiteColor];
    [mainScrol addSubview:lb23];
    bktimeLb = [[UILabel alloc]initWithFrame:CGRectMake(80, 430, WIDTH - 100, 59)];
    [bktimeLb setText:@"  请选择"];
    bktimeLb.textAlignment = NSTextAlignmentRight;
    bktimeLb.backgroundColor = [UIColor whiteColor];
    [mainScrol addSubview:bktimeLb];
    UIButton *btn2 = [[UIButton alloc]initWithFrame:CGRectMake(80, 430, WIDTH - 100, 59)];
    [mainScrol addSubview:btn2];
    btn2.alpha = 0.1;
    btn2.tag = 101;
    [btn2 addTarget:self action:@selector(seleYear:) forControlEvents:UIControlEventTouchUpInside];
    UILabel *lb222 = [[UILabel alloc]initWithFrame:CGRectMake(0, 490, WIDTH, 10)];
    [lb222 setText:@""];
    lb222.backgroundColor = [UIColor lightGrayColor];
    [mainScrol addSubview:lb222];
    
    UILabel *lb3 = [[UILabel alloc]initWithFrame:CGRectMake(0, 250*2, WIDTH, 59)];
    [lb3 setText:@"  硕士"];
    lb3.font = [UIFont systemFontOfSize:15];
    lb3.backgroundColor = [UIColor whiteColor];
    [mainScrol addSubview:lb3];
    UILabel *lb31 = [[UILabel alloc]initWithFrame:CGRectMake(0, 560, 80, 59)];
    [lb31 setText:@"  学校名称"];
    lb31.backgroundColor = [UIColor whiteColor];
    [mainScrol addSubview:lb31];
    ssscName = [[UITextField alloc]initWithFrame:CGRectMake(80, 560, WIDTH - 100, 59)];
    ssscName.delegate = self;
    ssscName.textAlignment = NSTextAlignmentRight;
    ssscName.backgroundColor = [UIColor whiteColor];
    ssscName.placeholder = @"请填写学校名称  ";
    [mainScrol addSubview:ssscName];
    UIButton *btnc = [[UIButton alloc]initWithFrame:CGRectMake(80, 560, WIDTH - 100, 59)];
    [mainScrol addSubview:btnc];
    btnc.alpha = 0.1;
    btnc.tag = 202;
    [btnc addTarget:self action:@selector(gotosearch:) forControlEvents:UIControlEventTouchUpInside];
    [mainScrol addSubview: btnc];
    UILabel *lb32 = [[UILabel alloc]initWithFrame:CGRectMake(0, 620, 80, 59)];
    [lb32 setText:@"  专业"];
    lb32.backgroundColor = [UIColor whiteColor];
    [mainScrol addSubview:lb32];
    sszyName = [[UITextField alloc]initWithFrame:CGRectMake(80, 620, WIDTH - 100, 59)];
    sszyName.delegate = self;
    sszyName.textAlignment = NSTextAlignmentRight;
    sszyName.backgroundColor = [UIColor whiteColor];
    sszyName.placeholder = @"请填写专业名称  ";
    [mainScrol addSubview:sszyName];
    UILabel *lb33 = [[UILabel alloc]initWithFrame:CGRectMake(0, 680, 80, 59)];
    [lb33 setText:@"  毕业时间"];
    lb33.backgroundColor = [UIColor whiteColor];
    [mainScrol addSubview:lb33];
    sstimeLb = [[UILabel alloc]initWithFrame:CGRectMake(80, 680, WIDTH - 100, 59)];
    [sstimeLb setText:@"  请选择"];
    sstimeLb.textAlignment = NSTextAlignmentRight;
    sstimeLb.backgroundColor = [UIColor whiteColor];
    [mainScrol addSubview:sstimeLb];
    UIButton *btn3 = [[UIButton alloc]initWithFrame:CGRectMake(80, 680, WIDTH - 100, 59)];
    [mainScrol addSubview:btn3];
    btn3.alpha = 0.1;
    btn3.tag = 102;
    [btn3 addTarget:self action:@selector(seleYear:) forControlEvents:UIControlEventTouchUpInside];
    UILabel *lb333 = [[UILabel alloc]initWithFrame:CGRectMake(0, 740, WIDTH, 10)];
    [lb333 setText:@""];
    lb333.backgroundColor = [UIColor lightGrayColor];
    [mainScrol addSubview:lb333];
    
    UILabel *lb4 = [[UILabel alloc]initWithFrame:CGRectMake(0, 250*3, WIDTH, 59)];
    [lb4 setText:@"  博士"];
    lb4.font = [UIFont systemFontOfSize:15];
    lb4.backgroundColor = [UIColor whiteColor];
    [mainScrol addSubview:lb4];
    UILabel *lb41 = [[UILabel alloc]initWithFrame:CGRectMake(0, 810, 80, 59)];
    [lb41 setText:@"  学校名称"];
    lb41.backgroundColor = [UIColor whiteColor];
    [mainScrol addSubview:lb41];
    bsscName = [[UITextField alloc]initWithFrame:CGRectMake(80, 810, WIDTH - 100, 59)];
    bsscName.delegate = self;
    bsscName.textAlignment = NSTextAlignmentRight;
    bsscName.backgroundColor = [UIColor whiteColor];
    bsscName.placeholder = @"请填写学校名称  ";
    [mainScrol addSubview:bsscName];
    UIButton *btnd = [[UIButton alloc]initWithFrame:CGRectMake(80, 810, WIDTH - 100, 59)];
    [mainScrol addSubview:btnd];
    btnd.alpha = 0.1;
    btnd.tag = 203;
    [btnd addTarget:self action:@selector(gotosearch:) forControlEvents:UIControlEventTouchUpInside];
    [mainScrol addSubview: btnd];
    UILabel *lb42 = [[UILabel alloc]initWithFrame:CGRectMake(0, 870, 80, 59)];
    [lb42 setText:@"  专业"];
    lb42.backgroundColor = [UIColor whiteColor];
    [mainScrol addSubview:lb42];
    bszyName = [[UITextField alloc]initWithFrame:CGRectMake(80, 870, WIDTH - 100, 59)];
    bszyName.delegate = self;
    bszyName.textAlignment = NSTextAlignmentRight;
    bszyName.backgroundColor = [UIColor whiteColor];
    bszyName.placeholder = @"请填写专业名称  ";
    [mainScrol addSubview:bszyName];
    UILabel *lb43 = [[UILabel alloc]initWithFrame:CGRectMake(0, 930, 80, 59)];
    [lb43 setText:@"  毕业时间"];
    lb43.backgroundColor = [UIColor whiteColor];
    [mainScrol addSubview:lb43];
    bstimeLb = [[UILabel alloc]initWithFrame:CGRectMake(80, 930, WIDTH - 100, 59)];
    [bstimeLb setText:@"  请选择"];
    bstimeLb.textAlignment = NSTextAlignmentRight;
    bstimeLb.backgroundColor = [UIColor whiteColor];
    [mainScrol addSubview:bstimeLb];
    UIButton *btn4 = [[UIButton alloc]initWithFrame:CGRectMake(80, 930, WIDTH - 100, 59)];
    [mainScrol addSubview:btn4];
    btn4.alpha = 0.1;
    btn4.tag = 103;
    [btn4 addTarget:self action:@selector(seleYear:) forControlEvents:UIControlEventTouchUpInside];
    
    mainScrol.contentSize = CGSizeMake(WIDTH, 1010);
}

- (void)gotosearch:(UIButton *)btn{
    [self cleantextal];
    [self hidePick];
    SearchSchoolTabViewController *searchVC = [[SearchSchoolTabViewController alloc]init];
    searchVC.delegate = self;
    searchVC.tagNum =(int)btn.tag;
    [self.navigationController pushViewController:searchVC animated:YES];
}

- (void)cleantextal{
    [dzscName resignFirstResponder];
    [bkscName resignFirstResponder];
    [ssscName resignFirstResponder];
    [bsscName resignFirstResponder];
    
    [dzzyName resignFirstResponder];
    [bkzyName resignFirstResponder];
    [sszyName resignFirstResponder];
    [bszyName resignFirstResponder];
}

- (void)seleYear:(UIButton *)sender{
    [self cleantextal];
    selenum = (int)sender.tag;
    [self showPick];
}

- (BOOL)textFieldShouldBeginEditing:(UITextField *)textField{
    [self hidePick];
    return YES;
}

- (void)commitWithModel:(MedicalSchoolsModel *)model andtagNum:(int)num{
    if (num == 200) {
        [dzscName setText:model.schoolName];
        [dzdict setObject:model.schoolId forKey:@"schoolid"];
    }else if (num == 201){
        [bkscName setText:model.schoolName];
        [bkdict setObject:model.schoolId forKey:@"schoolid"];
    }else if (num == 202){
        [ssscName setText:model.schoolName];
        [ssdict setObject:model.schoolId forKey:@"schoolid"];
    }else if(num == 203){
        [bsscName setText:model.schoolName];
        [bsdict setObject:model.schoolId forKey:@"schoolid"];
    }else{}
}

@end

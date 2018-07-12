//
//  SearchSchoolTabViewController.m
//  Test
//
//  Created by wlq on 2018/6/27.
//  Copyright © 2018年 wlq. All rights reserved.
//

#import "SearchSchoolTabViewController.h"

#import "NDSearchTool.h"
#import "PlistDao.h"
#define WIDTH [[UIScreen mainScreen]bounds].size.width
#define height [[UIScreen mainScreen]bounds].size.height

@interface SearchSchoolTabViewController ()<UITableViewDataSource, UITableViewDelegate, UISearchBarDelegate>{
    UITableView               *searTab;
    UISearchDisplayController        *searchDisplayController;
    UISearchBar               *searchBar;
    NSMutableArray            *dataSource;
    NSMutableArray            *searchDataSource;
    
}

@end

@implementation SearchSchoolTabViewController

- (void)viewDidLoad {
    [super viewDidLoad];
    
    self.title = @"查找学校";
    self.navigationItem.leftBarButtonItem = [[UIBarButtonItem alloc]initWithImage:[UIImage imageNamed:@"back_icon"] style:UIBarButtonItemStyleDone target:self action:@selector(back)];
    
    self.view.backgroundColor = [UIColor whiteColor];
    dataSource = [self dataSource];
    [self.view addSubview:searchBar];
    searchBar.frame = CGRectMake(0, 64, WIDTH, 50);
    searTab = [[UITableView alloc]initWithFrame:CGRectMake(0, 64+50, WIDTH, height-64-50) style:UITableViewStylePlain];
    searTab.dataSource = self;
    searTab.delegate = self;
    [self.view addSubview:searTab];
//    searTab.tableHeaderView = searchBar;
}

- (CGFloat)tableView:(UITableView *)tableView heightForHeaderInSection:(NSInteger)section{
    return 1.0;
    
}

- (void)back{
    [self.navigationController popViewControllerAnimated:YES];
}

- (UITableViewCell *)tableView:(UITableView *)tableView cellForRowAtIndexPath:(NSIndexPath *)indexPath{
    static NSString *ID = @"cell";
    UITableViewCell *cell = [tableView dequeueReusableCellWithIdentifier:ID];
    if (!cell) {
        cell = [[UITableViewCell alloc] initWithStyle:UITableViewCellStyleSubtitle reuseIdentifier:ID];
    }
    
    MedicalSchoolsModel *model;
    if (searTab == tableView) {
        model = dataSource[indexPath.row];
    } else {
        model = searchDataSource[indexPath.row];
    }
    
    cell.textLabel.text = [NSString stringWithFormat:@"%@",model.schoolName];
    return cell;
}

- (NSInteger)tableView:(UITableView *)tableView numberOfRowsInSection:(NSInteger)section{
    if (searTab == tableView) {
        return dataSource.count;
    }
    return searchDataSource.count;
}

- (CGFloat)tableView:(UITableView *)tableView heightForRowAtIndexPath:(NSIndexPath *)indexPath{
    return 40;
}

- (NSMutableArray *)dataSource{
    if (dataSource) {
        return dataSource;
    }
    dataSource = [NSMutableArray array];
    
    NSMutableDictionary *diccc = [NSMutableDictionary dictionary];
    diccc = [PlistDao readKeyDictionary:@"SchoolList.plist" key:@"mdschoollist"];
    NSMutableArray *scdata = [[diccc objectForKey:@"mdschool"] mutableCopy];

    for (NSDictionary *dict in scdata) {
        MedicalSchoolsModel *model = [[MedicalSchoolsModel alloc] initWithDict:dict];
        [dataSource addObject:model];
    }   //获得学校model的集合
    
    return dataSource;
}

- (BOOL)searchBarShouldBeginEditing:(UISearchBar *)searchBar{
    searchBar.frame = CGRectMake(0, 20, WIDTH, 50);
    searTab.frame = CGRectMake(0, 70, WIDTH, height);
    return YES;
}

- (void)searchBarTextDidEndEditing:(UISearchBar *)searchBar{
    if (searchBar.text.length != 0) {
        return;
    }
    searchBar.frame = CGRectMake(0, 61, WIDTH, 50);
    searTab.frame = CGRectMake(0, 64+50, WIDTH, height-64-50);
}

-(void)searchBar:(UISearchBar *)searchBar textDidChange:(NSString *)searchText{
    searchDataSource = (NSMutableArray *)[[NDSearchTool tool] searchWithFieldArray:@[@"schoolName",@"schoolPY"]
                                                                            inputString:searchText
                                                                                inArray:self.dataSource];
    [searchDisplayController.searchResultsTableView reloadData];
}

- (UISearchBar *)searchBar{
    if (searchBar) {
        return searchBar;
    }
    
//    searchBar = [[UISearchBar alloc] initWithFrame:CGRectMake(0, 0, CGRectGetWidth([UIScreen mainScreen].bounds), 50)];
    searchBar = [[UISearchBar alloc]init];
    searchBar.placeholder = @"您可通过名称或简拼进行查询";
    UITextField * searchField = [searchBar valueForKey:@"_searchField"];
    [searchField setValue:[UIFont boldSystemFontOfSize:15] forKeyPath:@"_placeholderLabel.font"];
    searchBar.delegate = self;
    
    return searchBar;
}

- (UISearchDisplayController *)searchDisplayController{
    if (searchDisplayController) {
        return searchDisplayController;
    }
    searchDisplayController = [[UISearchDisplayController alloc] initWithSearchBar:self.searchBar contentsController:self];
    searchDisplayController.searchResultsTableView.dataSource = self;
    searchDisplayController.searchResultsTableView.delegate = self;
    searchDisplayController.searchResultsTableView.bounces = NO;
    return searchDisplayController;
}

- (void)tableView:(UITableView *)tableView didSelectRowAtIndexPath:(NSIndexPath *)indexPath{
    MedicalSchoolsModel *model = [[MedicalSchoolsModel alloc]init];
    if (searTab == tableView) {
        model = dataSource[indexPath.row];
    }else{
        model = searchDataSource[indexPath.row];
        
    }
    if (_delegate && [_delegate respondsToSelector:@selector(commitWithModel:andtagNum:)]) {
        [_delegate commitWithModel:model andtagNum:_tagNum];
    }
    [self.navigationController popViewControllerAnimated:YES];
}

@end

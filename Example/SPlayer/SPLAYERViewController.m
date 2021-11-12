//
//  SPLAYERViewController.m
//  SPlayer
//
//  Created by levine_hhb@163.com on 11/10/2021.
//  Copyright (c) 2021 levine_hhb@163.com. All rights reserved.
//

#import "SPLAYERViewController.h"


@interface SPLAYERViewController ()<UITableViewDelegate,UITableViewDataSource>

@property (nonatomic, strong) UITableView *tableView;

@end

@implementation SPLAYERViewController

- (NSArray *)data{
    return @[@"PlayUIViewController",
             @"AutoPlayTableController"];
}

- (NSInteger)numberOfSectionsInTableView:(UITableView *)tableView{
    return 1;
}

- (NSInteger)tableView:(UITableView *)tableView numberOfRowsInSection:(NSInteger)section{
    return [self data].count;
}

- (CGFloat)tableView:(UITableView *)tableView heightForRowAtIndexPath:(NSIndexPath *)indexPath{
    return 60;
}

- (UITableViewCell *)tableView:(UITableView *)tableView cellForRowAtIndexPath:(NSIndexPath *)indexPath{
    UITableViewCell *cell = [[UITableViewCell alloc] initWithStyle:UITableViewCellStyleDefault reuseIdentifier:@"cell"];
//    cell.backgroundColor = randomColor;
    UILabel *lab = [[UILabel alloc] initWithFrame:CGRectMake(15, 0, tableView.bounds.size.width - 15, 60)];
    [cell addSubview:lab];
    lab.text = [self data][indexPath.row];
    return cell;
}

- (void)tableView:(UITableView *)tableView didSelectRowAtIndexPath:(NSIndexPath *)indexPath{
    NSString *str_vc = [self data][indexPath.row];
    UIViewController *vc = [[NSClassFromString(str_vc) alloc] init];
    [self.navigationController pushViewController:vc animated:NO];
}

- (void)viewDidLoad {
    [super viewDidLoad];
    
    self.tableView = [[UITableView alloc] initWithFrame:CGRectMake(0, 0, self.view.bounds.size.height, self.view.bounds.size.width)];
    [self.view addSubview:self.tableView];
    self.tableView.dataSource = self;
    self.tableView.delegate = self;
    
    return;
    
}


- (void)didReceiveMemoryWarning
{
    [super didReceiveMemoryWarning];
    // Dispose of any resources that can be recreated.
}

@end

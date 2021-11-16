//
//  AutoPlayTableController.m
//  SPlayer_Example
//
//  Created by 小黄 on 2021/11/11.
//  Copyright © 2021 levine_hhb@163.com. All rights reserved.
//

#import "AutoPlayTableController.h"
#import <SUPlayer.h>
#import "AutoPlayTableViewCell.h"
#import "Constant.h"


@interface AutoPlayTableController ()<UITableViewDelegate,UITableViewDataSource>

@property (nonatomic, strong) UITableView *tableView;

@property (nonatomic, retain) NSMutableArray *observer;

@end

@implementation AutoPlayTableController

- (void)viewDidLoad {
    [super viewDidLoad];
    self.tableView = [[UITableView alloc] initWithFrame:CGRectMake(0, 0, self.view.bounds.size.width, self.view.bounds.size.height)];
    [self.view addSubview:self.tableView];
    self.tableView.dataSource = self;
    self.tableView.delegate = self;
    self.observer = [NSMutableArray array];
    
    UIBarButtonItem *item = [[UIBarButtonItem alloc] initWithTitle:@"CLEAR" style:UIBarButtonItemStylePlain target:self action:@selector(clearCache)];
//    self.navigationController.navigationItem.rightBarButtonItem = item;
    [self.navigationItem setRightBarButtonItem:item];
}

- (void)clearCache{
    [SUPlayer clearCache];
}

- (NSInteger)numberOfSectionsInTableView:(UITableView *)tableView{
    return 1;
}

- (NSInteger)tableView:(UITableView *)tableView numberOfRowsInSection:(NSInteger)section{
    return [self data].count;
}

- (CGFloat)tableView:(UITableView *)tableView heightForRowAtIndexPath:(NSIndexPath *)indexPath{
    return 300;
}

- (UITableViewCell *)tableView:(UITableView *)tableView cellForRowAtIndexPath:(NSIndexPath *)indexPath{
    NSString *string = [NSString stringWithFormat:@"AutoPlayTableViewCell%@",@(indexPath.section * 100 + indexPath.row)];
    AutoPlayTableViewCell *cell = [tableView dequeueReusableCellWithIdentifier:string];
    if (cell == nil) {
        cell = [[AutoPlayTableViewCell alloc] initWithStyle:UITableViewCellStyleDefault reuseIdentifier:string];
        [tableView addObserver:cell forKeyPath:@"contentOffset" options:NSKeyValueObservingOptionNew context:nil];
        [self.observer addObject:cell];
        CGRect rectInTableView = [tableView rectForRowAtIndexPath:indexPath];
        cell.rectInSuper = rectInTableView;
        cell.backgroundColor = randomColor;
        [cell configPlayerWithUrl:[self data][indexPath.row]];
    }
    if (indexPath.row == 0) {
        cell.player.muted = YES;
    }
    return cell;
}

- (NSArray *)data{
    return @[
        @"http://roki.oss-cn-hangzhou.aliyuncs.com/cookbook/video/step/ed554c11-0557-4c48-ad11-d3d4af80cdb8.mp4",
        @"http://roki.oss-cn-hangzhou.aliyuncs.com/cookbook/video/step/ed554c11-0557-4c48-ad11-d3d4af80cdb8.mp4"
//        @"http://roki.oss-cn-hangzhou.aliyuncs.com/cookbook/video/step/ad924e7e-195d-47c5-ba8c-823ab674533cw1920h1080.mp4"
//        ,@"http://roki.oss-cn-hangzhou.aliyuncs.com/cookbook/video/step/4e1808f5-02ad-4dbd-8241-df1c8c4b8d1ew720h960.mp4"
    ];
}

- (void)scrollViewDidScroll:(UIScrollView *)scrollView{
    
//    NSLog(@"大小 == %@",@(scrollView.contentOffset));
//    NSLog(@"大小 == %@",@(scrollView.contentSize));
    
//    NSArray *array = _tableView.visibleCells;
//    NSArray *array1 = _tableView.indexPathsForVisibleRows;
    
//
//    NSLog(@" 移动位置 %@",cell.identify);

//    NSLog(@"scrollViewDidScroll 移动位置 %@  %@",@(array.count),@(array1.count));
//    NSLog(@"scrollViewDidScroll 移动位置 %@",@(scrollView.contentOffset));
    
//    for (int i = 0; i < array.count; i++) {
//        AutoPlayTableViewCell *cell = array[i];
//        CGRect rectInTableView = [self.tableView rectForRowAtIndexPath:array1[i]];//获取cell在tableView中的位置
//        CGRect rectInSuperview = [self.tableView convertRect:rectInTableView toView:[self.tableView superview]];
//        cell.displayRect = rectInSuperview;
//        NSLog(@"移动位置 --- %@ --- %@",cell.identify,@(cell.displayRect));
//    }
    
//
//    NSLog(@"移动位置 ==== %@",@(rectInTableView));
//
//    NSLog(@"移动位置 ==== %@",@(rectInSuperview));
    
}

//- (void)dealloc{
//    NSLog(@"dealloc");
//}

- (void)viewWillDisappear:(BOOL)animated{
    [super viewWillDisappear:animated];
    for (AutoPlayTableViewCell *cell in self.observer) {
        [self.tableView removeObserver:cell forKeyPath:@"contentOffset"];
        [cell.player pause];
        
    }
}



@end

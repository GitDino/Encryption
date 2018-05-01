//
//  DORootVC.m
//  EncryptionDemo
//
//  Created by 魏欣宇 on 2018/5/1.
//  Copyright © 2018年 Dino. All rights reserved.
//

#import "DORootVC.h"
#import "DOEncryptionListTableView.h"

@interface DORootVC ()

@property (nonatomic, strong) DOEncryptionListTableView *list_tableView;

@end

@implementation DORootVC

#pragma mark - Life Cycle
- (void)viewDidLoad {
    [super viewDidLoad];
    
    self.title = @"iOS常用加密算法";
    self.view.backgroundColor = [UIColor whiteColor];
    
    [self configSubViews];
}

#pragma mark - Custom Cycle
- (void)configSubViews
{
    [self.view addSubview:self.list_tableView];
}

#pragma mark - Getter Cycle
- (DOEncryptionListTableView *)list_tableView
{
    if (!_list_tableView)
    {
        _list_tableView = [[DOEncryptionListTableView alloc] initWithFrame:CGRectMake(0, 0, SCREEN_WIDTH, SCREEN_HEIGHT)];
    }
    return _list_tableView;
}

@end

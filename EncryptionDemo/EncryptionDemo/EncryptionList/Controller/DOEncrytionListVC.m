//
//  DOEncrytionListVC.m
//  EncryptionDemo
//
//  Created by 魏欣宇 on 2018/5/1.
//  Copyright © 2018年 Dino. All rights reserved.
//

#import "DOEncrytionListVC.h"

#import "DOEncryptionListTableView.h"
#import "DOBaseCellModel.h"

#import "DOConsoleVC.h"

@interface DOEncrytionListVC ()

@property (nonatomic, strong) DOEncryptionListTableView *list_tableView;

@property (nonatomic, strong) NSMutableArray *data_array;

@end

@implementation DOEncrytionListVC

#pragma mark - Life Cycle
- (void)viewDidLoad {
    [super viewDidLoad];
    
    self.title = @"iOS常用加密算法";
    
    [self configSubViews];
    [self configAboutBlock];
}

#pragma mark - Custom Cycle
- (void)configSubViews
{
    [self.view addSubview:self.list_tableView];
    [self.list_tableView refreshData:self.data_array];
}

- (void)configAboutBlock
{
    __weak typeof(self) weakSelf = self;
    self.list_tableView.clickIndexCellBlock = ^(NSIndexPath *indexPath, NSMutableArray *data_array) {
        DOBaseCellModel *cell_model = data_array[indexPath.row];
        DOBaseVC *push_vc = [[[cell_model push_class] alloc] init];
        push_vc.type = EncryptionTypeBase64;
        [weakSelf.navigationController pushViewController:push_vc animated:YES];
    };
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

- (NSMutableArray *)data_array
{
    if (!_data_array)
    {
        DOBaseCellModel *cell_model1 = [DOBaseCellModel baseCellModelWithTitle:@"Base64加密" pushClass:[DOConsoleVC class]];
        DOBaseCellModel *cell_model2 = [DOBaseCellModel baseCellModelWithTitle:@"MD5加密" pushClass:nil];
        DOBaseCellModel *cell_model3 = [DOBaseCellModel baseCellModelWithTitle:@"AES加密" pushClass:nil];
        DOBaseCellModel *cell_model4 = [DOBaseCellModel baseCellModelWithTitle:@"RSA加密" pushClass:nil];
        
        NSArray *temp_array = @[cell_model1, cell_model2, cell_model3, cell_model4];
        
        _data_array = [NSMutableArray array];
        [_data_array addObjectsFromArray:temp_array];
    }
    return _data_array;
}

@end

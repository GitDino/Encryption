//
//  DORootVC.m
//  EncryptionDemo
//
//  Created by 魏欣宇 on 2018/5/1.
//  Copyright © 2018年 Dino. All rights reserved.
//

#import "DORootVC.h"
#import "DOEncryptionListTableView.h"
#import "DOEncryptionListCellModel.h"

#import "DOConsoleVC.h"

@interface DORootVC ()

@property (nonatomic, strong) DOEncryptionListTableView *list_tableView;

@property (nonatomic, strong) NSMutableArray *data_array;

@end

@implementation DORootVC

#pragma mark - Life Cycle
- (void)viewDidLoad {
    [super viewDidLoad];
    
    self.title = @"iOS常用加密算法";
    self.view.backgroundColor = [UIColor whiteColor];
    
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
        DOEncryptionListCellModel *cell_model = data_array[indexPath.row];
        UIViewController *push_vc = [[[cell_model push_class] alloc] init];
        push_vc.title = cell_model.cell_title;
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
        DOEncryptionListCellModel *cell_model1 = [DOEncryptionListCellModel listCellModelWithTitle:@"Base64加密" pushClass:[DOConsoleVC class]];
        DOEncryptionListCellModel *cell_model2 = [DOEncryptionListCellModel listCellModelWithTitle:@"MD5加密" pushClass:nil];
        DOEncryptionListCellModel *cell_model3 = [DOEncryptionListCellModel listCellModelWithTitle:@"AES加密" pushClass:nil];
        DOEncryptionListCellModel *cell_model4 = [DOEncryptionListCellModel listCellModelWithTitle:@"RSA加密" pushClass:nil];
        
        NSArray *temp_array = @[cell_model1, cell_model2, cell_model3, cell_model4];
        
        _data_array = [NSMutableArray array];
        [_data_array addObjectsFromArray:temp_array];
    }
    return _data_array;
}

@end

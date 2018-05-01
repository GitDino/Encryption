//
//  DOEncrytionListVC.m
//  EncryptionDemo
//
//  Created by 魏欣宇 on 2018/5/1.
//  Copyright © 2018年 Dino. All rights reserved.
//

#import "DOEncrytionListVC.h"

#import "DOEncryptionListTableView.h"

#import "DOConsoleVC.h"
#import "DOMD5VC.h"
#import "DOAESVC.h"
#import "DODESVC.h"

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
        switch (cell_model.model_type) {
            case ModelTypeBase64:
                push_vc.type = EncryptionTypeBase64;
                break;
            case ModelTypeRSA:
                push_vc.type = EncryptionTypeRSA;
                break;
                
            default:
                break;
        }
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
        cell_model1.model_type = ModelTypeBase64;
        
        DOBaseCellModel *cell_model2 = [DOBaseCellModel baseCellModelWithTitle:@"MD5加密" pushClass:[DOMD5VC class]];
        DOBaseCellModel *cell_model3 = [DOBaseCellModel baseCellModelWithTitle:@"AES加密" pushClass:[DOAESVC class]];
        DOBaseCellModel *cell_model4 = [DOBaseCellModel baseCellModelWithTitle:@"DES加密" pushClass:[DODESVC class]];
        DOBaseCellModel *cell_model5 = [DOBaseCellModel baseCellModelWithTitle:@"RSA加密" pushClass:[DOConsoleVC class]];
        cell_model5.model_type = ModelTypeRSA;
        
        NSArray *temp_array = @[cell_model1, cell_model2, cell_model3, cell_model4, cell_model5];
        
        _data_array = [NSMutableArray array];
        [_data_array addObjectsFromArray:temp_array];
    }
    return _data_array;
}

@end

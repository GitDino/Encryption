//
//  DODESVC.m
//  EncryptionDemo
//
//  Created by 魏欣宇 on 2018/5/1.
//  Copyright © 2018年 Dino. All rights reserved.
//

#import "DODESVC.h"
#import "DODESTableView.h"

#import "DOConsoleVC.h"

@interface DODESVC ()

@property (nonatomic, strong) DODESTableView *des_tableView;

@property (nonatomic, strong) NSMutableArray *data_array;

@end

@implementation DODESVC

#pragma mark - Life Cycle
- (void)viewDidLoad {
    [super viewDidLoad];
    
    self.title = @"DES加密";
    
    [self configSubViews];
    [self configAboutBlock];
}

#pragma mark - Custom Cycle
- (void)configSubViews
{
    [self.view addSubview:self.des_tableView];
    [self.des_tableView refreshData:self.data_array];
}

- (void)configAboutBlock
{
    __weak typeof(self) weakSelf = self;
    self.des_tableView.clickIndexCellBlock = ^(NSIndexPath *indexPath, NSMutableArray *data_array) {
        DOBaseCellModel *cell_model = data_array[indexPath.row];
        
        DOBaseVC *push_vc = [[[cell_model push_class] alloc] init];
        switch (cell_model.model_type) {
            case ModelTypeECB:
                push_vc.type = EncryptionTypeDESAndECB;
                break;
                
            default://ModelTypeCBC
                push_vc.type = EncryptionTypeDESAndCBC;
                break;
        }
        [weakSelf.navigationController pushViewController:push_vc animated:YES];
    };
}

#pragma mark - Getter Cycle
- (DODESTableView *)des_tableView
{
    if (!_des_tableView)
    {
        _des_tableView = [[DODESTableView alloc] initWithFrame:CGRectMake(0, 0, SCREEN_WIDTH, SCREEN_HEIGHT)];
    }
    return _des_tableView;
}

- (NSMutableArray *)data_array
{
    if (!_data_array)
    {
        DOBaseCellModel *cell_model1 = [DOBaseCellModel baseCellModelWithTitle:@"DES + ECB" pushClass:[DOConsoleVC class]];
        cell_model1.model_type = ModelTypeECB;
        
        DOBaseCellModel *cell_model2 = [DOBaseCellModel baseCellModelWithTitle:@"DES + CBC" pushClass:[DOConsoleVC class]];
        cell_model2.model_type = ModelTypeCBC;
        
        NSArray *temp_array = @[cell_model1, cell_model2];
        
        _data_array = [NSMutableArray array];
        [_data_array addObjectsFromArray:temp_array];
    }
    return _data_array;
}

@end

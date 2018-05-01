//
//  DOAESVC.m
//  EncryptionDemo
//
//  Created by 魏欣宇 on 2018/5/1.
//  Copyright © 2018年 Dino. All rights reserved.
//

#import "DOAESVC.h"
#import "DOAESTableView.h"

#import "DOConsoleVC.h"

@interface DOAESVC ()

@property (nonatomic, strong) DOAESTableView *aes_tableView;

@property (nonatomic, strong) NSMutableArray *data_array;

@end

@implementation DOAESVC

#pragma mark - Life Cycle
- (void)viewDidLoad {
    [super viewDidLoad];
    
    self.title = @"AES加密";
    
    [self configSubViews];
    [self configAboutBlock];
}

#pragma mark - Custom Cycle
- (void)configSubViews
{
    [self.view addSubview:self.aes_tableView];
    [self.aes_tableView refreshData:self.data_array];
}

- (void)configAboutBlock
{
    __weak typeof(self) weakSelf = self;
    self.aes_tableView.clickIndexCellBlock = ^(NSIndexPath *indexPath, NSMutableArray *data_array) {
        DOBaseCellModel *cell_model = data_array[indexPath.row];
        
        DOBaseVC *push_vc = [[[cell_model push_class] alloc] init];
        switch (cell_model.model_type) {
            case ModelTypeECB:
                push_vc.type = EncryptionTypeAESAndECB;
                break;
                
            default: //ModelTypeCBC
                push_vc.type = EncryptionTypeAESAndCBC;
                break;
        }
        [weakSelf.navigationController pushViewController:push_vc animated:YES];
    };
}

#pragma mark - Getter Cycle
- (DOAESTableView *)aes_tableView
{
    if (!_aes_tableView)
    {
        _aes_tableView = [[DOAESTableView alloc] initWithFrame:CGRectMake(0, 0, SCREEN_WIDTH, SCREEN_HEIGHT)];
    }
    return _aes_tableView;
}

- (NSMutableArray *)data_array
{
    if (!_data_array)
    {
        DOBaseCellModel *cell_model1 = [DOBaseCellModel baseCellModelWithTitle:@"AES + ECB" pushClass:[DOConsoleVC class]];
        cell_model1.model_type = ModelTypeECB;
        
        DOBaseCellModel *cell_model2 = [DOBaseCellModel baseCellModelWithTitle:@"AES + CBC" pushClass:[DOConsoleVC class]];
        cell_model2.model_type = ModelTypeCBC;
        
        NSArray *temp_array = @[cell_model1, cell_model2];
        
        _data_array = [NSMutableArray array];
        [_data_array addObjectsFromArray:temp_array];
    }
    return _data_array;
}

@end

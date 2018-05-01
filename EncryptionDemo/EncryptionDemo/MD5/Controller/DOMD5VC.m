//
//  DOMD5VC.m
//  EncryptionDemo
//
//  Created by 魏欣宇 on 2018/5/1.
//  Copyright © 2018年 Dino. All rights reserved.
//

#import "DOMD5VC.h"
#import "DOMD5TableView.h"

#import "DOConsoleVC.h"

@interface DOMD5VC ()

@property (nonatomic, strong) DOMD5TableView *md5_tableView;

@property (nonatomic, strong) NSMutableArray *data_array;

@end

@implementation DOMD5VC

#pragma mark - Life Cycle
- (void)viewDidLoad {
    [super viewDidLoad];
    
    self.title = @"MD5加密";
    
    [self configSubViews];
    [self configAboutBlock];
}

#pragma mark - Custom Cycle
- (void)configSubViews
{
    [self.view addSubview:self.md5_tableView];
    [self.md5_tableView refreshData:self.data_array];
}

- (void)configAboutBlock
{
    __weak typeof(self) weakSelf = self;
    self.md5_tableView.clickIndexCellBlock = ^(NSIndexPath *indexPath, NSMutableArray *data_array) {
        DOBaseCellModel *cell_model = data_array[indexPath.row];
        DOBaseVC *push_vc = [[[cell_model push_class] alloc] init];
        switch (cell_model.md5_type) {
            case MD5TypeSalt:
                push_vc.type = EncryptionTypeMD5AndSalt;
                break;
            case MD5TypeHMAC:
                push_vc.type = EncryptionTypeMD5AndHMAC;
                break;
                
            default://MD5TypeNormal
                push_vc.type = EncryptionTypeMD5;
                break;
        }
        [weakSelf.navigationController pushViewController:push_vc animated:YES];
    };
}

#pragma mark - Getter Cycle
- (DOMD5TableView *)md5_tableView
{
    if (!_md5_tableView)
    {
        _md5_tableView = [[DOMD5TableView alloc] initWithFrame:CGRectMake(0, 0, SCREEN_WIDTH, SCREEN_HEIGHT)];
    }
    return _md5_tableView;
}

- (NSMutableArray *)data_array
{
    if (!_data_array)
    {
        DOBaseCellModel *cell_model1 = [DOBaseCellModel baseCellModelWithTitle:@"MD5加密" pushClass:[DOConsoleVC class]];
        cell_model1.md5_type = MD5TypeNormal;
        
        DOBaseCellModel *cell_model2 = [DOBaseCellModel baseCellModelWithTitle:@"MD5 + 盐" pushClass:[DOConsoleVC class]];
        cell_model2.md5_type = MD5TypeSalt;
        
        DOBaseCellModel *cell_model3 = [DOBaseCellModel baseCellModelWithTitle:@"HMAC + MD5" pushClass:[DOConsoleVC class]];
        cell_model3.md5_type = MD5TypeHMAC;
        
        NSArray *temp_array = @[cell_model1, cell_model2, cell_model3];
        
        _data_array = [NSMutableArray array];
        [_data_array addObjectsFromArray:temp_array];
    }
    return _data_array;
}

@end

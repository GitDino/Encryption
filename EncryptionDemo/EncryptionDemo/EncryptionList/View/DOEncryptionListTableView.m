//
//  DOEncryptionListTableView.m
//  EncryptionDemo
//
//  Created by 魏欣宇 on 2018/5/1.
//  Copyright © 2018年 Dino. All rights reserved.
//

#import "DOEncryptionListTableView.h"
#import "DOEncryptionListCell.h"

@implementation DOEncryptionListTableView

#pragma mark - UITableViewDataSource数据源方法
- (UITableViewCell *)tableView:(UITableView *)tableView cellForRowAtIndexPath:(NSIndexPath *)indexPath
{
    DOEncryptionListCell *cell = [DOEncryptionListCell encryptionListCellWithTableView:tableView];
    cell.cell_model = [self obtainDataWithIndex:indexPath];
    return cell;
}

@end

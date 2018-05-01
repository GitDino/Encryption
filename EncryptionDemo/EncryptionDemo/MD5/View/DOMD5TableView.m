//
//  DOMD5TableView.m
//  EncryptionDemo
//
//  Created by 魏欣宇 on 2018/5/1.
//  Copyright © 2018年 Dino. All rights reserved.
//

#import "DOMD5TableView.h"
#import "DOMD5Cell.h"

@implementation DOMD5TableView

#pragma mark - UITableViewDataSource数据源方法
- (UITableViewCell *)tableView:(UITableView *)tableView cellForRowAtIndexPath:(NSIndexPath *)indexPath
{
    DOMD5Cell *cell = [DOMD5Cell md5CellWithTableView:tableView];
    cell.cell_model = [self obtainDataWithIndex:indexPath];
    return cell;
}

@end

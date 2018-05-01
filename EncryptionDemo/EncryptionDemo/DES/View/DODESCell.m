//
//  DODESCell.m
//  EncryptionDemo
//
//  Created by 魏欣宇 on 2018/5/1.
//  Copyright © 2018年 Dino. All rights reserved.
//

#import "DODESCell.h"
#import "DOBaseCellModel.h"

@implementation DODESCell

#pragma mark - Life Cycle
+ (instancetype)desCellWithTableView:(UITableView *) tableView
{
    static NSString *ID = @"DODESCell";
    DODESCell *cell = [tableView dequeueReusableCellWithIdentifier:ID];
    if (cell == nil)
    {
        cell = [[DODESCell alloc] initWithStyle:UITableViewCellStyleDefault reuseIdentifier:ID];
    }
    return cell;
}

- (instancetype)initWithStyle:(UITableViewCellStyle)style reuseIdentifier:(NSString *)reuseIdentifier
{
    if (self = [super initWithStyle:style reuseIdentifier:reuseIdentifier]){}
    return self;
}

#pragma mark - Setter Cycle
- (void)setCell_model:(DOBaseCellModel *)cell_model
{
    _cell_model = cell_model;
    
    self.textLabel.text = _cell_model.cell_title;
}

@end

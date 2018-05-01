//
//  DOMD5Cell.h
//  EncryptionDemo
//
//  Created by 魏欣宇 on 2018/5/1.
//  Copyright © 2018年 Dino. All rights reserved.
//

#import <UIKit/UIKit.h>
@class DOBaseCellModel;

@interface DOMD5Cell : UITableViewCell

@property (nonatomic, strong) DOBaseCellModel *cell_model;

+ (instancetype)md5CellWithTableView:(UITableView *) tableView;

@end

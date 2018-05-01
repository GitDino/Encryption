//
//  DODESCell.h
//  EncryptionDemo
//
//  Created by 魏欣宇 on 2018/5/1.
//  Copyright © 2018年 Dino. All rights reserved.
//

#import <UIKit/UIKit.h>
@class DOBaseCellModel;

@interface DODESCell : UITableViewCell

@property (nonatomic, strong) DOBaseCellModel *cell_model;

+ (instancetype)desCellWithTableView:(UITableView *) tableView;

@end

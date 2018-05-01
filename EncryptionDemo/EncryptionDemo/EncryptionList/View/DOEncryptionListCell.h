//
//  DOEncryptionListCell.h
//  EncryptionDemo
//
//  Created by 魏欣宇 on 2018/5/1.
//  Copyright © 2018年 Dino. All rights reserved.
//

#import <UIKit/UIKit.h>
@class DOEncryptionListCellModel;

@interface DOEncryptionListCell : UITableViewCell

@property (nonatomic, strong) DOEncryptionListCellModel *cell_model;

+ (instancetype)encryptionListCellWithTableView:(UITableView *) tableView;

@end

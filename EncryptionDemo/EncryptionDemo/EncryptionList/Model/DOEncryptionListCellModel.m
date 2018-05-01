//
//  DOEncryptionListCellModel.m
//  EncryptionDemo
//
//  Created by 魏欣宇 on 2018/5/1.
//  Copyright © 2018年 Dino. All rights reserved.
//

#import "DOEncryptionListCellModel.h"

@implementation DOEncryptionListCellModel

+ (instancetype)listCellModelWithTitle:(NSString *) cell_title pushClass:(Class) push_class
{
    DOEncryptionListCellModel *cell_model = [[DOEncryptionListCellModel alloc] init];
    cell_model.cell_title = cell_title;
    cell_model.push_class = push_class;
    return cell_model;
}

@end

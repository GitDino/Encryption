//
//  DOBaseCellModel.h
//  EncryptionDemo
//
//  Created by 魏欣宇 on 2018/5/1.
//  Copyright © 2018年 Dino. All rights reserved.
//

#import <Foundation/Foundation.h>

@interface DOBaseCellModel : NSObject

@property (nonatomic, copy) NSString *cell_title;

@property (nonatomic, assign) Class push_class;

+ (instancetype)baseCellModelWithTitle:(NSString *) cell_title pushClass:(Class) push_class;

@end

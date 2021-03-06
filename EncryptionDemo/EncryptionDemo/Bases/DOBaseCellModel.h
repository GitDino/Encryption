//
//  DOBaseCellModel.h
//  EncryptionDemo
//
//  Created by 魏欣宇 on 2018/5/1.
//  Copyright © 2018年 Dino. All rights reserved.
//

#import <Foundation/Foundation.h>

typedef NS_ENUM(NSUInteger, MD5Type) {
    MD5TypeNormal = 1,
    MD5TypeSalt,
    MD5TypeHMAC
};

typedef NS_ENUM(NSUInteger, ModelType) {
    ModelTypeECB = 0,
    ModelTypeCBC,
    ModelTypeBase64,
    ModelTypeRSA
};

@interface DOBaseCellModel : NSObject

@property (nonatomic, copy) NSString *cell_title;

@property (nonatomic, assign) Class push_class;

@property (nonatomic, assign) MD5Type md5_type;

@property (nonatomic, assign) ModelType model_type;

+ (instancetype)baseCellModelWithTitle:(NSString *) cell_title pushClass:(Class) push_class;

@end

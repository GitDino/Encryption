//
//  DOBaseVC.h
//  EncryptionDemo
//
//  Created by 魏欣宇 on 2018/5/1.
//  Copyright © 2018年 Dino. All rights reserved.
//

#import <UIKit/UIKit.h>
#import "DOBaseCellModel.h"

typedef NS_ENUM(NSUInteger, EncryptionType) {
    EncryptionTypeBase64 = 0,
    EncryptionTypeMD5,
    EncryptionTypeMD5AndSalt,
    EncryptionTypeMD5AndHAC,
};

@interface DOBaseVC : UIViewController

@property (nonatomic, assign) EncryptionType type;

@end

//
//  DOConsoleVC.h
//  EncryptionDemo
//
//  Created by 魏欣宇 on 2018/5/1.
//  Copyright © 2018年 Dino. All rights reserved.
//

#import <UIKit/UIKit.h>

typedef NS_ENUM(NSUInteger, EncryptionType) {
    EncryptionTypeBase64 = 0,
};

@interface DOConsoleVC : UIViewController

@property (nonatomic, assign) EncryptionType type;

@end

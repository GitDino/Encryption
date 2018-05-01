//
//  DOConsoleVC.m
//  EncryptionDemo
//
//  Created by 魏欣宇 on 2018/5/1.
//  Copyright © 2018年 Dino. All rights reserved.
//

#import "DOConsoleVC.h"

@interface DOConsoleVC ()

@property (nonatomic, strong) UITextField *scanf_textfield;

@property (nonatomic, strong) UIButton *encrypted_btn;

@property (nonatomic, strong) UITextView *result_textView;

@end

@implementation DOConsoleVC

#pragma mark - Life Cycle
- (void)dealloc
{
    NSLog(@"%s", __FUNCTION__);
}

- (void)viewDidLoad {
    [super viewDidLoad];
    
    self.view.backgroundColor = [UIColor lightGrayColor];
    
    [self configSubViews];
}

#pragma mark - Custom Cycle
- (void)configSubViews
{
    [self.view addSubview:self.scanf_textfield];
    
    [self.view addSubview:self.encrypted_btn];
    [self.encrypted_btn addTarget:self action:@selector(clickEncryptionAction:) forControlEvents:UIControlEventTouchUpInside];
    
    [self.view addSubview:self.result_textView];
}

#pragma mark - Event Cycle
- (void)clickEncryptionAction:(UIButton *) btn
{
    
    switch (self.type) {
        case EncryptionTypeBase64:
            self.result_textView.text = [self base64EncodedStringWithData:[self.scanf_textfield.text dataUsingEncoding:NSUTF8StringEncoding]];
            break;
            
        default:
            break;
    }
}

#pragma mark - Base64加密、解密
- (NSString *)base64EncodedStringWithData:(NSData *) data
{
    //判断是否传入需要加密数据参数
    if ((data == nil) || (data == NULL))
    {
        return nil;
    }
    else if (![data isKindOfClass:[NSData class]])
    {
        return nil;
    }
    
    return [data base64EncodedStringWithOptions: NSDataBase64EncodingEndLineWithLineFeed];
}

- (NSString *)base64DecodedDataWithString:(NSString *) str
{
    //判断是否传入需要加密数据参数
    if ((str == nil) || (str == NULL))
    {
        return nil;
    }
    else if (![str isKindOfClass:[NSString class]])
    {
        return nil;
    }
    
    NSData *data = [[NSData alloc] initWithBase64EncodedString:str options: NSDataBase64DecodingIgnoreUnknownCharacters];
    
    return [[NSString alloc] initWithData:data encoding:NSUTF8StringEncoding];
}

#pragma mark - Getter Cycle
- (UITextField *)scanf_textfield
{
    if (!_scanf_textfield)
    {
        _scanf_textfield = [[UITextField alloc] initWithFrame:CGRectMake(40, 100, SCREEN_WIDTH - 80, 35)];
        _scanf_textfield.borderStyle = UITextBorderStyleRoundedRect;
        _scanf_textfield.placeholder = @"请输入需要加密的字符串：";
    }
    return _scanf_textfield;
}

- (UIButton *)encrypted_btn
{
    if (!_encrypted_btn)
    {
        _encrypted_btn = [[UIButton alloc] initWithFrame:CGRectMake((SCREEN_WIDTH - 100) * 0.5, 150, 100, 44)];
        _encrypted_btn.layer.masksToBounds = YES;
        _encrypted_btn.layer.cornerRadius = 3.0;
        _encrypted_btn.layer.borderColor = Main_Color.CGColor;
        _encrypted_btn.layer.borderWidth = 1.0;
        [_encrypted_btn setTitleColor:Main_Color forState:UIControlStateNormal];
        [_encrypted_btn setTitle:@"开始加密" forState:UIControlStateNormal];
    }
    return _encrypted_btn;
}

- (UITextView *)result_textView
{
    if (!_result_textView)
    {
        _result_textView = [[UITextView alloc] initWithFrame:CGRectMake(20, 210, SCREEN_WIDTH - 40, 100)];
        _result_textView.editable = NO;
        _result_textView.selectable = NO;
    }
    return _result_textView;
}

@end

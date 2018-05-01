//
//  DOConsoleVC.m
//  EncryptionDemo
//
//  Created by 魏欣宇 on 2018/5/1.
//  Copyright © 2018年 Dino. All rights reserved.
//

#define Salt @"!@#Salt"
#define HMAC_KEY @"Dino"
#define Private_Key @"Dino"

#import "DOConsoleVC.h"

#import "NSString+Hash.h"
#import "EncryptionTools.h"
#import "RSACryptor.h"

@interface DOConsoleVC ()

@property (nonatomic, strong) UITextField *scanf_textfield;

@property (nonatomic, strong) UIButton *encode_btn;

@property (nonatomic, strong) UITextView *encodeResult_textView;

@property (nonatomic, strong) UIButton *decode_btn;

@property (nonatomic, strong) UITextView *decodeResult_textView;

/**
 存储加密后的字符串
 */
@property (nonatomic, copy) NSString *encode_result;

@end

@implementation DOConsoleVC

#pragma mark - Life Cycle
- (void)viewDidLoad {
    [super viewDidLoad];
    
    self.view.backgroundColor = [UIColor lightGrayColor];
    switch (self.type) {
        case EncryptionTypeBase64:
            self.title = @"Base64";
            break;
        case EncryptionTypeMD5:
            self.title = @"MD5";
            self.decode_btn.hidden = YES;
            self.decodeResult_textView.hidden = YES;
            break;
        case EncryptionTypeMD5AndSalt:
            self.title = @"MD5 + Salt";
            self.decode_btn.hidden = YES;
            self.decodeResult_textView.hidden = YES;
            break;
        case EncryptionTypeMD5AndHMAC:
            self.title = @"MD5 + HMAC";
            self.decode_btn.hidden = YES;
            self.decodeResult_textView.hidden = YES;
            break;
        case EncryptionTypeAESAndECB:
            self.title = @"AES + ECB";
            break;
        case EncryptionTypeAESAndCBC:
            self.title = @"AES + CBC";
            break;
        case EncryptionTypeDESAndECB:
            self.title = @"DES + ECB";
            break;
        case EncryptionTypeDESAndCBC:
            self.title = @"DES + CBC";
            break;
        case EncryptionTypeRSA:
            self.title = @"RSA";
            //加载公钥
            [[RSACryptor sharedRSACryptor] loadPublicKey:[[NSBundle mainBundle] pathForResource:@"rsa_cert.der" ofType:nil]];
            //加载私钥
            [[RSACryptor sharedRSACryptor] loadPrivateKey:[[NSBundle mainBundle] pathForResource:@"rsa.p12" ofType:nil] password:@"123456"];
            break;
            
        default:
            break;
    }
    
    [self configSubViews];
}

#pragma mark - Custom Cycle
- (void)configSubViews
{
    [self.view addSubview:self.scanf_textfield];
    
    [self.view addSubview:self.encode_btn];
    [self.encode_btn addTarget:self action:@selector(clickEncodeAction:) forControlEvents:UIControlEventTouchUpInside];
    
    [self.view addSubview:self.encodeResult_textView];
    
    [self.view addSubview:self.decode_btn];
    [self.decode_btn addTarget:self action:@selector(clickDecodeAction:) forControlEvents:UIControlEventTouchUpInside];
    
    [self.view addSubview:self.decodeResult_textView];
}

#pragma mark - Event Cycle
/**
 加密事件
 */
- (void)clickEncodeAction:(UIButton *) btn
{
    if (self.scanf_textfield.text.length > 0)
    {
        switch (self.type) {
            case EncryptionTypeBase64:
                self.encode_result = [self base64EncodedStringWithData:[self.scanf_textfield.text dataUsingEncoding:NSUTF8StringEncoding]];
                self.encodeResult_textView.text = [NSString stringWithFormat:@"-------%@加密结果-------\n %@", self.title, self.encode_result];
                break;
            case EncryptionTypeMD5:
                self.encodeResult_textView.text = [NSString stringWithFormat:@"-------%@加密结果-------\n%@", self.title, [self md5WithString:self.scanf_textfield.text]];
                break;
            case EncryptionTypeMD5AndSalt:
                self.encodeResult_textView.text = [NSString stringWithFormat:@"-------%@加密结果-------\n%@", self.title, [self md5SaltWithString:self.scanf_textfield.text]];
                break;
            case EncryptionTypeMD5AndHMAC:
                self.encodeResult_textView.text = [NSString stringWithFormat:@"-------%@加密结果-------\n%@", self.title, [self md5HMACWithString:self.scanf_textfield.text]];
                break;
            case EncryptionTypeAESAndECB:
                self.encode_result = [self encodeAESAndECBWithString:self.scanf_textfield.text];
                self.encodeResult_textView.text = [NSString stringWithFormat:@"-------%@加密结果-------\n%@", self.title, self.encode_result];
                break;
            case EncryptionTypeAESAndCBC:
                self.encode_result = [self encodeAESAndCBCWithString:self.scanf_textfield.text];
                self.encodeResult_textView.text = [NSString stringWithFormat:@"-------%@加密结果-------\n%@", self.title, self.encode_result];
                break;
            case EncryptionTypeDESAndECB:
                self.encode_result = [self encodeDESAndECBWithString:self.scanf_textfield.text];
                self.encodeResult_textView.text = [NSString stringWithFormat:@"-------%@加密结果--------\n%@", self.title, self.encode_result];
                break;
            case EncryptionTypeDESAndCBC:
                self.encode_result = [self encodeDESAndCBCWithString:self.scanf_textfield.text];
                self.encodeResult_textView.text = [NSString stringWithFormat:@"-------%@加密结果--------\n%@", self.title, self.encode_result];
                break;
            case EncryptionTypeRSA:
                self.encode_result = [self encodeRSAWithString:self.scanf_textfield.text];
                self.encodeResult_textView.text = [NSString stringWithFormat:@"-------%@加密结果--------\n%@", self.title, self.encode_result];
                break;
                
            default:
                break;
        }
    }
    else
    {
        UIAlertController *alert_controller = [UIAlertController alertControllerWithTitle:@"注意" message:@"请输入需要加密的字符串！" preferredStyle:UIAlertControllerStyleAlert];
        UIAlertAction *alert_action = [UIAlertAction actionWithTitle:@"确定" style:UIAlertActionStyleDefault handler:nil];
        [alert_controller addAction:alert_action];
        [self presentViewController:alert_controller animated:YES completion:nil];
    }
}

/**
 解密事件
 */
- (void)clickDecodeAction:(UIButton *) btn
{
    if (self.encode_result.length > 0)
    {
        switch (self.type) {
            case EncryptionTypeBase64:
                self.decodeResult_textView.text = [NSString stringWithFormat:@"-------%@解密结果-------\n%@", self.title, [self base64DecodedDataWithString:self.encode_result]];
                break;
            case EncryptionTypeAESAndECB:
                self.decodeResult_textView.text = [NSString stringWithFormat:@"-------%@解密结果-------\n%@", self.title, [self decodeAESAndECBWithString:self.encode_result]];
                break;
            case EncryptionTypeAESAndCBC:
                self.decodeResult_textView.text = [NSString stringWithFormat:@"-------%@解密结果-------\n%@", self.title, [self decodeAESAndCBCWithString:self.encode_result]];
                break;
            case EncryptionTypeDESAndECB:
                self.decodeResult_textView.text = [NSString stringWithFormat:@"-------%@解密结果-------\n%@", self.title, [self decodeDESAndECBWithString:self.encode_result]];
                break;
            case EncryptionTypeDESAndCBC:
                self.decodeResult_textView.text = [NSString stringWithFormat:@"-------%@解密结果-------\n%@", self.title, [self decodeDESAndCBCWithString:self.encode_result]];
                break;
            case EncryptionTypeRSA:
                self.decodeResult_textView.text = [NSString stringWithFormat:@"-------%@解密结果-------\n%@", self.title, [self decodeRSAWithString:self.encode_result]];
                break;
                
            default:
                break;
        }
    }
    else
    {
        UIAlertController *alert_controller = [UIAlertController alertControllerWithTitle:@"注意" message:@"没有任何需要解密的字符串" preferredStyle:UIAlertControllerStyleAlert];
        UIAlertAction *alert_action = [UIAlertAction actionWithTitle:@"确定" style:UIAlertActionStyleDefault handler:nil];
        [alert_controller addAction:alert_action];
        [self presentViewController:alert_controller animated:YES completion:nil];
    }
}

#pragma mark - --------Base64加密、解密--------
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

#pragma mark - --------MD5加密--------
- (NSString *)md5WithString:(NSString *) str
{
    return str.md5String;
}

- (NSString *)md5SaltWithString:(NSString *) str
{
    return [str stringByAppendingString:Salt].md5String;
}

- (NSString *)md5HMACWithString:(NSString *) str
{
    return [str hmacMD5StringWithKey:HMAC_KEY];
}

#pragma mark - --------AES加密(解密)--------
- (NSString *)encodeAESAndECBWithString:(NSString *) str
{
    return [[EncryptionTools sharedEncryptionTools] encryptString:str keyString:Private_Key iv:nil];
}

- (NSString *)decodeAESAndECBWithString:(NSString *) str
{
    return [[EncryptionTools sharedEncryptionTools] decryptString:str keyString:Private_Key iv:nil];
}

- (NSString *)encodeAESAndCBCWithString:(NSString *) str
{
    //向量
    uint8_t iv[8] = {2,3,4,5,6,7,8,9};
    NSData * ivData = [NSData dataWithBytes:iv length:sizeof(iv)];
    
    return [[EncryptionTools sharedEncryptionTools] encryptString:str keyString:Private_Key iv:ivData];
}

- (NSString *)decodeAESAndCBCWithString:(NSString *) str
{
    //向量
    uint8_t iv[8] = {2,3,4,5,6,7,8,9};
    NSData * ivData = [NSData dataWithBytes:iv length:sizeof(iv)];
    
    return [[EncryptionTools sharedEncryptionTools] decryptString:str keyString:Private_Key iv:ivData];
}

#pragma mark - --------DES加密(解密)--------
- (NSString *)encodeDESAndECBWithString:(NSString *) str
{
    [EncryptionTools sharedEncryptionTools].algorithm = kCCAlgorithmDES;
    return [[EncryptionTools sharedEncryptionTools] encryptString:str keyString:Private_Key iv:nil];
}

- (NSString *)decodeDESAndECBWithString:(NSString *) str
{
    [EncryptionTools sharedEncryptionTools].algorithm = kCCAlgorithmDES;
    return [[EncryptionTools sharedEncryptionTools] decryptString:str keyString:Private_Key iv:nil];
}

- (NSString *)encodeDESAndCBCWithString:(NSString *) str
{
    //向量
    uint8_t iv[8] = {2,3,4,5,6,7,8,9};
    NSData * ivData = [NSData dataWithBytes:iv length:sizeof(iv)];
    
    [EncryptionTools sharedEncryptionTools].algorithm = kCCAlgorithmDES;
    return [[EncryptionTools sharedEncryptionTools] encryptString:str keyString:Private_Key iv:ivData];
}

- (NSString *)decodeDESAndCBCWithString:(NSString *) str
{
    //向量
    uint8_t iv[8] = {2,3,4,5,6,7,8,9};
    NSData * ivData = [NSData dataWithBytes:iv length:sizeof(iv)];
    
    [EncryptionTools sharedEncryptionTools].algorithm = kCCAlgorithmDES;
    return [[EncryptionTools sharedEncryptionTools] decryptString:str keyString:Private_Key iv:ivData];
}


#pragma mark - --------RSA加密(解密)--------
- (NSString *)encodeRSAWithString:(NSString *) str
{
    NSData *result_data = [[RSACryptor sharedRSACryptor] encryptData:[str dataUsingEncoding:NSUTF8StringEncoding]];
    
    return [result_data base64EncodedStringWithOptions:0];
}

- (NSString *)decodeRSAWithString:(NSString *) str
{
    
    NSData *result_data = [[RSACryptor sharedRSACryptor] decryptData:[[NSData alloc] initWithBase64EncodedString:str options: NSDataBase64DecodingIgnoreUnknownCharacters]];
    
    return [[NSString alloc] initWithData:result_data encoding:NSUTF8StringEncoding];
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

- (UIButton *)encode_btn
{
    if (!_encode_btn)
    {
        _encode_btn = [[UIButton alloc] initWithFrame:CGRectMake((SCREEN_WIDTH - 100) * 0.5, 150, 100, 44)];
        _encode_btn.layer.masksToBounds = YES;
        _encode_btn.layer.cornerRadius = 3.0;
        _encode_btn.layer.borderColor = Main_Color.CGColor;
        _encode_btn.layer.borderWidth = 1.0;
        [_encode_btn setTitleColor:Main_Color forState:UIControlStateNormal];
        [_encode_btn setTitle:@"开始加密" forState:UIControlStateNormal];
    }
    return _encode_btn;
}

- (UITextView *)encodeResult_textView
{
    if (!_encodeResult_textView)
    {
        _encodeResult_textView = [[UITextView alloc] initWithFrame:CGRectMake(20, 210, SCREEN_WIDTH - 40, 100)];
        _encodeResult_textView.editable = NO;
        _encodeResult_textView.selectable = NO;
    }
    return _encodeResult_textView;
}

- (UIButton *)decode_btn
{
    if (!_decode_btn)
    {
        _decode_btn = [[UIButton alloc] initWithFrame:CGRectMake((SCREEN_WIDTH - 100) * 0.5, 325, 100, 44)];
        _decode_btn.layer.masksToBounds = YES;
        _decode_btn.layer.cornerRadius = 3.0;
        _decode_btn.layer.borderColor = Main_Color.CGColor;
        _decode_btn.layer.borderWidth = 1.0;
        [_decode_btn setTitleColor:Main_Color forState:UIControlStateNormal];
        [_decode_btn setTitle:@"开始解密" forState:UIControlStateNormal];
    }
    return _decode_btn;
}

- (UITextView *)decodeResult_textView
{
    if (!_decodeResult_textView)
    {
        _decodeResult_textView = [[UITextView alloc] initWithFrame:CGRectMake(20, 384, SCREEN_WIDTH - 40, 100)];
        _decodeResult_textView.editable = NO;
        _decodeResult_textView.selectable = NO;
    }
    return _decodeResult_textView;
}

@end

//
//  KKAESCrypt+NSData.m
//  Kook
//
//  Created by lyz on 25/12/2017.
//  Copyright © 2017 Kook. All rights reserved.
//

#import "KKAESCrypt+NSData.h"
#import "NSData+KKBase64.h"
#import "NSString+KKBase64.h"
#import "NSData+KKCommonCrypto.h"
#import <CommonCrypto/CommonCryptor.h>

@implementation KKAESCrypt (NSData)

+ (NSString *)encryptBinary:(NSData *)message password:(NSString *)password initIv:(NSString*)iv{
    if(message == nil || password == nil ||iv == nil)
        return nil;
    CCCryptorStatus status = kCCSuccess;
    CCOptions opt = kCCOptionPKCS7Padding;
    NSData *encryptedData = [message dataEncryptedUsingAlgorithm:kCCAlgorithmAES128 key:[password dataUsingEncoding:NSUTF8StringEncoding] initializationVector:iv options:opt error:&status];
    if(encryptedData != nil)
    {
        NSString *base64EncodedString = [NSString base64StringFromData:encryptedData length:[encryptedData length]];
        return base64EncodedString;
    }
    else{
        return nil;
    }
}

+ (NSData *)decrypt2Binary:(NSString *)base64EncodedString password:(NSString *)password initIv:(NSString*)iv{
    if(base64EncodedString == nil )
        return nil;
    CCCryptorStatus status = kCCSuccess;
    CCOptions opt = kCCOptionPKCS7Padding;
    NSData *decodeStr = [NSData base64DataFromString:base64EncodedString];
//    NSString *base64Str = [NSString base64StringFromData:decodeStr length:decodeStr.length];
    
    NSData *encryptedData = decodeStr;
    if(encryptedData != nil)
    {
        NSData *decryptedData = [encryptedData decryptedDataUsingAlgorithm:kCCAlgorithmAES128 key:[password dataUsingEncoding:NSUTF8StringEncoding]  initializationVector:iv options:opt error:&status];
        return decryptedData;
    }
    else{
        return nil;
    }
}
@end

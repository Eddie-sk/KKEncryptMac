//
//  KKAESCrypt+NSData.h
//  Kook
//
//  Created by lyz on 25/12/2017.
//  Copyright © 2017 Kook. All rights reserved.
//

#import "KKAESCrypt.h"

@interface KKAESCrypt (NSData)
+ (NSString *)encryptBinary:(NSData *)message password:(NSString *)password initIv:(NSString*)iv;
+ (NSData *)decrypt2Binary:(NSString *)base64EncodedString password:(NSString *)password initIv:(NSString*)iv;
@end

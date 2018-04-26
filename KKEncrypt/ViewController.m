//
//  ViewController.m
//  KKEncrypt
//
//  Created by sunkai on 2018/4/17.
//  Copyright © 2018年 CCWork. All rights reserved.
//

#import "ViewController.h"
#import "KKAESCrypt.h"
#import "NSData+KKCommonCrypto.h"

#import "KKAESCrypt+NSData.h"
#import "NSString+KKBase64.h"

static NSString *const kEncryptPasswordKey = @"kEncryptPasswordKey";

@interface ViewController ()
@property (weak) IBOutlet NSTextField *keyTF;
@property (unsafe_unretained) IBOutlet NSTextView *origainTV;
@property (unsafe_unretained) IBOutlet NSTextView *paTV;

@property (nonatomic, copy) NSString *sKey;
@property (nonatomic, copy) NSString *iv;

@end

@implementation ViewController

- (void)viewDidLoad {
    [super viewDidLoad];

    NSString *skey = [[NSUserDefaults standardUserDefaults] objectForKey:kEncryptPasswordKey];
    if (skey && skey.length > 0) {
        _sKey = [skey copy];
        _keyTF.stringValue = _sKey;
    }
    
}

- (IBAction)encrypt:(id)sender {
    if (_keyTF.stringValue && _origainTV.string) {
        
        NSString *skey = _keyTF.stringValue;
        _iv = [skey md5String];
        NSData *origainData = [_origainTV.string dataUsingEncoding:NSUTF8StringEncoding];
        NSString *enctypeStr = [KKAESCrypt encryptBinary:origainData password:skey initIv:_iv];
        if (enctypeStr && enctypeStr.length > 0) {
            _paTV.string = enctypeStr;
        }
        if (![skey isEqualToString:_sKey]) {
            _sKey = [skey copy];
            [[NSUserDefaults standardUserDefaults] setObject:_sKey forKey:kEncryptPasswordKey];
        }
    }
}
- (IBAction)dencrypt:(id)sender {
    if (_keyTF.stringValue && _origainTV.string) {
        
        NSString *skey = _keyTF.stringValue;
        _iv = [skey md5String];
        NSData *decodeData = [KKAESCrypt decrypt2Binary:_origainTV.string password:skey initIv:_iv];
        
        NSString *decodeStr = [[NSString alloc] initWithData:decodeData encoding:NSUTF8StringEncoding];
        if (decodeStr && decodeStr.length > 0) {
            _paTV.string = decodeStr;
        }
        _paTV.string = decodeStr;
        if (![skey isEqualToString:_sKey]) {
            _sKey = [skey copy];
            [[NSUserDefaults standardUserDefaults] setObject:_sKey forKey:kEncryptPasswordKey];
        }
    }
}

- (void)setRepresentedObject:(id)representedObject {
    [super setRepresentedObject:representedObject];

    // Update the view, if already loaded.
}


@end

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

    
}

- (IBAction)encrypt:(id)sender {
    if (_keyTF.stringValue && _origainTV.string) {
        
        _sKey = @"abcdefghijklmnop";
        _iv = [_sKey md5String];
        NSData *decodeData = [KKAESCrypt decrypt2Binary:_origainTV.string password:_sKey initIv:_iv];
        
        NSString *decodeStr = [[NSString alloc] initWithData:decodeData encoding:NSUTF8StringEncoding];
        _paTV.string = decodeStr;
    }
}

- (void)setRepresentedObject:(id)representedObject {
    [super setRepresentedObject:representedObject];

    // Update the view, if already loaded.
}


@end

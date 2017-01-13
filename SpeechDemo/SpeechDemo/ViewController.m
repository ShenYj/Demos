//
//  ViewController.m
//  SpeechDemo
//
//  Created by ShenYj on 2017/1/13.
//  Copyright © 2017年 ShenYj. All rights reserved.
//

#import "ViewController.h"
#import <Speech/Speech.h>

@interface ViewController ()

@end

@implementation ViewController

- (void)viewDidLoad {
    [super viewDidLoad];
    
    // 0. 请求权限 && 配置Info.plist
    
    /** 若不配置info.plist会Crash报错:
     This app has crashed because it attempted to access privacy-sensitive data without a usage description.  
     The app's Info.plist must contain an NSSpeechRecognitionUsageDescription key with a string value explaining to the user how the app uses this data.
     */
    [SFSpeechRecognizer requestAuthorization:^(SFSpeechRecognizerAuthorizationStatus status) {
        switch (status) {
            case SFSpeechRecognizerAuthorizationStatusNotDetermined:
                NSLog(@"SFSpeechRecognizerAuthorizationStatusNotDetermined");
                break;
            case SFSpeechRecognizerAuthorizationStatusDenied:
                NSLog(@"SFSpeechRecognizerAuthorizationStatusDenied");
                break;
            case SFSpeechRecognizerAuthorizationStatusRestricted:
                NSLog(@"SFSpeechRecognizerAuthorizationStatusRestricted");
                break;
            case SFSpeechRecognizerAuthorizationStatusAuthorized:
                NSLog(@"SFSpeechRecognizerAuthorizationStatusAuthorized");
                break;
            default:
                break;
        }
    }];
}

- (void)touchesBegan:(NSSet<UITouch *> *)touches withEvent:(UIEvent *)event {
    
    // 1. 初始化一个识别器
    SFSpeechRecognizer *recognizer = [[SFSpeechRecognizer alloc] initWithLocale:[[NSLocale alloc] initWithLocaleIdentifier:@"zh_CN"]];
    
    // 2. 初始化mp3的url
    NSURL *fileUrl = [[NSBundle mainBundle] URLForResource:@"buyao.mp3" withExtension:nil];
    
    // 3. 根据Url创建请求
    SFSpeechURLRecognitionRequest *request = [[SFSpeechURLRecognitionRequest alloc] initWithURL:fileUrl];
    
    // 4. 发起请求
    [recognizer recognitionTaskWithRequest:request resultHandler:^(SFSpeechRecognitionResult * _Nullable result, NSError * _Nullable error) {
        if (error != nil) {
            NSLog(@"识别错误:%@",error);
            return ;
        }
        NSLog(@"%@",result.bestTranscription.formattedString);
    }];
}

@end

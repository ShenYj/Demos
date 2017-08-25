//
//  ViewController.m
//  DownLoad
//
//  Created by ecg on 2017/8/25.
//  Copyright © 2017年 Auko. All rights reserved.
//

#import "ViewController.h"
#import "AFNetworking.h"
#import "SRDownloadManager.h"


@interface ViewController ()

@end

@implementation ViewController


- (void)touchesBegan:(NSSet<UITouch *> *)touches withEvent:(UIEvent *)event
{
    // 1. 原生 (NSURLSession)
    //[self urlSession];
    // 2. AFN
    //[self AFN];
    // 3. SRDownloadManager
    [self sr_DownloadManager];
}

/*** NSURLSession : 若文件已经存在,原生Api会报错 ***/
- (void)urlSession
{
    NSString *document = NSSearchPathForDirectoriesInDomains(NSDocumentDirectory, NSUserDomainMask, YES).lastObject;
    NSLog(@"%@",document);
    
    
    NSString *urlString = @"http://127.0.0.1/post/大片/流媒体与直播.mp4";
    NSURL *url = [NSURL URLWithString:[urlString stringByAddingPercentEncodingWithAllowedCharacters:[NSCharacterSet URLQueryAllowedCharacterSet]]];
    
    NSURLRequest *request = [NSURLRequest requestWithURL:url cachePolicy:NSURLRequestUseProtocolCachePolicy timeoutInterval:10];
    
    [[[NSURLSession sharedSession] downloadTaskWithRequest:request completionHandler:^(NSURL * _Nullable location, NSURLResponse * _Nullable response, NSError * _Nullable error)
    {
        if (error) {
            NSLog(@"下载失败 :\n %@",error);
            return ;
        }
        
        NSError *err = nil;
        NSString *filePath = [NSSearchPathForDirectoriesInDomains(NSCachesDirectory, NSUserDomainMask, YES).lastObject stringByAppendingPathComponent:@"大片.mp4"];
        
        [[NSFileManager defaultManager] copyItemAtURL:location toURL:[NSURL fileURLWithPath:filePath] error:&err];
        if (err) {
            if (err.code == 526) {
                NSLog(@"文件已经存在");
            }
            
            NSLog(@"赋值文件失败:\n %@",err);
        }
    }] resume];
}

/*** AFN : 若文件已经存在,AFN会进行覆盖 ***/
- (void)AFN
{
    NSString *document = NSSearchPathForDirectoriesInDomains(NSDocumentDirectory, NSUserDomainMask, YES).lastObject;
    NSLog(@"%@",document);
    
    NSString *urlString = @"http://127.0.0.1/post/大片/流媒体与直播.mp4";
    NSURL *url = [NSURL URLWithString:[urlString stringByAddingPercentEncodingWithAllowedCharacters:[NSCharacterSet URLQueryAllowedCharacterSet]]];
    NSURLRequest *request = [NSURLRequest requestWithURL:url cachePolicy:NSURLRequestUseProtocolCachePolicy timeoutInterval:10];
    
    [[[AFHTTPSessionManager manager] downloadTaskWithRequest:request progress:^(NSProgress * _Nonnull downloadProgress) {
        
        NSLog(@" 2.下载升级文件: OTA文件下载进度( %.2f %%)",(1.0 * downloadProgress.completedUnitCount / downloadProgress.totalUnitCount) * 100);
        
    } destination:^NSURL * _Nonnull(NSURL * _Nonnull targetPath, NSURLResponse * _Nonnull response) {
        
        NSString *filePath = [NSSearchPathForDirectoriesInDomains(NSCachesDirectory, NSUserDomainMask, YES).lastObject stringByAppendingPathComponent:@"大片.mp4"];
        NSURL *filePathUrl = [NSURL fileURLWithPath:filePath];
        return filePathUrl;
        
    } completionHandler:^(NSURLResponse * _Nonnull response, NSURL * _Nullable filePath, NSError * _Nullable error) {
        
        if (error) {
            NSLog(@" 下载失败: \n %@ \n FilePath:%@",error, filePath);
            return ;
        }
        NSLog(@" 下载完成: \n%@",filePath.absoluteString);
    }] resume];
}

/*** SRDownloadManager ***/
- (void)sr_DownloadManager
{
    NSString *filePath = [NSSearchPathForDirectoriesInDomains(NSCachesDirectory, NSUserDomainMask, YES).lastObject stringByAppendingPathComponent:@"大片.mp4"];
    
    NSString *urlString = @"http://127.0.0.1/post/大片/流媒体与直播.mp4";
    NSURL *url = [NSURL URLWithString:[urlString stringByAddingPercentEncodingWithAllowedCharacters:[NSCharacterSet URLQueryAllowedCharacterSet]]];
    
    [[SRDownloadManager sharedManager] downloadURL: url
                                          destPath: filePath
                                             state: ^(SRDownloadState state) {
        
                                                 
    } progress:^(NSInteger receivedSize, NSInteger expectedSize, CGFloat progress) {
        
        NSLog(@"下载进度: %.2f %%", progress);
        
    } completion:^(BOOL success, NSString *filePath, NSError *error) {
        
        if (error) {
            NSLog(@"下载失败: \n%@",error);
            return ;
        }
        
        NSLog(@"下载完成");
    }];
}
@end

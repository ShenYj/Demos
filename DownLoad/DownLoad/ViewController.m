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
@property (nonatomic,strong) NSMutableArray        *ECGUpdateFileCache;    // 存放ECG OTA文件的记录
@end

@implementation ViewController


- (void)viewDidLoad
{
    [super viewDidLoad];
    
    // 缓存记录
    NSString *cacheDocument = (NSSearchPathForDirectoriesInDomains(NSCachesDirectory, NSUserDomainMask, YES).lastObject);
    NSString *OTAFileDocument = [cacheDocument stringByAppendingPathComponent:@"ECGUpdateFileDocument"];
    NSString *plistFileName = @"OTAFilePlist.plist";
    NSString *plistFileNamePath = [OTAFileDocument stringByAppendingPathComponent:plistFileName];
    
    BOOL isDirectory = NO;
    BOOL result = [[NSFileManager defaultManager] fileExistsAtPath:plistFileNamePath isDirectory:&isDirectory];
    if (result && !isDirectory) {
        // 存在 && 不是文件夹
        NSLog(@" OTAFilePlist.plist 文件已存在 ");
        NSMutableArray *plist = [NSMutableArray arrayWithContentsOfFile:plistFileNamePath];
        _ECGUpdateFileCache = plist;
        
    } else {
        
        NSError *error = nil;
        // 不存在
        BOOL flag = [[NSFileManager defaultManager] createDirectoryAtPath:plistFileNamePath withIntermediateDirectories:YES attributes:nil error:&error];
        if ( !flag || error) {
            
            NSLog(@"创建目录失败: %@",error);
        } else {
            
            NSLog(@"创建目录和文件成功  \n%@",plistFileNamePath);
            _ECGUpdateFileCache = [NSMutableArray array];
            [_ECGUpdateFileCache writeToFile:plistFileNamePath atomically:YES];
        }
    }
    
    NSLog(@"%@",OTAFileDocument);
}

- (void)touchesBegan:(NSSet<UITouch *> *)touches withEvent:(UIEvent *)event
{
    
    
    // 1. 原生 (NSURLSession)
    //[self urlSession];
    // 2. AFN
    [self AFN];
    // 3. SRDownloadManager
    //[self sr_DownloadManager];
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
    NSString *urlString = @"http://127.0.0.1/post/大片/流媒体与直播.mp4";
    NSURL *url = [NSURL URLWithString:[urlString stringByAddingPercentEncodingWithAllowedCharacters:[NSCharacterSet URLQueryAllowedCharacterSet]]];
    NSURLRequest *request = [NSURLRequest requestWithURL:url cachePolicy:NSURLRequestUseProtocolCachePolicy timeoutInterval:10];
    
    [[[AFHTTPSessionManager manager] downloadTaskWithRequest:request progress:^(NSProgress * _Nonnull downloadProgress) {
        
        NSLog(@" 2.下载升级文件: OTA文件下载进度( %.2f %%)",(1.0 * downloadProgress.completedUnitCount / downloadProgress.totalUnitCount) * 100);
        
    } destination:^NSURL * _Nonnull(NSURL * _Nonnull targetPath, NSURLResponse * _Nonnull response) {
        
        NSString *filePath = [NSSearchPathForDirectoriesInDomains(NSCachesDirectory, NSUserDomainMask, YES).lastObject stringByAppendingPathComponent:@"大片.mp4"];
        NSURL *filePathUrl = [NSURL fileURLWithPath:filePath];
        NSLog(@"%@",filePath);
        
        return filePathUrl;
        
    } completionHandler:^(NSURLResponse * _Nonnull response, NSURL * _Nullable filePath, NSError * _Nullable error) {
        
        if (error) {
            NSLog(@" 下载失败: \n %@ \n FilePath:%@",error, filePath);
            return ;
        }
        
        NSString *cacheDocument = (NSSearchPathForDirectoriesInDomains(NSCachesDirectory, NSUserDomainMask, YES).lastObject);
        NSString *plistFileName = @"OTAFilePlist.plist";
        NSString *OTAFileDocument = [cacheDocument stringByAppendingPathComponent:@"ECGUpdateFileDocument"];
        NSString *plistFileNamePath = [OTAFileDocument stringByAppendingPathComponent:plistFileName];

        [self.ECGUpdateFileCache writeToFile:plistFileNamePath atomically:YES];
        
        
        NSLog(@" 下载完成: \n%@  \n %@",filePath.pathComponents.lastObject, filePath.lastPathComponent);
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
            [[SRDownloadManager sharedManager] deleteFile:filePath];
            return ;
        }
        
        NSLog(@"下载完成");
        [[SRDownloadManager sharedManager] deleteFile:filePath];
    }];
}

#pragma mark - lazy

- (NSMutableArray *)ECGUpdateFileCache {
    if (!_ECGUpdateFileCache) {
        // 缓存记录
        NSString *cacheDocument = (NSSearchPathForDirectoriesInDomains(NSCachesDirectory, NSUserDomainMask, YES).lastObject);
        NSString *OTAFileDocument = [cacheDocument stringByAppendingPathComponent:@"ECGUpdateFileDocument"];
        NSString *plistFileName = @"OTAFilePlist.plist";
        NSString *plistFileNamePath = [OTAFileDocument stringByAppendingPathComponent:plistFileName];
        
        BOOL isDirectory = NO;
        BOOL result = [[NSFileManager defaultManager] fileExistsAtPath:OTAFileDocument isDirectory:&isDirectory];
        if (result && isDirectory) {
            // 存在 && 是文件夹
            NSMutableArray *plist = [NSMutableArray arrayWithContentsOfFile:plistFileNamePath];
            _ECGUpdateFileCache = plist;
            NSLog(@" OTADocument 文件夹已存在 ");
        } else {
            NSError *error = nil;
            // 不存在
            BOOL flag = [[NSFileManager defaultManager] createDirectoryAtPath:OTAFileDocument withIntermediateDirectories:YES attributes:nil error:&error];
            if ( !flag || error) {
                NSLog(@"创建目录失败: %@",error);
            } else {
                
                _ECGUpdateFileCache = [NSMutableArray array];
                [_ECGUpdateFileCache writeToFile:plistFileNamePath atomically:YES];
                NSLog(@"创建目录和文件成功  \n%@",plistFileNamePath);
            }
        }
        
        NSLog(@"%@",plistFileNamePath);
    }
    return _ECGUpdateFileCache;
}

@end

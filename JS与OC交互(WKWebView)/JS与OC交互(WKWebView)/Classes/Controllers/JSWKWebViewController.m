//
//  JSWebViewController.m
//  Demos
//
//  Created by ShenYj on 16/9/5.
//  Copyright © 2016年 ___ShenYJ___. All rights reserved.
//

#import "JSWKWebViewController.h"
#import "JSUIkitExtension.h"
#import "JSCartView.h"

@interface JSWKWebViewController () <UIWebViewDelegate>

@property (nonatomic,weak) UIWebView *webView;

@end

@implementation JSWKWebViewController

- (void)loadView{
    
    self.view = [[UIWebView alloc] init];
    self.view.backgroundColor = [UIColor js_randomColor];
    
}

- (void)viewDidLoad{
    [super viewDidLoad];
    
    self.webView = (UIWebView *)self.view;
    
    // 本地Apache服务器
//    NSString *urlString = @"http://localhost:63342/demo(HTML)/JS与OC交互Demo.html";
//    NSURL *url = [NSURL URLWithString:[urlString stringByAddingPercentEscapesUsingEncoding:NSUTF8StringEncoding]];
//    [self.webView loadRequest:[NSURLRequest requestWithURL:url]];
    
    //    NSString *filePath = [[NSBundle mainBundle]pathForResource:@"JS与OC交互Demo.html" ofType:nil];
    //    NSString *htmlString = [NSString stringWithContentsOfFile:filePath encoding:NSUTF8StringEncoding error:NULL];
    //    [self.webView loadHTMLString:htmlString baseURL:[[NSBundle mainBundle] bundleURL]];
    
    // 项目内资源
    NSURL *url = [[NSBundle mainBundle] URLForResource:@"JS与OC交互Demo.html" withExtension:nil];
    [self.webView loadRequest:[NSURLRequest requestWithURL:url]];
    self.webView.delegate = self;
    
}

#pragma mark - 拦截URL后执行的OC方法
// 不带参数
- (void)demoMethod{
    
    UIViewController *viewController = [[UIViewController alloc] init];
    viewController.view.backgroundColor = [UIColor js_randomColor];
    [self.navigationController pushViewController:viewController animated:YES];
    
}
// 带参数
- (void)demoMethodWithParameters:(NSArray *)parameters{
    
    UIViewController *viewController = [[UIViewController alloc] init];
    JSCartView *view = [[JSCartView alloc] init];
    view.data = parameters;
    viewController.view = view;
    [self.navigationController pushViewController:viewController animated:YES];
    
}

#pragma mark - UIWebViewDelegate

// Javascript间接调用OC方法需要使用,通过该代理方法拦截URL
- (BOOL)webView:(UIWebView *)webView shouldStartLoadWithRequest:(NSURLRequest *)request navigationType:(UIWebViewNavigationType)navigationType{
    
    if ([request.URL.scheme isEqualToString:@"cart"]) {
        
        NSMutableArray *tempArr = [NSMutableArray array];
        [request.URL.pathComponents enumerateObjectsUsingBlock:^(NSString *obj, NSUInteger idx, BOOL * _Nonnull stop) {
            
            if (idx >= 2) {
                [tempArr addObject:obj];
            }
        }];
        // 执行OC方法
        //[self demoMethod];
        [self demoMethodWithParameters:tempArr];
        
        return NO;
    }
    
    return YES;
    
}

// 开始加载
- (void)webViewDidStartLoad:(UIWebView *)webView{
    
}

// 加载完成 ,在这里执行Javascript函数
- (void)webViewDidFinishLoad:(UIWebView *)webView{
    
    //[webView stringByEvaluatingJavaScriptFromString:@"javascript:alertMessage()"];
    
}

- (void)webView:(UIWebView *)webView didFailLoadWithError:(NSError *)error{
    NSLog(@"%@",error);
}

// 加载失败
//- (void)webView:(UIWebView *)webView didFailLoadWithError:(nullable NSError *)error{
//   NSLog(@"%@",error);
//}

@end

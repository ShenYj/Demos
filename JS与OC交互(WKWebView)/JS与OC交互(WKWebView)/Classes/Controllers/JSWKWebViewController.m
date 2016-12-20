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
#import <WebKit/WebKit.h>


@interface JSWKWebViewController () <WKNavigationDelegate,WKUIDelegate,WKScriptMessageHandler>

@property (nonatomic,weak) WKWebView *webView;

@end

@implementation JSWKWebViewController

- (void)loadView{
    
    self.view = [[WKWebView alloc] init];
    self.view.backgroundColor = [UIColor js_randomColor];
    
}

- (void)viewDidLoad{
    [super viewDidLoad];
    
    self.webView = (WKWebView *)self.view;
    
    // 本地Apache服务器
    //    NSString *urlString = @"http://localhost:63342/demo(HTML)/JS与OC交互Demo.html";
    //    NSURL *url = [NSURL URLWithString:[urlString stringByAddingPercentEscapesUsingEncoding:NSUTF8StringEncoding]];
    //   [self.webView loadRequest:[NSURLRequest requestWithURL:url]];
    
    //    NSString *filePath = [[NSBundle mainBundle]pathForResource:@"JS与OC交互Demo.html" ofType:nil];
    //    NSString *htmlString = [NSString stringWithContentsOfFile:filePath encoding:NSUTF8StringEncoding error:NULL];
    //    [self.webView loadHTMLString:htmlString baseURL:[[NSBundle mainBundle] bundleURL]];
    // 项目内资源
    //    NSURL *url = [[NSBundle mainBundle] URLForResource:@"JS与OC交互Demo.html" withExtension:nil];
    //    [self.webView loadRequest:[NSURLRequest requestWithURL:url]];
    
    // 使用WKWebView加载本地HTML文件
    NSURL *localFileUrl = [NSURL fileURLWithPath:[[NSBundle mainBundle] pathForResource:@"JS与OC交互Demo.html" ofType:nil]];
    [self.webView loadFileURL:localFileUrl allowingReadAccessToURL:localFileUrl];
    self.webView.navigationDelegate = self;
    self.webView.UIDelegate = self;
    
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

#pragma mark
#pragma mark - WKNavigationDelegate

- (void)webView:(WKWebView *)webView decidePolicyForNavigationAction:(WKNavigationAction *)navigationAction decisionHandler:(void (^)(WKNavigationActionPolicy))decisionHandler {
    
    if ([navigationAction.request.URL.scheme isEqualToString:@"cart"]) {
        
        NSMutableArray *tempArr = [NSMutableArray array];
        [navigationAction.request.URL.pathComponents enumerateObjectsUsingBlock:^(NSString *obj, NSUInteger idx, BOOL * _Nonnull stop) {
            
            if (idx >= 2) {
                [tempArr addObject:obj];
            }
        }];
        // 执行OC方法
        //[self demoMethod];
        [self demoMethodWithParameters:tempArr];
        
        decisionHandler(WKNavigationActionPolicyCancel);
    }
    decisionHandler(WKNavigationActionPolicyAllow);

}

- (void)webView:(WKWebView *)webView didFinishNavigation:(WKNavigation *)navigation {
    // 屏幕适配
    NSString *jScript = @"var meta = document.createElement('meta'); \
    meta.name = 'viewport'; \
    meta.content = 'width=device-width, initial-scale=1.0, maximum-scale=3.0, user-scalable=no'; \
    var head = document.getElementsByTagName('head')[0];\
    head.appendChild(meta);";
    [webView evaluateJavaScript:jScript completionHandler:^(id _Nullable result, NSError * _Nullable error) {
        
    }];
}

#pragma mark
#pragma mark - WKUIDelegate

- (void)webView:(WKWebView *)webView runJavaScriptAlertPanelWithMessage:(NSString *)message initiatedByFrame:(WKFrameInfo *)frame completionHandler:(void (^)(void))completionHandler {
    
    NSLog(@"%@",message);
    completionHandler();
}

#pragma mark
#pragma mark - WKScriptMessageHandler

- (void)userContentController:(WKUserContentController *)userContentController didReceiveScriptMessage:(WKScriptMessage *)message {
    
    NSLog(@"%@",message);
}

@end

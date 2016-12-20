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
#import "Masonry.h"
#import <WebKit/WebKit.h>


@interface JSWKWebViewController () <WKNavigationDelegate,WKUIDelegate,WKScriptMessageHandler>

@property (nonatomic) WKWebView *webView;

@end

@implementation JSWKWebViewController

- (void)viewDidLoad{
    [super viewDidLoad];
    self.automaticallyAdjustsScrollViewInsets = NO;
    
    
    [self.view addSubview:self.webView];
    [self.webView mas_makeConstraints:^(MASConstraintMaker *make) {
        make.left.bottom.right.mas_equalTo(self.view);
        make.top.mas_equalTo(self.view).mas_offset(64);
    }];
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
    //[self.webView loadFileURL:localFileUrl allowingReadAccessToURL:localFileUrl];
    
    NSURLRequest *request = [NSURLRequest requestWithURL:localFileUrl];
    [self.webView loadRequest:request];
    
    self.navigationItem.leftBarButtonItem = [[UIBarButtonItem alloc] initWithTitle:@"返回" style:UIBarButtonItemStylePlain target:self action:@selector(clickLeftBarButtonItem:)];
}


- (void)clickLeftBarButtonItem:(UIBarButtonItem *)sender {
    [self.webView goBack];
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
//    NSString *jScript = @"var meta = document.createElement('meta'); \
//    meta.name = 'viewport'; \
//    meta.content = 'width=device-width, initial-scale=1.0, maximum-scale=3.0, user-scalable=no'; \
//    var head = document.getElementsByTagName('head')[0];\
//    head.appendChild(meta);";
//    [webView evaluateJavaScript:jScript completionHandler:^(id _Nullable result, NSError * _Nullable error) {
//        
//    }];
    
}

#pragma mark
#pragma mark - WKUIDelegate

- (void)webView:(WKWebView *)webView runJavaScriptAlertPanelWithMessage:(NSString *)message initiatedByFrame:(WKFrameInfo *)frame completionHandler:(void (^)(void))completionHandler {
    
    NSLog(@"%@--%@",message,frame);
    completionHandler();
}

#pragma mark
#pragma mark - WKScriptMessageHandler

- (void)userContentController:(WKUserContentController *)userContentController didReceiveScriptMessage:(WKScriptMessage *)message {
    
    NSLog(@"%@",userContentController);
    NSLog(@"%@",message);
}


#pragma mark
#pragma mark - lazy

- (WKWebView *)webView {
    if (!_webView) {
        WKUserContentController *userContentController = [[WKUserContentController alloc] init];
        [userContentController addScriptMessageHandler:self name:@"test"];
        
        WKWebViewConfiguration *configuration = [[WKWebViewConfiguration alloc] init];
        configuration.userContentController = userContentController;
        
        WKPreferences *preferences = [WKPreferences new];
        preferences.javaScriptCanOpenWindowsAutomatically = YES;
        preferences.minimumFontSize = 40.0;
        configuration.preferences = preferences;
        _webView = [[WKWebView alloc] initWithFrame:CGRectZero configuration:configuration];
        _webView.navigationDelegate = self;
        _webView.UIDelegate = self;
    }
    return _webView;
}

@end

//
//  ViewController.m
//  WKWebView练习
//
//  Created by ShenYj on 16/9/18.
//  Copyright © 2016年 ___ShenYJ___. All rights reserved.
//

#import "ViewController.h"
#import <WebKit/WebKit.h>

@interface ViewController ()

@end

@implementation ViewController

- (void)viewDidLoad {
    [super viewDidLoad];
    // Do any additional setup after loading the view, typically from a nib.
}


- (void)didReceiveMemoryWarning {
    [super didReceiveMemoryWarning];
    // Dispose of any resources that can be recreated.
}

#pragma mark - WKNavigationDelegate
// 在发送请求之前，决定是否跳转
- (void)webView:(WKWebView *)webView decidePolicyForNavigationAction:(WKNavigationAction *)navigationAction decisionHandler:(void (^)(WKNavigationActionPolicy))decisionHandler{
    
    if ([navigationAction.request.URL.absoluteString hasPrefix:@"kRedirect_URI"]) {
        
        NSRange range = [navigationAction.request.URL.absoluteString rangeOfString:@"code="];
        
        NSString *code = [navigationAction.request.URL.absoluteString substringFromIndex:range.location + range.length];
        
        // 保存Code信息
        //[JSUserAccountToolModel sharedManager].code = code;
        
        NSLog(@"%@",code);
        
        decisionHandler(WKNavigationActionPolicyCancel);
    }
    
    decisionHandler(WKNavigationActionPolicyAllow);
    
}

// 接收到服务器跳转请求之后调用
- (void)webView:(WKWebView *)webView didReceiveServerRedirectForProvisionalNavigation:(WKNavigation *)navigation{
    
}

//在收到响应后，决定是否继续处理。根据response相关信息，可以决定这次跳转是否可以继续进行。
//- (void)webView:(WKWebView *)webView decidePolicyForNavigationResponse:
//(WKNavigationResponse *)navigationResponse decisionHandler:(void (^)(WKNavigationResponsePolicy))decisionHandler{
//
//
//    if ([navigationResponse.response.URL.absoluteString hasPrefix:kRedirect_URI]) {
//
//        NSRange range = [navigationResponse.response.URL.absoluteString rangeOfString:@"code="];
//
//        NSString *code = [navigationResponse.response.URL.absoluteString substringFromIndex:range.location + range.length];
//
//        // 保存Code信息
//        [JSUserAccountToolModel sharedManager].code = code;
//
//        NSLog(@"%@",code);
//
//        decisionHandler(WKNavigationResponsePolicyCancel);
//    }
//
//    decisionHandler(WKNavigationResponsePolicyAllow);
//}

// 页面开始加载时调用
- (void)webView:(WKWebView *)webView didStartProvisionalNavigation:(WKNavigation *)navigation{
    
    //[MBProgressHUD showHUDAddedTo:self.view animated:YES];
}

// 当内容开始返回时调用
- (void)webView:(WKWebView *)webView didCommitNavigation:(WKNavigation *)navigation{
    
}
// 页面加载完成之后调用
- (void)webView:(WKWebView *)webView didFinishNavigation:(null_unspecified WKNavigation *)navigation{
    
    //[MBProgressHUD hideHUDForView:self.view animated:YES];
}

// 页面加载失败时调用
- (void)webView:(WKWebView *)webView didFailProvisionalNavigation:(WKNavigation *)navigation{
    
}

@end

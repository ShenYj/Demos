//
//  ViewController.m
//  01-SAX解析XML
//
//  Created by Apple on 16/5/31.
//  Copyright © 2016年 itcast. All rights reserved.
//

#import "ViewController.h"
#import "Video.h"

@interface ViewController () <NSXMLParserDelegate>
@property (nonatomic ,strong) NSMutableArray *mArr;
@property (nonatomic ,strong) Video *currentVideo;
@property (nonatomic, copy) NSMutableString *currentString;
@end

@implementation ViewController


//懒加载
- (NSMutableString *)currentString{
    if (_currentString == nil) {
        _currentString = [NSMutableString string];
    }
    return _currentString;
}

- (void)viewDidLoad {
    [super viewDidLoad];
    // Do any additional setup after loading the view, typically from a nib.
    //1. URL
    NSURL *url = [NSURL URLWithString:@"http://127.0.0.1/videos.xml"];
    
    //2. 请求
    NSURLRequest *request = [NSURLRequest requestWithURL:url];
    
    //3. 建立连接发送请求
    __weak typeof(self) weakSelf = self;
    [NSURLConnection sendAsynchronousRequest:request queue:[NSOperationQueue mainQueue] completionHandler:^(NSURLResponse * _Nullable response, NSData * _Nullable data, NSError * _Nullable connectionError) {
        //解析xml 数据
        NSXMLParser *parser = [[NSXMLParser alloc] initWithData:data];
        // 设置代理
        parser.delegate = weakSelf;
        //开始解析
        [parser parse];
    }];
}

- (void)didReceiveMemoryWarning {
    [super didReceiveMemoryWarning];
    // Dispose of any resources that can be recreated.
}


#pragma mark -XML 解析的代理方法
//文档解析开始
- (void)parserDidStartDocument:(NSXMLParser *)parser{
//    NSLog(@"开始解析");
    self.mArr = [NSMutableArray array];
}

//解析到开始标签
- (void)parser:(NSXMLParser *)parser didStartElement:(NSString *)elementName namespaceURI:(nullable NSString *)namespaceURI qualifiedName:(nullable NSString *)qName attributes:(NSDictionary<NSString *, NSString *> *)attributeDict{
//    NSLog(@"解析到开始标签:%@",elementName);
    
    //解析到video 开始标签创建模型对象
    if ([elementName isEqualToString:@"video"]) {
        self.currentVideo = [[Video alloc] init];
        self.currentVideo.videoId = [attributeDict objectForKey:@"videoId"];
    }
}

//找到标签之间的文本信息
- (void)parser:(NSXMLParser *)parser foundCharacters:(NSString *)string{
//    NSLog(@"找到标签之间内容:%@",string);
    [self.currentString appendString:string];
}

//解析到结束标签
- (void)parser:(NSXMLParser *)parser didEndElement:(NSString *)elementName namespaceURI:(nullable NSString *)namespaceURI qualifiedName:(nullable NSString *)qName{
//    NSLog(@"解析到结束标签:%@",elementName);
    
    if ([elementName isEqualToString:@"videos"]) {//什么都不做
        
    }else if ([elementName isEqualToString:@"video"]) {
        [self.mArr addObject:self.currentVideo];
    }else { //通过kvc 给属性赋值
//        self.currentVideo.name = self.currentString;
        //KVC赋值只是内存地址的改变, 并不做类型的转换,和引用的改变
        [self.currentVideo setValue:self.currentString forKey:elementName];
        
//        self.currentString = nil; //这样做只后就被回收
        [self.currentString setString:@""];
    }
}

//文档解析结束
- (void)parserDidEndDocument:(NSXMLParser *)parser{
//    NSLog(@"解析结束");
    
    NSLog(@"%@",self.mArr);
}

@end

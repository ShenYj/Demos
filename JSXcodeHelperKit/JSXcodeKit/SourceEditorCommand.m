//
//  SourceEditorCommand.m
//  JSXcodeKit
//
//  Created by ShenYj on 2016/12/29.
//  Copyright © 2016年 ShenYj. All rights reserved.
//

#import "SourceEditorCommand.h"

@implementation SourceEditorCommand

- (void)performCommandWithInvocation:(XCSourceEditorCommandInvocation *)invocation completionHandler:(void (^)(NSError * _Nullable nilOrError))completionHandler
{
    // Implement your command here, invoking the completion handler when done. Pass it nil on success, and an NSError on failure.
    
    completionHandler(nil);
}

@end

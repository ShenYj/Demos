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
    // 1.要实现触发菜单的时候删除当前光标停留的哪一行
    // 取到选中范围,如果没有选中,那么久什么也不做
    if (invocation.buffer.selections.count != 0) {
        // 如果选中范围不为0,就删除选中的这几行
        // 开始删除的位置
        NSUInteger loc = invocation.buffer.selections.firstObject.start.line;
        NSUInteger len = invocation.buffer.selections.firstObject.end.line - loc + 1;
        NSRange range = NSMakeRange(loc, len);
        NSIndexSet *indexSet = [NSIndexSet indexSetWithIndexesInRange:range];
        // 取到当前代码编辑区域的数组,移除指定NSIndexSet的代码
        [invocation.buffer.lines removeObjectsAtIndexes:indexSet];
    }
    // completionHandler是用来告诉Xcode 我们的事情做完了,如果参数传nil代表我们的代码执行没有问题
    // 如果代码逻辑中想要抛出一个错误,也可以将错误信息通过completionHandler传递给Xcode本身
    completionHandler(nil);
}

@end

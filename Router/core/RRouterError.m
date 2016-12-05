//
//  RRouterError.m
//  Router
//
//  Created by yushan shen on 2016/12/5.
//  Copyright © 2016年 yushan.com. All rights reserved.
//

#import "RRouterError.h"

@implementation RRouterError

- (instancetype)initWithType:(RRouterErrorType)type message:(NSString *)message{
    if (self = [super init]) {
        self.type = type;
        self.message = message;
    }
    return self;
}
@end

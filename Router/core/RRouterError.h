//
//  RRouterError.h
//  Router
//
//  Created by yushan shen on 2016/12/5.
//  Copyright © 2016年 yushan.com. All rights reserved.
//

#import <Foundation/Foundation.h>

typedef enum : NSUInteger {
    RRouterErrorTypeUrlUnSupport,
    RRouterErrorTypeUrlUnAvailable,
} RRouterErrorType;

@interface RRouterError : NSObject
@property(assign, nonatomic)RRouterErrorType type;
@property(copy, nonatomic) NSString *message;

- (instancetype)initWithType:(RRouterErrorType)type message:(NSString *)message;
@end

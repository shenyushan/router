//
//  UIViewController+Router.h
//  Router
//
//  Created by yushan shen on 2016/12/2.
//  Copyright © 2016年 yushan.com. All rights reserved.
//

#import <UIKit/UIKit.h>
#import "RRouterViewControllerProtocol.h"

@interface UIViewController (Router)<RRouterViewControllerProtocol>

- (void)willDisplayByRouter:(RRouterManager *)router handler:(void(^)(RRouterDisplayViewControllerType result, RRouterError *error))handler;
- (bool)canDisplayByRouter:(RRouterManager *)router;

@end

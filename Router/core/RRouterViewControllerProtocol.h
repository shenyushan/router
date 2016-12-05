//
//  RRouterViewControllerProtocol.h
//  Router
//
//  Created by yushan shen on 2016/12/2.
//  Copyright © 2016年 yushan.com. All rights reserved.
//

#import <Foundation/Foundation.h>
@class RRouterManager,RRouterError;

typedef enum : NSUInteger {
    RRouterDisplayViewControllerTypeDefault,    // default is allow
    RRouterDisplayViewControllerTypeRefused,   //denied
    RRouterDisplayViewControllerTypeAvaliable = RRouterDisplayViewControllerTypeDefault, //allow
} RRouterDisplayViewControllerType;
@protocol RRouterViewControllerProtocol <NSObject>


@optional
/*
   router want push or present viewcontroller;
   call handler to continue, if result is avaliable, viewcontroller will be display;
   not call handler or result is refused,viewcontroller will not be display
 */
- (void)willDisplayByRouter:(RRouterManager *)router handler:(void(^)(RRouterDisplayViewControllerType result, RRouterError *error))handler;

/*
   router asks  while viewcontroller can be display
   viewcontroller can do something in this method  such as : verify routerParameters
 */
- (bool)canDisplayByRouter:(RRouterManager *)router;

@end

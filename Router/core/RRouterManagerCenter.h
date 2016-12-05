//
//  RRouterManagerCenter.h
//  Router
//
//  Created by yushan shen on 2016/12/2.
//  Copyright © 2016年 yushan.com. All rights reserved.
//

#import <UIKit/UIKit.h>

@interface RRouterManagerCenter : NSObject

+(instancetype)sharedCenter;
- (void)registerScheme:(NSString *)scheme;
- (void)registerAppInfoSchemes;          //register scheme from info.plist
- (void)registerRouterUrl:(NSString *)url viewControllerClass:(Class)vcClass;//url pattern  scheme://host/path
- (void)registerRouterUrls:(NSArray <NSString *>*)urls viewControllerClasses:(NSArray <Class> *)vcClasses;
- (void)registerFromFilePath:(NSString *)filePath;

- (NSArray *)schemes;
- (UIViewController *)viewControllerForRouterUrl:(NSString *)url;

@end

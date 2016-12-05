//
//  RRouterManagerCenter.m
//  Router
//
//  Created by yushan shen on 2016/12/2.
//  Copyright © 2016年 yushan.com. All rights reserved.
//

#import "RRouterManagerCenter.h"
#import "NSString+UrlComponent.h"

@interface RRouterManagerCenter()
@property(retain, nonatomic) NSMutableDictionary *routerDictionary;
@property(retain, nonatomic) NSMutableDictionary *schemeDictionary;
@end

@implementation RRouterManagerCenter

static RRouterManagerCenter *_center;

-(instancetype)init{
    if (self = [super init]) {
        self.routerDictionary = [NSMutableDictionary dictionaryWithCapacity:0];
        self.schemeDictionary = [NSMutableDictionary dictionaryWithCapacity:0];
    }
    return self;
}

+(instancetype)sharedCenter{
    if (!_center) {
        static dispatch_once_t onceToken;
        dispatch_once(&onceToken, ^{
            _center = [[RRouterManagerCenter alloc] init];
        });
    }
    return _center;
}

-(void)registerScheme:(NSString *)scheme{
    [self.schemeDictionary setObject:scheme forKey:scheme.lowercaseString];
}

-(void)registerAppInfoSchemes{
    
    NSDictionary* infoDictionary = [[NSBundle mainBundle] infoDictionary];
    for (NSDictionary* dic in infoDictionary[@"CFBundleURLTypes"]) {
        NSString* appUrlScheme = dic[@"CFBundleURLSchemes"][0];
        [self registerScheme:appUrlScheme];
    }
}

- (NSArray *)schemes{
    return self.schemeDictionary.allKeys;
}
- (void)registerRouterUrl:(NSString *)url viewControllerClass:(Class)vcClass{
    NSString *scheme = url.scheme;
    if (scheme.length>0) {
        [self registerScheme:scheme];
    }
    [self.routerDictionary setObject:vcClass forKey:url.host.lowercaseString];
}
- (void)registerRouterUrls:(NSArray <NSString *>*)urls viewControllerClasses:(NSArray <Class> *)vcClasses{
    NSAssert(urls.count != vcClasses.count, @"registerRouter, Urls does not match classess");
    for (int i=0; i<urls.count; i++) {
        [self registerRouterUrl:urls[i] viewControllerClass:vcClasses[i]];
    }
}
- (void)registerFromFilePath:(NSString *)filePath{
    NSDictionary *dictinoary = [NSDictionary dictionaryWithContentsOfFile:filePath];
    NSAssert([dictinoary isKindOfClass:[NSDictionary class]], @"registerFromFilePath, file must be a dictinoary");
    for (NSString *url in dictinoary.allKeys) {
        NSAssert([url isKindOfClass:[NSString class]], @"registerFromFilePath, dictionary's key must be router url");
        NSString *className = dictinoary[url];
        NSAssert([className isKindOfClass:[NSString class]], @"registerFromFilePath, dictionary's value must be viewController's className");
        [self registerRouterUrl:url viewControllerClass:NSClassFromString(className)];
    }
}


- (UIViewController *)viewControllerForRouterUrl:(NSString *)url{
    NSString *scheme = [[self.schemeDictionary objectForKey:url.scheme] lowercaseString];
    if (scheme.length==0) {
        return nil;
    }
    Class cla = [self.routerDictionary objectForKey:url.host.lowercaseString];
    UIViewController *vc = [[cla alloc] init];
    return vc;
}

@end

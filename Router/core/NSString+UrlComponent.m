//
//  NSString+UrlComponent.m
//  Router
//
//  Created by yushan shen on 2016/12/2.
//  Copyright © 2016年 yushan.com. All rights reserved.
//

#import "NSString+UrlComponent.h"

@implementation NSString (UrlComponent)


-(NSString *)scheme{
    return [NSURL URLWithString:self].scheme;
}

-(NSString *)host{
    return [NSURL URLWithString:self].host;
}

-(NSString *)path{
    return [NSURL URLWithString:self].path;
}

-(NSDictionary *)parameters{
    NSString *parameters = [NSURL URLWithString:self].query;
    NSArray*parameterStrings = [parameters componentsSeparatedByString:@"&"];
    NSMutableDictionary *dict = [NSMutableDictionary dictionaryWithCapacity:0];
    for (NSString *paraString in parameterStrings) {
        NSArray *para = [paraString componentsSeparatedByString:@"="];
        if (para.count ==2) {
            NSString *paraName = para.firstObject;
            NSString *paraValue = para.lastObject;
            [dict setValue:paraValue forKey:paraName];
        }
    }
    return [dict copy];
}

@end

//
//  NSString+UrlComponent.h
//  Router
//
//  Created by yushan shen on 2016/12/2.
//  Copyright © 2016年 yushan.com. All rights reserved.
//

#import <Foundation/Foundation.h>

@interface NSString (UrlComponent)

-(NSString *)scheme;
-(NSString *)host;
-(NSString *)path;
-(NSDictionary *)parameters;

@end

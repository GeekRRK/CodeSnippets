//
//  NSObject+AlBuilder.h
//  CodeSnippets
//
//  Created by UGOMEDIA on 16/10/14.
//  Copyright © 2016年 GeekRRK. All rights reserved.
//

#import <Foundation/Foundation.h>

@interface NSObject (AlBuilder)

+ (id)z0_builder:(void(^)(id that))block;
- (id)z0_builder:(void(^)(id that))block;

@end

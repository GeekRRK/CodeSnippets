//
//  NSObject+AlBuilder.m
//  CodeSnippets
//
//  Created by GeekRRK on 16/10/14.
//  Copyright © 2016年 GeekRRK. All rights reserved.
//

#import "NSObject+AlBuilder.h"

@implementation NSObject (AlBuilder)

+ (id)z0_builder:(void(^)(id))block {
    id instance = [[self alloc] init];
    block(instance);
    return instance;
}

- (id)z0_builder:(void(^)(id))block {
    block(self);
    return self;
}

@end

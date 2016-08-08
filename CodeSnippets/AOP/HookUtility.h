//
//  HookUtility.h
//  Demo_Indicator
//
//  Created by GeekRRK on 16/4/22.
//  Copyright © 2016年 GeekRRK. All rights reserved.
//

// Refer to: http://www.cocoachina.com/ios/20160421/15912.html

#import <Foundation/Foundation.h>

@interface HookUtility : NSObject

+ (void)swizzlingInClass:(Class)cls originalSelector:(SEL)originalSelector swizzledSelector:(SEL)swizzledSelector;

+ (NSDictionary *)dictionaryFromUserStatisticsConfigPlist;

@end

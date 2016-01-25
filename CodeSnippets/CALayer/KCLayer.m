//
//  KCLayer.m
//  AutoLayout
//
//  Created by GeekRRK on 1/25/16.
//  Copyright © 2016 GeekRRK. All rights reserved.
//

#import "KCLayer.h"

@implementation KCLayer

- (void)drawInContext:(CGContextRef)ctx {
    NSLog(@"3-drawInContext:");
    NSLog(@"CGContext:%@", ctx);

    CGContextSetRGBFillColor(ctx, 135.0/255.0, 232.0/255.0, 84.0/255.0, 1);
    CGContextSetRGBStrokeColor(ctx, 135.0/255.0, 232.0/255.0, 84.0/255.0, 1);
    CGContextMoveToPoint(ctx, 94.5, 33.5);
    
    // Star Drawing
    CGContextAddLineToPoint(ctx, 104.02, 47.39);
    CGContextAddLineToPoint(ctx, 120.18, 52.16);
    CGContextAddLineToPoint(ctx, 109.91, 65.51);
    CGContextAddLineToPoint(ctx, 110.37, 82.34);
    CGContextAddLineToPoint(ctx, 94.5, 76.7);
    CGContextAddLineToPoint(ctx, 78.63, 82.34);
    CGContextAddLineToPoint(ctx, 79.09, 65.51);
    CGContextAddLineToPoint(ctx, 68.82, 52.16);
    CGContextAddLineToPoint(ctx, 84.98, 47.39);
    CGContextClosePath(ctx);
    
    CGContextDrawPath(ctx, kCGPathFillStroke);
}

@end

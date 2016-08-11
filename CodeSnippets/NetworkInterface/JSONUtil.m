#import "JSONUtil.h"

@implementation JSONUtil

+ (NSString *)getStringFromJSONValue:(NSObject *)JSONValue {
    JSONValue  = [JSONValue isKindOfClass:[NSNull class]] ? @"" : JSONValue;
    
    if ([JSONValue isKindOfClass:[NSString class]]) {
        return (NSString *)JSONValue;
    } else if ([JSONValue isKindOfClass:[NSNumber class]]) {
        return [(NSNumber *)JSONValue stringValue];
    }
    
    return @"";
}

@end

//
//  Utils.h
//  CodeSnippets
//
//  Created by GeekRRK on 16/4/7.
//  Copyright © 2016年 GeekRRK. All rights reserved.
//

#import <Foundation/Foundation.h>
#import <UIKit/UIKit.h>
#import "Common.h"
#import <CommonCrypto/CommonCrypto.h>

@interface Utils : NSObject

+ (void)showMessage:(NSString *)message;

+ (NSString *) getFilePathBy:(NSString *) fileName;

+ (NSMutableArray *) readFileBy:(NSString *)fileName;

+ (NSMutableDictionary *)readDictBy:(NSString *)fileName;

+ (NSData *)getDataFrom:(NSString *)urlAsString;

+ (void) downloadFile:(NSString *)urlAsString asFileName:(NSString *)fileName;

+ (void) writeArray:(NSMutableArray *)array to:(NSString *)fileName;

+ (void) writeDict:(NSDictionary *)dict to:(NSString *)fileName;

+ (NSData *)readDataBy:(NSString *)fileName;

+ (void)writeData:(NSData *)data to:(NSString *)fileName;

+ (NSDictionary *)postString:(NSString *)dataAsString to:(NSString *)urlAsString;

+ (NSString *)date2String:(NSDate *)date;

+ (NSDate *)string2Date:(NSString *)dateStr;

+ (UIViewController *)getCurrentVC;

+ (UIToolbar *)getKeyBoardToolBarWithCtrl:(UIViewController *)ctrl action:(SEL)act;

+ (NSDate *)getDateFromString:(NSString *)inputString;

+ (NSString *)getStringFromDate:(NSDate *)inputDate;

+ (NSString *)base64Img:(UIImage *)img;

+ (UIImage *)image:(UIImage*)image byScalingToSize:(CGSize)targetSize;

+ (NSString *)reduceImg:(UIImage *)img;

+ (NSString *)reduceImg:(UIImage *)img scale:(CGSize)size;

+ (CGSize)fitsize:(CGSize)thisSize;

+ (UIImage *)fitSmallImage:(UIImage *)image;

+ (NSString *)md5:(NSString *)str;

+ (UIImage *) imageCompressForSize:(UIImage *)sourceImage targetSize:(CGSize)size;

+ (UIImage *) imageCompressForWidth:(UIImage *)sourceImage targetWidth:(CGFloat)defineWidth;

+ (BOOL)isChinese:(NSString *)str;

+ (NSString *)getUUID;

+ (BOOL)validateCellPhone:(NSString *)candidate;

+ (long)getDocumentSize:(NSString *)folderName;

+ (NSString *)getDiskUsed;

+ (NSArray *)getLetters;

+ (NSArray *)getUpperLetters;

+ (NSInteger)getMinuteFromDate:(NSDate *)fDate toDate:(NSDate *)tDate;

+ (int)getRandomNumber:(int)from to:(int)to;

+ (CGRect)getRectOfString:(NSString *)str font:(UIFont *)font size:(CGSize)size;

+ (NSString *)getStringFromJSONValue:(NSObject *)JSONValue;

+ (void)deleteFileByName:(NSString *)fileName;

+ (BOOL)isValidEmail:(NSString *)checkString;

+ (BOOL)checkUserIdCard: (NSString *)idCard;

+ (NSString *)trimWhiteSpacing:(NSString *)str;

+ (UIImage *)snapshot;

+ (void)blurView:(UIView *)view;

@end

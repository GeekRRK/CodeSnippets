//
//  AlDiffModel.h
//  CodeSnippets
//
//  Created by GeekRRK on 16/10/20.
//  Copyright © 2016年 GeekRRK. All rights reserved.
//

#import <Foundation/Foundation.h>

typedef NS_ENUM(NSUInteger, ALDIFFMODEL_TYPE) {
    PersonShowNameAndAvatar,
    PersonShowAvatar,
    PersonShowName
};

@interface AlDiffModel : NSObject

@property (assign, nonatomic) ALDIFFMODEL_TYPE type;
@property (copy, nonatomic) NSString *cellIdentifier;

@end

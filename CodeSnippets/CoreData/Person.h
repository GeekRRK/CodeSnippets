//
//  Person.h
//  CodeSnippets
//
//  Created by GeekRRK on 1/12/16.
//  Copyright © 2016 GeekRRK. All rights reserved.
//

#import <Foundation/Foundation.h>
#import <CoreData/CoreData.h>

@class Card;

@interface Person : NSManagedObject

@property (copy, nonatomic) NSString *name;
@property (assign, nonatomic) NSNumber *age;
@property (strong, nonatomic) Card *card;

@end

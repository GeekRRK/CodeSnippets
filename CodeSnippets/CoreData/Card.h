//
//  Card.h
//  CodeSnippets
//
//  Created by GeekRRK on 1/12/16.
//  Copyright © 2016 GeekRRK. All rights reserved.
//

#import <Foundation/Foundation.h>
#import <CoreData/CoreData.h>

@class Person;

@interface Card : NSManagedObject

@property (copy, nonatomic) NSString *no;
@property (strong, nonatomic) Person *person;

@end

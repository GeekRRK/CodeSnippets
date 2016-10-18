//
//  CoreDataViewController.m
//  CodeSnippets
//
//  Created by GeekRRK on 1/12/16.
//  Copyright © 2016 GeekRRK. All rights reserved.
//

#import "CoreDataViewController.h"
#import <CoreData/CoreData.h>
#import "Person.h"
#import "Card.h"

@interface CoreDataViewController ()

@end

@implementation CoreDataViewController

- (void)viewDidLoad {
    [super viewDidLoad];
    
    // Turn on the output of SQL
    // EditScheme-Arguemnts-ArgumentsPassed On Launch
    // -com.apple.CoreData.SQLDebug
    // 1
    
    NSManagedObjectContext *context = [self setupCoreData];
    
    [self queryFromDatabase:context];
    
    [self addData2Database:context];
    [self addObjc2Database:context];
    [self queryFromDatabase:context];
}

- (NSManagedObjectContext *)setupCoreData {
    // 1、Load merged model
    NSManagedObjectModel *model = [NSManagedObjectModel mergedModelFromBundles:nil];
    
    // 2、Init NSPersistentStoreCoordinator with merged model
    NSPersistentStoreCoordinator *psc = [[NSPersistentStoreCoordinator alloc] initWithManagedObjectModel:model];
    
    // 3、Set the path of SQLite file
    NSString *docs = [NSSearchPathForDirectoriesInDomains(NSDocumentDirectory, NSUserDomainMask, YES) lastObject];
    NSURL *url = [NSURL fileURLWithPath:[docs stringByAppendingPathComponent:@"person.data"]];
    
    // 4、Add persistent store with SQLite
    NSError *error = nil;
    NSPersistentStore *store = [psc addPersistentStoreWithType:NSSQLiteStoreType configuration:nil URL:url options:nil error:&error];
    if (store == nil) {
        [NSException raise:@"Exception when add database" format:@"%@", error.localizedDescription];
    }
    
    // 5、Init the context and set persistentStoreCoordinator to psc created in step 2
    NSManagedObjectContext *context = [[NSManagedObjectContext alloc] init];
    context.persistentStoreCoordinator = psc;
    
    return context;
}

- (void)addData2Database:(NSManagedObjectContext *)context {
    // 1、Create managed object person
    NSManagedObject *person = [NSEntityDescription insertNewObjectForEntityForName:@"Person" inManagedObjectContext:context];
    [person setValue:@"Al" forKey:@"name"];
    [person setValue:[NSNumber numberWithInt:24] forKey:@"age"];
    
    // 2、Create managed object card
    NSManagedObject *card = [NSEntityDescription insertNewObjectForEntityForName:@"Card" inManagedObjectContext:context];
    [card setValue:@"1234567890" forKey:@"no"];
    
    // 3、Connect person and card
    [person setValue:card forKey:@"card"];
    
    // 4、Sync database
    NSError *error = nil;
    BOOL success = [context save:&error];
    if (!success) {
        [NSException raise:@"Exception when access database" format:@"%@", error.localizedDescription];
    }
}

- (void)queryFromDatabase:(NSManagedObjectContext *)context {
    // 1、Init fetch request and set the entity with Person object
    NSFetchRequest *request = [[NSFetchRequest alloc] init];
    request.entity = [NSEntityDescription  entityForName:@"Person" inManagedObjectContext:context];
    
    // 2、Set order
    NSSortDescriptor *sort = [NSSortDescriptor sortDescriptorWithKey:@"age" ascending:NO];
    request.sortDescriptors = [NSArray arrayWithObject:sort];
    
    // 3、Set predicate to filter the name contain Al (Replace % with * in SQL)
    NSPredicate *predicate = [NSPredicate predicateWithFormat:@"name like %@", @"*Al*"];
    request.predicate = predicate;
    
    // 4、Execute request
    NSError *error = nil;
    NSArray *objs = [context executeFetchRequest:request error:&error];
    if (error) {
        [NSException raise:@"Exception when query" format:@"%@", error.localizedDescription];
    }
    
    // 5、Iterate the result
    for (NSManagedObject *obj in objs) {
        NSLog(@"name=%@", [obj valueForKey:@"name"]);
        [context deleteObject:obj];
    }
    
    [context save:nil];
}

- (void)deleteOject:(NSManagedObject *)obj inContext:(NSManagedObjectContext *)context {
    [context deleteObject:obj];
    NSError *error = nil;
    [context save:&error];
    if (error) {
        [NSException raise:@"Exception when delete" format:@"%@", error.localizedDescription];
    }
}

- (void)addObjc2Database:(NSManagedObjectContext *)context {
    Person *person = [NSEntityDescription insertNewObjectForEntityForName:@"Person" inManagedObjectContext:context];
    person.name = @"GeekRRK";
    person.age = [NSNumber numberWithInt:24];
    
    Card *card = [NSEntityDescription insertNewObjectForEntityForName:@"Card" inManagedObjectContext:context];
    card.no = @"1234567890";
    person.card = card;
    
    NSError *error;
    [context save:&error];
    if (error) {
        [NSException raise:@"Exception when add objecet to database" format:@"%@", error.localizedDescription];
    }
}

@end

//
//  CoreDataViewController.m
//  CodeSnippets
//
//  Created by suorui on 1/12/16.
//  Copyright © 2016 GeekRRK. All rights reserved.
//

#import "CoreDataViewController.h"
#import <CoreData/CoreData.h>
#import "Person.h"
#import "Card.h"

@interface CoreDataViewController ()

@property (strong, nonatomic) NSManagedObjectContext *context;

@end

@implementation CoreDataViewController

- (void)viewDidLoad {
    [super viewDidLoad];
    
    [self setupContext];
    [self addDataToDatabase];
    [self addSubManagedObject];
    [self queryDataFromDatabase];
}

- (void)setupContext {
    NSManagedObjectModel *model =
    [NSManagedObjectModel mergedModelFromBundles:nil];
    NSPersistentStoreCoordinator *psc =
    [[NSPersistentStoreCoordinator alloc] initWithManagedObjectModel:model];
    
    NSString *docs = [NSSearchPathForDirectoriesInDomains(NSDocumentDirectory,
                                                          NSUserDomainMask,
                                                          YES) lastObject];
    NSURL *url = [NSURL fileURLWithPath:
                  [docs stringByAppendingPathComponent:@"person.data"]];
    NSError *error = nil;
    NSPersistentStore *store = [psc addPersistentStoreWithType:NSSQLiteStoreType
                                                 configuration:nil
                                                           URL:url
                                                       options:nil
                                                         error:&error];
    if (store == nil) {
        [NSException raise:@"Failed to add database"
                    format:@"%@", [error localizedDescription]];
    }
    
    self.context = [[NSManagedObjectContext alloc] init];
    self.context.persistentStoreCoordinator = psc;
}

- (void)addDataToDatabase {
    NSManagedObject *person =
    [NSEntityDescription insertNewObjectForEntityForName:@"Person"
                                  inManagedObjectContext:self.context];
    [person setValue:@"MJ" forKey:@"name"];
    [person setValue:[NSNumber numberWithInt:27] forKey:@"age"];
    
    NSManagedObject *card =
    [NSEntityDescription insertNewObjectForEntityForName:@"Card"
                                  inManagedObjectContext:self.context];
    [card setValue:@"4414241933432" forKey:@"no"];
    
    [person setValue:card forKey:@"card"];
    
    NSError *error = nil;
    BOOL success = [self.context save:&error];
    if (!success) {
        [NSException raise:@"Failed to access database"
                    format:@"%@", [error localizedDescription]];
    }
}

- (void)queryDataFromDatabase {
    NSFetchRequest *request = [[NSFetchRequest alloc] init];
    request.entity =
    [NSEntityDescription entityForName:@"Person"
                inManagedObjectContext:self.context];
    
    NSSortDescriptor *sort =
    [NSSortDescriptor sortDescriptorWithKey:@"age" ascending:NO];
    request.sortDescriptors = [NSArray arrayWithObject:sort];
    
    NSPredicate *predicate =
    [NSPredicate predicateWithFormat:@"name like %@", @"*Geek*"];
    request.predicate = predicate;
    
    NSError *error = nil;
    NSArray *objs = [self.context executeFetchRequest:request error:&error];
    if (error) {
        [NSException raise:@"Failed to query"
                    format:@"%@", [error localizedDescription]];
    }
    for (NSManagedObject *obj in objs) {
        NSLog(@"name=%@", [obj valueForKey:@"name"]);
        
        [self deleteData:obj];
    }
}

- (void)deleteData:(NSManagedObject *)managedObject {
    [self.context deleteObject:managedObject];
    NSError *error = nil;
    [self.context save:&error];
    if (error) {
        [NSException raise:@"Failed to delete"
                    format:@"%@", [error localizedDescription]];
    }
}

- (void)addSubManagedObject {
    Person *person =
    [NSEntityDescription insertNewObjectForEntityForName:@"Person"
                                  inManagedObjectContext:self.context];
    person.name = @"GeekRRK";
    person.age = [NSNumber numberWithInt:24];
    
    Card *card =
    [NSEntityDescription insertNewObjectForEntityForName:@"Card"
                                  inManagedObjectContext:self.context];
    card.no = @"0123456789";
    
    person.card = card;
    
    NSError *error = nil;
    BOOL success = [self.context save:&error];
    if (!success) {
        [NSException raise:@"Failed to save context"
                    format:@"%@", [error localizedDescription]];
    }
}

@end

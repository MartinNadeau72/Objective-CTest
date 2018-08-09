//
//  AppDelegate.m
//  Objective-C Test
//
//  Created by Martin Nadeau on 2018-08-09.
//  Copyright © 2018 AppPro. All rights reserved.
//

#import "AppDelegate.h"
#import "Person+CoreDataClass.h"
#import "Person+CoreDataProperties.h"

@interface AppDelegate ()
@property (nonatomic)NSManagedObjectContext *context;
@end

@implementation AppDelegate


- (BOOL)application:(UIApplication *)application didFinishLaunchingWithOptions:(NSDictionary *)launchOptions {
    self.context = self.persistentContainer.viewContext;
    //[self createData];
    //[self basicFetch];
    //[self fetchWithSort];
    //[self fetchWithFilter];
    //[self updatePersons];
    //[self deletePerson];
    return YES;
}

- (void)createData {
    Person *p1 = [[Person alloc] initWithContext:self.context];
    p1.firstName = @"Martin";
    p1.lastName = @"Nadeau";
    p1.age = 32;
    
    Person *p2 = [[Person alloc] initWithContext:self.context];
    p2.firstName = @"Geneviève";
    p2.lastName = @"Denis";
    p2.age = 40;
    
    Person *p3 = [[Person alloc] initWithContext:self.context];
    p3.firstName = @"Claude";
    p3.lastName = @"Nadeau";
    p3.age = 49;
    
    [self saveContext];
    
}

/*
 - (NSArray *)executeFetchRequest:(NSFetchRequest *)request error:(NSError * _Nullable *)error;
 */
- (void)basicFetch {
    NSFetchRequest *request = [NSFetchRequest fetchRequestWithEntityName:@"Person"];
    NSArray <Person*>* persons = [self.context executeFetchRequest:request error:nil];
    [self printResultsFromArray:persons];
}
    
- (void)fetchWithSort {
    NSFetchRequest *request = [NSFetchRequest fetchRequestWithEntityName:@"Person"];
    NSSortDescriptor *ageDescriptor = [NSSortDescriptor sortDescriptorWithKey:@"age" ascending:NO];
    request.sortDescriptors = @[ageDescriptor];
    NSArray <Person *>*results = [self.context executeFetchRequest:request error:nil];
    [self printResultsFromArray:results];
        
}

-  (NSArray <Person *>*)fetchWithFilter {
    NSFetchRequest *request = [NSFetchRequest fetchRequestWithEntityName:@"Person"];
    NSPredicate *predicate = [NSPredicate predicateWithFormat:@"age > 30"];
    request.predicate = predicate;
    NSArray <Person *>* persons = [self.context executeFetchRequest:request error:nil];
    [self printResultsFromArray:persons];
    return persons;
}

- (void)updatePersons {
    Person *martin = [self fetchWithFilter][0];
    martin.age = 48;
    [self saveContext];
}

- (void)deletePerson {
    Person *martin = [self fetchWithFilter][0];
    [self.context deleteObject:martin];
    [self saveContext];
    
}
    

- (void)printResultsFromArray:(NSArray <Person *>*)persons {
    for (Person *person in persons) {
        NSLog(@"%@ %@ is %@ years old, so oldzzzzzzzzz", person.firstName, person.lastName, @(person.age));
        
    }
}


#pragma mark - Core Data Stack

- (void)applicationWillTerminate:(UIApplication *)application {
    [self saveContext];
}


#pragma mark - Core Data stack

@synthesize persistentContainer = _persistentContainer;

- (NSPersistentContainer *)persistentContainer {
    @synchronized (self) {
        if (_persistentContainer == nil) {
            _persistentContainer = [[NSPersistentContainer alloc] initWithName:@"Objective_C_Test"];
            [_persistentContainer loadPersistentStoresWithCompletionHandler:^(NSPersistentStoreDescription *storeDescription, NSError *error) {
                if (error != nil) {
                    NSLog(@"Unresolved error %@, %@", error, error.userInfo);
                    abort();
                }
            }];
        }
    }
    
    return _persistentContainer;
}

#pragma mark - Core Data Saving support

- (void)saveContext {
    NSError *error = nil;
    if ([self.context hasChanges] && ![self.context save:&error]) {
        NSLog(@"Unresolved error %@, %@", error, error.userInfo);
        abort();
    }
}

@end

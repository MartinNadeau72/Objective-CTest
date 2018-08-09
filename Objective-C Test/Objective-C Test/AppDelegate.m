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
    [self createData];
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

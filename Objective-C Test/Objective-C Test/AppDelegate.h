//
//  AppDelegate.h
//  Objective-C Test
//
//  Created by Martin Nadeau on 2018-08-09.
//  Copyright © 2018 AppPro. All rights reserved.
//

#import <UIKit/UIKit.h>
#import <CoreData/CoreData.h>

@interface AppDelegate : UIResponder <UIApplicationDelegate>

@property (strong, nonatomic) UIWindow *window;

@property (readonly, strong) NSPersistentContainer *persistentContainer;

- (void)saveContext;


@end


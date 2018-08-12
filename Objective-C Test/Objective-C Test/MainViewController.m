//
//  MainViewController.m
//  Objective-C Test
//
//  Created by Martin Nadeau on 2018-08-11.
//  Copyright © 2018 AppPro. All rights reserved.
//

#import "MainViewController.h"
#import "Person+CoreDataClass.h"
@import CoreData;
#import "AppDelegate.h"

@interface MainViewController ()<UITableViewDataSource>

@property (weak, nonatomic) IBOutlet UITableView *tableView;
@property (nonatomic) NSArray <Person*>*persons;
@property (nonatomic) NSManagedObjectContext *context;
@property (nonatomic, weak) AppDelegate *delegate;

@end

@implementation MainViewController

- (void)viewDidLoad {
    [super viewDidLoad];
    self.delegate = (AppDelegate *)[[UIApplication sharedApplication] delegate];
    self.context = self.delegate.persistentContainer.viewContext;
    [self fetchAllPersons];
}

- (void) fetchAllPersons {
    NSFetchRequest *request = [NSFetchRequest fetchRequestWithEntityName:@"Person"];
    self.persons = [self.context executeFetchRequest:request error:nil];
    
}

- (NSInteger)tableView:(UITableView *)tableView numberOfRowsInSection:(NSInteger)section{
    return self.persons.count;
}

- (UITableViewCell *)tableView:(UITableView *)tableView cellForRowAtIndexPath:(NSIndexPath *)indexPath{
    UITableViewCell *cell = [tableView dequeueReusableCellWithIdentifier:@"Cell"];
    // data
    Person *person = self.persons[indexPath.row];
    cell.textLabel.text = person.lastName;
    cell.detailTextLabel.text = person.firstName;
    return cell;
}

@end

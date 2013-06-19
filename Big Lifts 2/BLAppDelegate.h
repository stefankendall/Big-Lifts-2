//
//  BLAppDelegate.h
//  Big Lifts 2
//
//  Created by Stefan Kendall on 05/05/13.
//  Copyright (c) 2013 Stefan Kendall. All rights reserved.
//

#import <UIKit/UIKit.h>
#import <UbiquityStoreManager/UbiquityStoreManager.h>

@interface BLAppDelegate : UIResponder <UIApplicationDelegate, UbiquityStoreManagerDelegate>

@property (strong, nonatomic) UIWindow *window;

@property (readonly, strong, nonatomic) NSManagedObjectContext *managedObjectContext;
@property (readonly, strong, nonatomic) NSManagedObjectModel *managedObjectModel;
@property (readonly, strong, nonatomic) NSPersistentStoreCoordinator *persistentStoreCoordinator;
@property (readonly, strong, nonatomic) UbiquityStoreManager *manager;

- (void)saveContext;
- (NSURL *)applicationDocumentsDirectory;

@end
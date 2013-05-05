//
//  BLAppDelegate.h
//  Big Lifts 2
//
//  Created by Stefan Kendall on 05/05/13.
//  Copyright (c) 2013 Stefan Kendall. All rights reserved.
//

#import <UIKit/UIKit.h>

@interface BLAppDelegate : UIResponder <UIApplicationDelegate>

@property (strong, nonatomic) UIWindow *window;

@property (readonly, strong, nonatomic) NSManagedObjectContext *managedObjectContext;
@property (readonly, strong, nonatomic) NSManagedObjectModel *managedObjectModel;
@property (readonly, strong, nonatomic) NSPersistentStoreCoordinator *persistentStoreCoordinator;

- (void)saveContext;
- (NSURL *)applicationDocumentsDirectory;

@end
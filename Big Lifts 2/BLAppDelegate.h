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

@property(strong, nonatomic) UIWindow *window;
@property(readonly, strong, nonatomic) UbiquityStoreManager *manager;

@property(nonatomic) UIBackgroundTaskIdentifier backgroundUpdateTask;

- (void)saveContext;

@end
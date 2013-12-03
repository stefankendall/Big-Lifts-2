#import <UIKit/UIKit.h>
#import <UbiquityStoreManager/UbiquityStoreManager.h>

#import "UIViewController+HandleReturn.h"

@interface BLAppDelegate : UIResponder <UIApplicationDelegate>

@property(strong, nonatomic) UIWindow *window;

@property(nonatomic) UIBackgroundTaskIdentifier backgroundUpdateTask;

@end
#import <UbiquityStoreManager/UbiquityStoreManager.h>

@class UbiquityStoreManager;

@interface LogMigrator : NSObject <UbiquityStoreManagerDelegate>
@property(nonatomic, strong) UbiquityStoreManager *manager;

@property(nonatomic, copy) void (^doneCallback)();

- (void)migrate:(void (^)())doneCallback;

- (void)ubiquityStoreManager:(UbiquityStoreManager *)manager willLoadStoreIsCloud:(BOOL)isCloudStore;

- (void)ubiquityStoreManager:(UbiquityStoreManager *)manager didLoadStoreForCoordinator:(NSPersistentStoreCoordinator *)coordinator isCloud:(BOOL)isCloudStore;
@end
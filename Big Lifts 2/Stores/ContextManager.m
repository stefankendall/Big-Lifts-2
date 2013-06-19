#import "ContextManager.h"

@implementation ContextManager
@synthesize context, model;

+ (ContextManager *)instance {
    static ContextManager *manager = nil;
    if (!manager) {
        manager = (ContextManager *) [[super allocWithZone:nil] init];
        manager.model = [NSManagedObjectModel mergedModelFromBundles:nil];
    }
    return manager;
}

+ (NSManagedObjectContext *)context {
    return [[self instance] context];
}

+ (NSManagedObjectModel *)model {
    return [[self instance] model];
}

- (BOOL)saveChanges {
    NSError *err = nil;
    BOOL successful = [[[ContextManager instance] context] save:&err];
    if (!successful) {
        NSLog(@"Error saving: %@", [err localizedDescription]);
    }
    return successful;
}


@end
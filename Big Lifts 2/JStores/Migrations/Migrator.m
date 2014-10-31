#import "Migrator.h"
#import "JVersionStore.h"
#import "JVersion.h"
#import "Migration.h"

@implementation Migrator

- (void)migrateStores {
    [[JVersionStore instance] load:nil];
    JVersion *version = [[JVersionStore instance] first];

    NSDictionary *migrations = @{
    };

    for (NSNumber *versionNumber in [self sortedKeys:migrations]) {
        if ([version.version intValue] < [versionNumber intValue]) {
            NSObject <Migration> *migration = migrations[versionNumber];
            [migration run];
            version.version = versionNumber;
        }
    }
}

- (NSArray *)sortedKeys:(NSDictionary *)migrations {
    return [[migrations allKeys] sortedArrayUsingSelector:@selector(compare:)];
}

@end

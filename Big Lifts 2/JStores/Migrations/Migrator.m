#import "Migrator.h"
#import "JVersionStore.h"
#import "JVersion.h"
#import "Migrate1to2.h"

@implementation Migrator

- (void)migrateStores {
    [[JVersionStore instance] load];
    JVersion *version = [[JVersionStore instance] first];

    if([version.version intValue] < 2){
        [[Migrate1to2 new] run];
        version.version = @2;
    }
}

@end
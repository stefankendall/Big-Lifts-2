#import "Migrator.h"
#import "JVersionStore.h"
#import "JVersion.h"
#import "Migrate1to2.h"
#import "Migrate2to3.h"
#import "Migrate3to4.h"

@implementation Migrator

- (void)migrateStores {
    @try {
        [[JVersionStore instance] load];
        JVersion *version = [[JVersionStore instance] first];

        //first migration must run every time, since I was missing the version property on existing installs
        if ([version.version intValue] <= 2) {
            [[Migrate1to2 new] run];
            version.version = @2;
        }
        else if ([version.version intValue] < 3) {
            [[Migrate2to3 new] run];
            version.version = @3;
        }
        else if ([version.version intValue] < 4) {
            [[Migrate3to4 new] run];
            version.version = @4;
        }
    }
    @catch (NSException *e) {
        //TODO: log with crashlytics
        //Trying to fix startup issue
    }
}

@end
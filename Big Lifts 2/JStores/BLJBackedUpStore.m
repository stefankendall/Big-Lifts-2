#import "BLJBackedUpStore.h"
#import "BLKeyValueStore.h"

@implementation BLJBackedUpStore
- (void)onLoad {
    [super onLoad];
    if ([self count] == 0) {
        [self restoreBackup];
    }
    else {
        [self createBackup];
    }
}

- (void)createBackup {
    NSArray *serialized = [self serialize];
    [[BLKeyValueStore store] setObject:serialized forKey:[self backupKeyPath]];
}

- (NSString *)backupKeyPath {
    return [NSString stringWithFormat:@"%@backup", [self keyNameForStore]];
}

- (void)restoreBackup {
    NSUbiquitousKeyValueStore *keyValueStore = [BLKeyValueStore store];
    NSArray *serializedData = [keyValueStore arrayForKey:[self backupKeyPath]];
    if (serializedData) {
        self.data = [self deserialize:serializedData];
    }
    [self buildUuidCache];
}

@end
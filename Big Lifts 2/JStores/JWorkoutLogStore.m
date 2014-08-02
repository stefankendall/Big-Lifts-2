#import "JWorkoutLogStore.h"
#import "JWorkoutLog.h"
#import "BLKeyValueStore.h"

@implementation JWorkoutLogStore

- (Class)modelClass {
    return JWorkoutLog.class;
}

- (void)setDefaultsForObject:(id)object {
    JWorkoutLog *log = object;
    log.sets = [@[] mutableCopy];
    log.deload = NO;
}

- (void)onLoad {
    NSNumber *lastCount = [self lastCount];
    if (!lastCount) {
        return;
    }

    if ([self count] != [lastCount intValue]) {
        [self restoreLog];
    }
    else {
        [self saveBackupLog];
    }
}

- (NSNumber *)lastCount {
    return [[BLKeyValueStore store] objectForKey:[self countKey]];
}

- (void)sync {
    [super sync];
    [[BLKeyValueStore store] setObject:@([self count]) forKey:[self countKey]];
}

- (NSString *)countKey {
    return [[self keyNameForStore] stringByAppendingString:@"-count"];
}

- (NSString *)backupKey {
    return [[self keyNameForStore] stringByAppendingString:@"-backup"];
}

- (void)saveBackupLog {
    NSArray *data = [self serialize];
    [[BLKeyValueStore store] setObject:data forKey:[self backupKey]];
}

- (void)restoreLog {
    [self loadDataFromKey:[self backupKey]];
}

- (NSArray *)findAll {
    NSSortDescriptor *sd = [[NSSortDescriptor alloc] initWithKey:@"date" ascending:NO];
    return [self.data sortedArrayUsingDescriptors:@[sd]];
}

- (JWorkoutLog *)createWithName:(NSString *)name date:(NSDate *)date {
    JWorkoutLog *workoutLog = [self create];
    workoutLog.name = name;
    workoutLog.date = date;
    return workoutLog;
}

@end
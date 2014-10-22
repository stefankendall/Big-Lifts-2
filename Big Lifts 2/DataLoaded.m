#import "DataLoaded.h"
#import "CrashCounter.h"

@implementation DataLoaded

+ (DataLoaded *)instance {
    static DataLoaded *dataLoaded = nil;
    static dispatch_once_t onceToken = 0;
    dispatch_once(&onceToken, ^{
        dataLoaded = [DataLoaded new];
        dataLoaded.loaded = NO;
    });
    return dataLoaded;
}

- (void)setLoaded:(BOOL)loaded {
    [CrashCounter resetCrashCounter];
    _loaded = loaded;
}

@end
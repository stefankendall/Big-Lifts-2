#import "DataLoaded.h"

@implementation DataLoaded

+ (DataLoaded *)instance {
    static DataLoaded *dataLoaded = nil;
    static dispatch_once_t onceToken = 0;
    dispatch_once(&onceToken, ^{
        dataLoaded = [DataLoaded new];
        dataLoaded.loaded = NO;
        dataLoaded.viewLoaded = NO;
    });
    return dataLoaded;
}

@end
#import "SetLogContainer.h"
#import "SetLog.h"

@implementation SetLogContainer
@synthesize setLog;

- (id)initWithSetLog:(SetLog *)setLog1 {
    self = [super init];
    if (self) {
        setLog = setLog1;
    }
    return self;
}


- (BOOL)isEqual:(id)other {
    if (other == self)
        return YES;
    if (!other || ![[other class] isEqual:[self class]])
        return NO;

    SetLogContainer *otherContainer = other;

    BOOL namesEqual = [setLog.name isEqualToString:otherContainer.setLog.name];
    BOOL repsEqual = setLog.reps == otherContainer.setLog.reps;
    BOOL weightEqual = [setLog.weight doubleValue] == [otherContainer.setLog.weight doubleValue];

    return namesEqual && repsEqual && weightEqual;
}


@end
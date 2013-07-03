#import "SetLogContainer.h"
#import "SetLog.h"

@implementation SetLogContainer

- (id)initWithSetLog:(SetLog *)setLog1 {
    self = [super init];
    if (self) {
        self.setLog = setLog1;
    }
    return self;
}


- (BOOL)isEqual:(id)other {
    if (other == self)
        return YES;
    if (!other || ![[other class] isEqual:[self class]])
        return NO;

    SetLogContainer *otherContainer = other;

    BOOL namesEqual = [self.setLog.name isEqualToString:otherContainer.setLog.name];
    BOOL repsEqual = self.setLog.reps == otherContainer.setLog.reps;
    BOOL weightEqual = [self.setLog.weight doubleValue] == [otherContainer.setLog.weight doubleValue];

    return namesEqual && repsEqual && weightEqual;
}


@end
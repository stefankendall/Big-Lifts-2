#import "SetLogContainer.h"
#import "JSetLog.h"

@implementation SetLogContainer

- (id)initWithSetLog:(JSetLog *)setLog1 {
    self = [super init];
    if (self) {
        self.setLog = setLog1;
        self.count = 1;
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
    BOOL repsEqual = [self.setLog.reps isEqualToNumber:otherContainer.setLog.reps];
    BOOL weightEqual = [self.setLog.weight isEqual:otherContainer.setLog.weight];

    return namesEqual && repsEqual && weightEqual;
}


@end
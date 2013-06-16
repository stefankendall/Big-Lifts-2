#import "SenTestCase+ControllerTestAdditions.h"

@implementation SenTestCase (AsyncTest)

BOOL _done;

- (void)setDone:(BOOL)done {
    _done = done;
}

- (BOOL)done {
    return _done;
}

- (BOOL)waitForCompletion:(NSTimeInterval)timeoutSecs {
    NSDate *timeoutDate = [NSDate dateWithTimeIntervalSinceNow:timeoutSecs];
    do {
        [[NSRunLoop currentRunLoop] runMode:NSDefaultRunLoopMode beforeDate:timeoutDate];
        if ([timeoutDate timeIntervalSinceNow] < 0.0)
            break;
    } while (!self.done);
    return self.done;
}

@end
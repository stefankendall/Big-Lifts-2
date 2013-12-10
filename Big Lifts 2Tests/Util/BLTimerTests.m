#import "BLTimerTests.h"
#import "BLTimer.h"

@implementation BLTimerTests

- (void)testFormatsTime {
    [[BLTimer instance] setSecondsRemaining:120];
    STAssertEqualObjects([[BLTimer instance] formattedTimeRemaining], @"2:00", @"");

    [[BLTimer instance] setSecondsRemaining:135];
    STAssertEqualObjects([[BLTimer instance] formattedTimeRemaining], @"2:15", @"");

    [[BLTimer instance] setSecondsRemaining:0];
    STAssertEqualObjects([[BLTimer instance] formattedTimeRemaining], @"0:00", @"");

    [[BLTimer instance] setSecondsRemaining:1];
    STAssertEqualObjects([[BLTimer instance] formattedTimeRemaining], @"0:01", @"");
}

- (void)testCanSuspendAndResume {
    [[BLTimer instance] start:135];
    [[BLTimer instance] suspend];
    [[BLTimer instance] resume];

    STAssertEquals([[BLTimer instance] secondsRemaining], 135, @"");

}

@end
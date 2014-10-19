#import "CrashCounterTests.h"
#import "CrashCounter.h"

@implementation CrashCounterTests

- (void)testCanIncrementCounter {
    [CrashCounter incrementCrashCounter];
    STAssertEquals([CrashCounter crashCount], 1, @"");
    [CrashCounter incrementCrashCounter];
    STAssertEquals([CrashCounter crashCount], 2, @"");
    [CrashCounter resetCrashCounter];
    STAssertEquals([CrashCounter crashCount], 0, @"");
}

- (void)testReturns0BeforeIncremented {
    STAssertEquals([CrashCounter crashCount], 0, @"");
}

@end
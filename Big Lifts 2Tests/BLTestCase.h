#import <SenTestingKit/SenTestingKit.h>

@interface BLTestCase : SenTestCase

@property(nonatomic) BOOL done;

- (BOOL)waitForCompletion:(NSTimeInterval)timeoutSecs;

@end
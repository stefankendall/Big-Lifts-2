#import <SenTestingKit/SenTestingKit.h>

@interface SenTestCase (AsyncTest)
- (BOOL)waitForCompletion:(NSTimeInterval)timeoutSecs;

@property(nonatomic) BOOL done;
@end
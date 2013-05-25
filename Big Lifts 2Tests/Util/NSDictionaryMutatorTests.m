#import "NSDictionaryMutatorTests.h"
#import "NSDictionaryMutator.h"

@implementation NSDictionaryMutatorTests

- (void)testInvertsDictionaries {
    NSDictionary *dictionary = @{@"a" : @1, @"b" : @2};
    NSDictionary *inverted = [[NSDictionaryMutator new] invert:dictionary];
    STAssertEquals([inverted count], (NSUInteger) 2, @"");
    STAssertTrue([[inverted objectForKey:@1] isEqualToString:@"a"], @"");
}

@end
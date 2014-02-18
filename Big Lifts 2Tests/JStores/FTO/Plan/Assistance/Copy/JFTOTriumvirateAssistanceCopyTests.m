#import "JFTOTriumvirateAssistanceCopyTests.h"
#import "JFTOTriumvirateAssistanceCopy.h"
#import "JFTOCustomAssistanceLiftStore.h"

@implementation JFTOTriumvirateAssistanceCopyTests

-(void) testCopiesTriumvirateIntoCustom {
    [[JFTOTriumvirateAssistanceCopy new] copyTemplate];
    STAssertEquals([[JFTOCustomAssistanceLiftStore instance] count], 8, @"");
}

@end
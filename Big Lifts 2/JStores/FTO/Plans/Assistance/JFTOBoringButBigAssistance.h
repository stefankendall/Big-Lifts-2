#import "JFTOAssistanceProtocol.h"

@class JFTOLift;

@interface JFTOBoringButBigAssistance : NSObject <JFTOAssistanceProtocol>

- (void)setup;

- (NSArray *)createBoringSets:(int)numberOfSets forLift:(JFTOLift *)mainLift;

@end
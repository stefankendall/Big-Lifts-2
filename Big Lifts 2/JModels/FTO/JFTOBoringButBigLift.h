#import "JModel.h"

@class JLift;
@class JFTOLift;

@interface JFTOBoringButBigLift : JModel

@property(nonatomic, strong) JFTOLift *mainLift;
@property(nonatomic, strong) JFTOLift *boringLift;
@end
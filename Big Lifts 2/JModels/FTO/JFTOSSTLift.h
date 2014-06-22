#import "JModel.h"
#import "JLift.h"

@class JFTOLift;

@interface JFTOSSTLift : JLift
@property(nonatomic) JFTOLift<Optional> *associatedLift;
@end
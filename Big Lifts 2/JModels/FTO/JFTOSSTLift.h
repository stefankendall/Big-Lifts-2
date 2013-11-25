#import "JSONModel/JSONModel.h"
#import "Lift.h"
#import "JLift.h"

@class JFTOLift;

@interface JFTOSSTLift : JLift
@property(nonatomic) JFTOLift *associatedLift;
@end
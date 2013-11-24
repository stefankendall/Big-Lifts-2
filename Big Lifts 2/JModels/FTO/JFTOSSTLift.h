#import "JSONModel/JSONModel.h"
#import "Lift.h"

@class JFTOLift;

@interface JFTOSSTLift : Lift
@property(nonatomic) JFTOLift *associatedLift;
@end
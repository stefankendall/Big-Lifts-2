#import "Lift.h"
#import "FTOLift.h"

@interface FTOSSTLift : Lift
@property(nonatomic) FTOLift *associatedLift;
@end
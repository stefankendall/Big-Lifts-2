#import "JSONModel/JSONModel.h"

@class JSet;
@class JLift;
@class JWorkout;

@interface JFTOTriumvirate : JSONModel
@property(nonatomic) JWorkout *workout;
@property(nonatomic) JLift *mainLift;

- (int)countMatchingSets:(JSet *)set;

- (NSArray *)matchingSets:(JSet *)set;
@end
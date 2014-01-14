#import "JModel.h"

@class JSet;
@class JLift;
@class JWorkout;

@interface JFTOTriumvirate : JModel
@property(nonatomic) JWorkout <Optional> *workout;
@property(nonatomic) JLift <Optional> *mainLift;

- (int)countMatchingSets:(JSet *)set;

- (NSArray *)matchingSets:(JSet *)set;
@end
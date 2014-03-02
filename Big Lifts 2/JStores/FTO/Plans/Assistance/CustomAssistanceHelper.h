@class JFTOWorkout;
@class JWorkout;

@interface CustomAssistanceHelper : NSObject
+ (void)addAssistanceToWorkout:(JFTOWorkout *)ftoWorkout withAssistance:(JWorkout *)assistanceWorkout;
@end
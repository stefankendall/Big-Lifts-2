#import <JSONModel/JSONModel.h>

@class WorkoutLog;

@interface JSetLog : JSONModel

@property(nonatomic) NSNumber *reps;
@property(nonatomic) NSDecimalNumber *weight;
@property(nonatomic) NSString *name;
@property(nonatomic) NSNumber *order;
@property(nonatomic) BOOL warmup;
@property(nonatomic) BOOL assistance;
@property(nonatomic) BOOL amrap;

@property(nonatomic) WorkoutLog *workoutLog;

@end
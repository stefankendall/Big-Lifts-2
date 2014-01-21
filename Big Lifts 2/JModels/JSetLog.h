#import "JModel.h"

@interface JSetLog : JModel

@property(nonatomic) NSNumber<Optional> *reps;
@property(nonatomic) NSDecimalNumber<Optional> *weight;
@property(nonatomic) NSString<Optional> *name;
@property(nonatomic) BOOL warmup;
@property(nonatomic) BOOL assistance;
@property(nonatomic) BOOL amrap;

@end
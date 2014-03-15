#import "JModel.h"

@interface JFTOFullCustomWeek : JModel

@property(nonatomic) NSString *name;
@property(nonatomic) BOOL incrementAfterWeek;
@property(nonatomic) NSNumber *week;
@property(nonatomic) NSMutableArray *workouts;

@end
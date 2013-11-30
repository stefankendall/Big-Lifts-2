#import "JModel.h"

@interface JFTOSettings : JModel

@property(nonatomic) NSDecimalNumber *trainingMax;
@property(nonatomic) BOOL warmupEnabled;
@property(nonatomic) NSNumber *logState;
@property(nonatomic) NSNumber *repsToBeatConfig;

@end
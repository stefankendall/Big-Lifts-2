#import "JSONModel/JSONModel.h"

@interface JFTOSettings : JSONModel

@property(nonatomic) NSDecimalNumber *trainingMax;
@property(nonatomic) BOOL warmupEnabled;
@property(nonatomic) NSNumber *logState;
@property(nonatomic) NSNumber *repsToBeatConfig;

@end
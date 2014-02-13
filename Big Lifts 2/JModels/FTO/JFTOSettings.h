#import "JModel.h"

typedef enum {
    kShowAll = 2,
    kShowWorkSets = 0,
    kShowAmrap = 1
} ShowState;

typedef enum {
    kNewest = 0,
    kAlphabetical = 1
} TrackSort;

typedef enum {
    kRepsToBeatEverything = 0,
    kRepsToBeatLogOnly = 1
} RepsToBeatConfig;

@interface JFTOSettings : JModel

@property(nonatomic) NSDecimalNumber<Optional> *trainingMax;
@property(nonatomic) BOOL warmupEnabled;
@property(nonatomic) BOOL sixWeekEnabled;
@property(nonatomic) NSNumber *logState;
@property(nonatomic) NSNumber *repsToBeatConfig;

@end
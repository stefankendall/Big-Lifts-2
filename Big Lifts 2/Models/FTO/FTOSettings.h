typedef enum {
    kShowAll = 2,
    kShowWorkSets = 0,
    kShowAmrap = 1
} ShowState;

typedef enum {
    kNewest = 0,
    kAlphabetical = 1
} TrackSort;

@interface FTOSettings : NSManagedObject
@property(nonatomic) NSDecimalNumber *trainingMax;
@property(nonatomic) BOOL warmupEnabled;
@property(nonatomic) NSNumber *logState;
@end
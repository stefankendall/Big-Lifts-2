typedef enum {
    kShowAll = 2,
    kShowWorkSets = 0,
    kShowAmrap = 1
} ShowState;

@interface FTOSettings : NSManagedObject
@property(nonatomic) NSDecimalNumber *trainingMax;
@property(nonatomic) BOOL warmupEnabled;
@property(nonatomic) NSNumber *logState;
@end
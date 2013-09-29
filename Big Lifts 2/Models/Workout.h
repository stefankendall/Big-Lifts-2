@class Set;

@interface Workout : NSManagedObject
@property(nonatomic) NSMutableOrderedSet *sets;

- (NSArray *)workSets;

- (NSArray *)warmupSets;

- (void)addSet:(Set *)set;

@end
@class Set;

@interface Workout : NSManagedObject
@property(nonatomic) NSMutableOrderedSet *sets;

- (NSArray *)workSets;

- (NSArray *)warmupSets;

- (NSArray *)assistanceSets;

- (void)addSet:(Set *)set;

@end
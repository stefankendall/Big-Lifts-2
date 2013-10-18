@class Set;
@class Lift;

@interface Workout : NSManagedObject
@property(nonatomic) NSMutableOrderedSet *sets;

- (NSArray *)workSets;

- (NSArray *)warmupSets;

- (NSArray *)assistanceSets;

- (void)addSet:(Set *)set;

- (void)addSets:(NSArray *)newSets;

- (Lift *)firstLift;
@end
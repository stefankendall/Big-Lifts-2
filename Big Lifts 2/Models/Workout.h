@class Set;
@class Lift;

@interface Workout : NSManagedObject
@property(nonatomic) NSMutableOrderedSet *sets;

- (NSArray *)workSets;

- (NSArray *)warmupSets;

- (NSArray *)assistanceSets;

- (void)addSet:(Set *)set;

- (void)addSets:(NSArray *)newSets;

- (NSArray *) orderedSets;

- (Lift *)firstLift;

- (void)removeSet:(Set *)set;

- (void)removeSets:(NSArray *)sets;

- (void)addSets:(NSArray *)array atIndex:(int)index;
@end
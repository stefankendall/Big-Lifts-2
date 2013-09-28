@class Set;

@interface Workout : NSManagedObject
@property(nonatomic) NSMutableOrderedSet *sets;

- (NSArray *)workSets;

- (void)addSet:(Set *)set;

@end
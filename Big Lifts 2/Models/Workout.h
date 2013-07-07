@interface Workout : NSManagedObject
@property(nonatomic) NSMutableOrderedSet *sets;

-(NSArray *) workSets;

@end
#import "JModel.h"

@class JLift;
@class JSet;

@interface JWorkout : JModel
@property(nonatomic) NSMutableArray *sets;

- (NSArray *)workSets;

- (NSArray *)warmupSets;

- (NSArray *)assistanceSets;

- (void)addSet:(JSet *)set;

- (void)addSets:(NSArray *)newSets;

- (NSArray *) orderedSets;

- (JLift *)firstLift;

- (void)removeSet:(JSet *)set;

- (void)removeSets:(NSArray *)sets;

- (void)addSets:(NSArray *)array atIndex:(int)index;
@end
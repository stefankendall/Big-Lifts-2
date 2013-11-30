#import "JModel.h"

@class JLift;
@class JSet;

@protocol JSet;

@interface JWorkout : JModel
@property(nonatomic) NSMutableArray<JSet> *sets;

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
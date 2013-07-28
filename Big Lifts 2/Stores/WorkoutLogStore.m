#import "WorkoutLogStore.h"

@implementation WorkoutLogStore

- (NSArray *)findAll {
    NSSortDescriptor *sd = [[NSSortDescriptor alloc] initWithKey:@"date" ascending:NO];
    return [super findAllWithSort:sd];
}

@end
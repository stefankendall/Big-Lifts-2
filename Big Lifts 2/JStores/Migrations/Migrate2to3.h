#import "Migration.h"

@interface Migrate2to3 : NSObject<Migration>
- (NSArray *)findOrphanedWorkouts;
@end
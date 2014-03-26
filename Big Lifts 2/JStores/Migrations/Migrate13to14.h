#import "Migration.h"

@interface Migrate13to14 : NSObject<Migration>
- (void)removeNilWeightAndRepsFromLog;
@end
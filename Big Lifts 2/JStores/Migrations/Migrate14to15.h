#import "Migration.h"

@interface Migrate14to15 : NSObject<Migration>
- (NSArray *)getAllUuids;
@end
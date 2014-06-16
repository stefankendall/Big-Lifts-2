#import "BLJStore.h"

@interface JPlateStore : BLJStore
- (void)createPlateWithWeight:(NSDecimalNumber *)weight count:(int)count;

- (void)adjustForKg;
@end
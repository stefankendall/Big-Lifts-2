#import "BLJStore.h"

@class JLift;

@interface JLiftStore : BLJStore

@property(nonatomic) BOOL isSettingDefaults;

- (void)copy:(JLift *)source into:(JLift *)dest;

- (void)incrementLifts;

- (void)liftsChanged;

@end
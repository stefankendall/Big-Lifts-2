#import "BLJStore.h"
#import "JLiftStore.h"

@interface JFTOLiftStore : JLiftStore
@property(nonatomic) BOOL isSettingDefaults;

- (void)incrementLifts;

- (void)adjustForKg;
@end
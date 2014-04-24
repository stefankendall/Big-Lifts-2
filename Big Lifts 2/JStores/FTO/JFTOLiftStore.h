#import "BLJStore.h"
#import "JLiftStore.h"

@interface JFTOLiftStore : JLiftStore
@property(nonatomic) BOOL isSettingDefaults;

- (void)adjustForKg;
@end
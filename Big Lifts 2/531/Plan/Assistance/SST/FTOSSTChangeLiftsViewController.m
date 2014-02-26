#import <FlurrySDK/Flurry.h>
#import "FTOSSTChangeLiftsViewController.h"
#import "JLift.h"
#import "JFTOSSTLiftStore.h"

@implementation FTOSSTChangeLiftsViewController

- (void)viewWillAppear:(BOOL)animated {
    [super viewWillAppear:animated];
    [Flurry logEvent:@"5/3/1_SST"];
}

- (NSInteger)numberOfSectionsInTableView:(UITableView *)tableView {
    return 1;
}

- (NSInteger)tableView:(UITableView *)tableView numberOfRowsInSection:(NSInteger)section {
    return [[JFTOSSTLiftStore instance] count];
}

- (void)tableView:(UITableView *)tableView commitEditingStyle:(UITableViewCellEditingStyle)editingStyle forRowAtIndexPath:(NSIndexPath *)indexPath {
}

- (JLift *)liftAtIndex:(int)index {
    return [[JFTOSSTLiftStore instance] atIndex:index];
}

@end
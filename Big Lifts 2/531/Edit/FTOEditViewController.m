#import "FTOEditViewController.h"
#import "FTOLiftStore.h"

@implementation FTOEditViewController

- (NSInteger)tableView:(UITableView *)tableView numberOfRowsInSection:(NSInteger)section {
    return [[FTOLiftStore instance] count];
}

@end
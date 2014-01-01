#import "SVEditViewController.h"
#import "JSVLiftStore.h"

@implementation SVEditViewController

- (NSInteger)tableView:(UITableView *)tableView numberOfRowsInSection:(NSInteger)section {
    return [[JSVLiftStore instance] count];
}

@end
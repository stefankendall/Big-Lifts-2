#import "SSChangeLiftsViewController.h"
#import "JSSLiftStore.h"
#import "SSChangeLiftCell.h"
#import "TextViewInputAccessoryBuilder.h"
#import "JSSLift.h"

@implementation SSChangeLiftsViewController

- (NSInteger)tableView:(UITableView *)tableView numberOfRowsInSection:(NSInteger)section {
    return [[JSSLiftStore instance] count];
}

- (UITableViewCell *)tableView:(UITableView *)tableView cellForRowAtIndexPath:(NSIndexPath *)indexPath {
    SSChangeLiftCell *cell = [tableView dequeueReusableCellWithIdentifier:NSStringFromClass(SSChangeLiftCell.class)];
    if (!cell) {
        cell = [SSChangeLiftCell create];
    }
    [[TextViewInputAccessoryBuilder new] doneButtonAccessory:cell.liftField];
    [cell.liftField setDelegate:self];
    JSSLift *lift = [[JSSLiftStore instance] atIndex:indexPath.row];
    [cell.liftField setText:[lift effectiveName]];
    return cell;
}

@end
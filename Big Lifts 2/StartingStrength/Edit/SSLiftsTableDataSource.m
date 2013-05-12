#import "SSLiftsTableDataSource.h"
#import "SSLiftStore.h"
#import "SSLift.h"

@implementation SSLiftsTableDataSource

- (NSInteger)tableView:(UITableView *)tableView numberOfRowsInSection:(NSInteger)section {
    return [[SSLiftStore instance] count];
}

- (UITableViewCell *)tableView:(UITableView *)tableView cellForRowAtIndexPath:(NSIndexPath *)indexPath {
    UITableViewCell *cell = [tableView dequeueReusableCellWithIdentifier:@"SSLiftsCell"];
    if (cell == nil) {
        cell = [[UITableViewCell alloc] initWithStyle:UITableViewCellStyleDefault reuseIdentifier:@"SSLiftsCell"];
        [[cell textLabel] setAdjustsFontSizeToFitWidth:YES];
    }

    SSLift *lift = ([[SSLiftStore instance] findAll])[(NSUInteger) indexPath.row];
    [[cell textLabel] setText:lift.name];

    return cell;
}

- (NSString *)tableView:(UITableView *)tableView titleForHeaderInSection:(NSInteger)section {
    return @"Lifts";
}


@end
#import "SSStartingWeightTableDataSource.h"
#import "TextViewCell.h"
#import "SSLiftStore.h"

@implementation SSStartingWeightTableDataSource

- (NSInteger)tableView:(UITableView *)tableView numberOfRowsInSection:(NSInteger)section {
    return [[SSLiftStore instance] count];
}

- (UITableViewCell *)tableView:(UITableView *)tableView cellForRowAtIndexPath:(NSIndexPath *)indexPath {
    TextViewCell *cell = [tableView dequeueReusableCellWithIdentifier:@"TextViewCell"];
    [cell setBackgroundColor:[UIColor whiteColor]];
    return cell;
}

- (NSString *)tableView:(UITableView *)tableView titleForHeaderInSection:(NSInteger)section {
    return @"Weight";
}


@end
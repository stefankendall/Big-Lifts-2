#import "SSStartingWeightTableDataSource.h"
#import "TextViewCell.h"
#import "SSLiftStore.h"
#import "SSLift.h"
#import "TextViewWithCell.h"

@implementation SSStartingWeightTableDataSource

- (NSInteger)tableView:(UITableView *)tableView numberOfRowsInSection:(NSInteger)section {
    return [[SSLiftStore instance] count];
}

- (UITableViewCell *)tableView:(UITableView *)tableView cellForRowAtIndexPath:(NSIndexPath *)indexPath {
    TextViewCell *cell = (TextViewCell *) [tableView dequeueReusableCellWithIdentifier:@"TextViewCell"];

    if (cell == nil) {
        cell = [TextViewCell createNewTextCellFromNib];
    }

    [cell setIndexPath:indexPath];

    [[cell textView] setDelegate:self];

    [cell setBackgroundColor:[UIColor whiteColor]];

    SSLift *lift = [[SSLiftStore instance] atIndex:[indexPath row]];
    [[cell textView] setText:[lift.weight stringValue]];

    return cell;
}

- (NSString *)tableView:(UITableView *)tableView titleForHeaderInSection:(NSInteger)section {
    return @"Weight";
}

- (void)textViewDidEndEditing:(UITextView *)textView {
    NSString *weight = [textView text];
    TextViewWithCell *textViewWithCell = (TextViewWithCell *) textView;
    NSInteger index = [[[textViewWithCell cell] indexPath] row];

    SSLift *lift = [[SSLiftStore instance] findAll][(NSUInteger) index];
    [lift setWeight:[NSNumber numberWithDouble:[weight doubleValue]]];
}

@end
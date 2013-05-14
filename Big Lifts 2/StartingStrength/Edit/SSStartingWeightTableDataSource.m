#import "SSStartingWeightTableDataSource.h"
#import "TextViewCell.h"
#import "SSLiftStore.h"
#import "SSLift.h"

@implementation SSStartingWeightTableDataSource
@synthesize tableView;

- (NSInteger)tableView:(UITableView *)tableView numberOfRowsInSection:(NSInteger)section {
    return [[SSLiftStore instance] count];
}

- (UITableViewCell *)tableView:(UITableView *)tableView cellForRowAtIndexPath:(NSIndexPath *)indexPath {
    TextViewCell *cell = (TextViewCell *) [tableView dequeueReusableCellWithIdentifier:kCellTextView_ID];

    if (cell == nil) {
        cell = [TextViewCell createNewTextCellFromNib];
    }

    [[cell textView] setDelegate:self];
    [cell setBackgroundColor:[UIColor whiteColor]];
    return cell;
}

- (void)textViewDidEndEditing:(UITextView *)textView {
    NSString *weight = [textView text];
    int index = [self findIndexInTableView:[self tableView] textView:textView];
    SSLift *lift = [[SSLiftStore instance] findAll][(NSUInteger) index];
    [lift setWeight:[NSNumber numberWithDouble:[weight doubleValue]]];
}

- (int)findIndexInTableView:(UITableView *)tableView textView:(UITextView *)textView {
    for (int i = 0; i < [tableView numberOfRowsInSection:0]; i++) {
        TextViewCell *cell = (TextViewCell *) [tableView cellForRowAtIndexPath:[NSIndexPath indexPathForRow:i inSection:0]];
        if( cell == nil ){
            [NSException raise:@"Exception" format:@"Cell is nil in tableView"];
        }

        if ([cell textView] == textView) {
            return i;
        }
    }
    return -1;
}

- (NSString *)tableView:(UITableView *)tableView titleForHeaderInSection:(NSInteger)section {
    return @"Weight";
}


@end
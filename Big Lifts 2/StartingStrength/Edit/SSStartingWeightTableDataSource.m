#import "SSStartingWeightTableDataSource.h"
#import "TextViewCell.h"
#import "SSLiftStore.h"
#import "SSLift.h"

@implementation SSStartingWeightTableDataSource
@synthesize cellMapping;

- (id)init {
    self = [super init];
    if (self) {
        cellMapping = [@{} mutableCopy];
    }

    return self;
}


- (NSInteger)tableView:(UITableView *)tableView numberOfRowsInSection:(NSInteger)section {
    return [[SSLiftStore instance] count];
}

- (UITableViewCell *)tableView:(UITableView *)tableView cellForRowAtIndexPath:(NSIndexPath *)indexPath {
    TextViewCell *cell = (TextViewCell *) [tableView dequeueReusableCellWithIdentifier:kCellTextView_ID];

    if (cell == nil) {
        cell = [TextViewCell createNewTextCellFromNib];
        [cellMapping setObject:[NSNumber numberWithInteger:[indexPath row]] forKey:[cell textView]];
    }

    [[cell textView] setDelegate:self];

    [cell setBackgroundColor:[UIColor whiteColor]];

    SSLift * lift = [[SSLiftStore instance] atIndex:[indexPath row]];
    [[cell textView] setText:[lift.weight stringValue]];

    return cell;
}

- (NSString *)tableView:(UITableView *)tableView titleForHeaderInSection:(NSInteger)section {
    return @"Weight";
}

- (void)textViewDidEndEditing:(UITextView *)textView {
    NSString *weight = [textView text];
    NSNumber *index = [cellMapping objectForKey:textView];
    SSLift *lift = [[SSLiftStore instance] findAll][(NSUInteger) [index intValue]];
    [lift setWeight:[NSNumber numberWithDouble:[weight doubleValue]]];
}

@end
#import "SSLiftSummaryDataSource.h"
#import "SSWorkout.h"
#import "SSLiftSummaryCell.h"

@implementation SSLiftSummaryDataSource
@synthesize ssWorkout;

- (id)initWithSsWorkout:(SSWorkout *)ssWorkout1 {
    self = [super init];
    if (self) {
        ssWorkout = ssWorkout1;
    }
    return self;
}

- (NSInteger)tableView:(UITableView *)tableView numberOfRowsInSection:(NSInteger)section {
    return [[ssWorkout workouts] count];
}

- (UITableViewCell *)tableView:(UITableView *)tableView cellForRowAtIndexPath:(NSIndexPath *)indexPath {
    SSLiftSummaryCell *cell = (SSLiftSummaryCell *) [tableView dequeueReusableCellWithIdentifier:@"SSLiftSummaryCell"];

    if (cell == nil) {
        cell = [SSLiftSummaryCell create];
    }

    [cell setWorkout:ssWorkout.workouts[(NSUInteger) [indexPath row]]];
    return cell;
}

@end
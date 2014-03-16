#import "FTOFullCustomWeekViewController.h"
#import "JFTOFullCustomWeek.h"
#import "JFTOFullCustomWeekStore.h"

@implementation FTOFullCustomWeekViewController

- (NSInteger)numberOfSectionsInTableView:(UITableView *)tableView {
    return [[JFTOFullCustomWeekStore instance] count];
}

- (NSInteger)tableView:(UITableView *)tableView numberOfRowsInSection:(NSInteger)section {
    return [[[[JFTOFullCustomWeekStore instance] atIndex:section] workouts] count];
}

- (UITableViewCell *)tableView:(UITableView *)tableView cellForRowAtIndexPath:(NSIndexPath *)indexPath {
    return nil;
}

- (NSString *)tableView:(UITableView *)tableView titleForHeaderInSection:(NSInteger)section {
    return [[[JFTOFullCustomWeekStore instance] atIndex:section] name];
}

@end
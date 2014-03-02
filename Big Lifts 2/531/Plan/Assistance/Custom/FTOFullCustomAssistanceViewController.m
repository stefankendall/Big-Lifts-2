#import <FlurrySDK/Flurry.h>
#import "FTOFullCustomAssistanceViewController.h"
#import "JFTOAssistance.h"
#import "JFTOAssistanceStore.h"
#import "FTOCustomAssistanceWorkoutViewController.h"
#import "JWorkout.h"
#import "JFTOFullCustomAssistanceWorkout.h"
#import "FTOCustomToolbar.h"
#import "JFTOWorkoutStore.h"
#import "FTOSectionTitleHelper.h"
#import "JFTOLiftStore.h"
#import "JFTOLift.h"
#import "NSArray+Enumerable.h"
#import "JFTOFullCustomAssistanceWorkoutStore.h"
#import "FTOAssistanceCopyTemplateViewController.h"

@implementation FTOFullCustomAssistanceViewController

- (void)viewWillAppear:(BOOL)animated {
    [super viewWillAppear:animated];
    [Flurry logEvent:@"5/3/1_Full_Custom_Assistance"];
}

- (NSString *)tableView:(UITableView *)tableView titleForHeaderInSection:(NSInteger)section {
    if (section == 0) {
        return @"";
    }

    return [[FTOSectionTitleHelper new] titleForSection:section - 1];
}

- (NSInteger)numberOfSectionsInTableView:(UITableView *)tableView {
    return 1 + [[[JFTOWorkoutStore instance] unique:@"week"] count];
}

- (NSInteger)tableView:(UITableView *)tableView numberOfRowsInSection:(NSInteger)section {
    if (section == 0) {
        return 1;
    }
    else {
        return [[JFTOLiftStore instance] count];
    }
}

- (UITableViewCell *)tableView:(UITableView *)tableView cellForRowAtIndexPath:(NSIndexPath *)indexPath {
    if (indexPath.section == 0) {
        FTOCustomToolbar *toolbar = [tableView dequeueReusableCellWithIdentifier:NSStringFromClass(FTOCustomToolbar.class)];
        if (!toolbar) {
            toolbar = [FTOCustomToolbar create];
        }
        [toolbar.templateButton addTarget:self action:@selector(copyTemplate) forControlEvents:UIControlEventTouchUpInside];
        return toolbar;
    }
    else {
        UITableViewCell *cell = [tableView dequeueReusableCellWithIdentifier:@"FTOFullCustomCell"];
        if (!cell) {
            cell = [[UITableViewCell alloc] initWithStyle:UITableViewCellStyleDefault reuseIdentifier:@"FTOFullCustomCell"];
        }
        JFTOLift *lift = [[JFTOLiftStore instance] atIndex:indexPath.row];
        [cell.textLabel setText:lift.name];
        [cell setAccessoryType:UITableViewCellAccessoryDisclosureIndicator];

        return cell;
    }
}

- (void)copyTemplate {
    [self performSegueWithIdentifier:@"ftoCustomAssistanceCopyTemplate" sender:self];
}

- (void)copyAssistance:(NSString *)variant {
    [[JFTOFullCustomAssistanceWorkoutStore instance] copyTemplate:variant];
}

- (void)tableView:(UITableView *)tableView didSelectRowAtIndexPath:(NSIndexPath *)indexPath {
    JFTOFullCustomAssistanceWorkout *customAssistanceWorkout = [self customAssistanceWorkoutForIndexPath:indexPath];
    self.tappedWorkout = customAssistanceWorkout.workout;
    [self performSegueWithIdentifier:@"ftoSetupCustomAsstWorkout" sender:self];
}

- (JFTOFullCustomAssistanceWorkout *)customAssistanceWorkoutForIndexPath:(NSIndexPath *)indexPath {
    JFTOLift *lift = [[JFTOLiftStore instance] atIndex:indexPath.row];
    NSNumber *week = [NSNumber numberWithInt:indexPath.section];
    JFTOFullCustomAssistanceWorkout *customAssistanceWorkout = [[[JFTOFullCustomAssistanceWorkoutStore instance] findAll] detect:^BOOL(JFTOFullCustomAssistanceWorkout *customAssistanceWorkout) {
        return customAssistanceWorkout.mainLift == lift && [customAssistanceWorkout.week isEqualToNumber:week];
    }];
    return customAssistanceWorkout;
}

- (void)prepareForSegue:(UIStoryboardSegue *)segue sender:(id)sender {
    if ([[segue identifier] isEqualToString:@"ftoSetupCustomAsstWorkout"]) {
        FTOCustomAssistanceWorkoutViewController *controller = [segue destinationViewController];
        controller.workout = self.tappedWorkout;
    }
    else if ([[segue identifier] isEqualToString:@"ftoCustomAssistanceCopyTemplate"]) {
        FTOAssistanceCopyTemplateViewController *controller = [segue destinationViewController];
        controller.delegate = self;
    }
}

- (void)viewWillDisappear:(BOOL)animated {
    [[JFTOAssistanceStore instance] changeTo:FTO_ASSISTANCE_FULL_CUSTOM];
}

@end
#import <ViewDeck/IIViewDeckController.h>
#import "SVWorkoutViewController.h"
#import "JSVWorkout.h"
#import "JWorkout.h"
#import "SetCell.h"
#import "IAPAdapter.h"
#import "Purchaser.h"
#import "SetCellWithPlates.h"
#import "SVOneRepTestCell.h"
#import "PaddingTextField.h"
#import "JSVLiftStore.h"
#import "JSVLift.h"
#import "TextViewInputAccessoryBuilder.h"
#import "JWorkoutLogStore.h"
#import "JWorkoutLog.h"
#import "JSetLog.h"
#import "JSetLogStore.h"
#import "JSet.h"

@implementation SVWorkoutViewController

- (void)viewWillAppear:(BOOL)animated {
    [super viewWillAppear:animated];
    if (self.svWorkout.done) {
        [self.doneButton setTitle:@"Not Done"];
    }
    else {
        [self.doneButton setTitle:@"Done"];
    }
}

- (NSInteger)numberOfSectionsInTableView:(UITableView *)tableView {
    return 2;
}

- (NSInteger)tableView:(UITableView *)tableView numberOfRowsInSection:(NSInteger)section {
    if (section == 0) {
        return 1;
    }
    else {
        if (self.svWorkout.testMax) {
            return 1;
        }
        else {
            return [self.svWorkout.workout.sets count];
        }
    }
}

- (UITableViewCell *)tableView:(UITableView *)tableView cellForRowAtIndexPath:(NSIndexPath *)indexPath {
    if (indexPath.section == 0) {
        return [self restToolbar:tableView];
    }

    if (self.svWorkout.testMax) {
        SVOneRepTestCell *cell = [tableView dequeueReusableCellWithIdentifier:NSStringFromClass(SVOneRepTestCell.class)];
        if (!cell) {
            cell = [SVOneRepTestCell create];
        }
        JSVLift *mainLift = [[JSVLiftStore instance] first];
        [cell.oneRepField setText:[mainLift.weight stringValue]];

        self.oneRepField = cell.oneRepField;
        [[TextViewInputAccessoryBuilder new] doneButtonAccessory:cell.oneRepField];
        return cell;
    }
    else {
        Class setClass = [[IAPAdapter instance] hasPurchased:IAP_BAR_LOADING] ? SetCellWithPlates.class : SetCell.class;
        SetCell *cell = [tableView dequeueReusableCellWithIdentifier:NSStringFromClass(setClass)];
        if (!cell) {
            cell = [setClass create];
        }

        JSet *set = self.svWorkout.workout.sets[(NSUInteger) indexPath.row];
        [cell setSet:set];
        if (self.svWorkout.weightAdd) {
            NSDecimalNumber *weight = [[set roundedEffectiveWeight] decimalNumberByAdding:self.svWorkout.weightAdd];
            [cell.weightLabel setText:[weight stringValue]];
        }
        return cell;
    }
}

- (IBAction)doneButtonTapped:(id)sender {
    if (self.svWorkout.done) {
        self.svWorkout.done = NO;
        [self.doneButton setTitle:@"Done"];
    }
    else {
        [self.svWorkout setDone:YES];
        [self logWorkout];

        UIStoryboard *storyboard = [UIStoryboard storyboardWithName:@"Storyboard" bundle:nil];
        [self.viewDeckController setCenterController:[storyboard instantiateViewControllerWithIdentifier:@"svTrackNav"]];
    }
}

- (void)logWorkout {
    JWorkoutLog *workoutLog = [[JWorkoutLogStore instance] createWithName:@"Smolov" date:[NSDate new]];
    if (self.svWorkout.testMax) {
        NSDecimalNumber *newMax = [NSDecimalNumber decimalNumberWithString:[self.oneRepField text] locale:[NSLocale currentLocale]];
        [[[JSVLiftStore instance] first] setWeight:newMax];

        JSVLift *mainLift = [[JSVLiftStore instance] first];
        JSetLog *setLog = [[JSetLogStore instance] createWithName:mainLift.name weight:newMax reps:1 warmup:NO assistance:NO amrap:NO];
        [workoutLog addSet:setLog];
    }
    else {
        for (JSet *set in self.svWorkout.workout.sets) {
            JSetLog *setLog = [[JSetLogStore instance] createFromSet:set];
            if (self.svWorkout.weightAdd) {
                setLog.weight = [[set roundedEffectiveWeight] decimalNumberByAdding:self.svWorkout.weightAdd];
            }
            [workoutLog addSet:setLog];
        }
    }
}

- (CGFloat)tableView:(UITableView *)tableView heightForRowAtIndexPath:(NSIndexPath *)indexPath {
    return [self tableView:tableView cellForRowAtIndexPath:indexPath].bounds.size.height;
}

- (void)goToTimer {
    [self performSegueWithIdentifier:@"svGoToTimer" sender:self];
}

- (JWorkout *)getSharedWorkout {
    return self.svWorkout.workout;
}

@end
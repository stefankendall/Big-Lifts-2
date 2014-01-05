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

- (NSInteger)tableView:(UITableView *)tableView numberOfRowsInSection:(NSInteger)section {
    if (self.svWorkout.testMax) {
        return 1;
    }
    else {
        return [self.svWorkout.workout.sets count];
    }
}

- (UITableViewCell *)tableView:(UITableView *)tableView cellForRowAtIndexPath:(NSIndexPath *)indexPath {
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
    [self.svWorkout setDone:YES];

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
            [workoutLog addSet:setLog];
        }
    }
}

@end
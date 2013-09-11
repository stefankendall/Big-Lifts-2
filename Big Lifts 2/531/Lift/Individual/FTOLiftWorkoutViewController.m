#import <ViewDeck/IIViewDeckController.h>
#import <MRCEnumerable/NSArray+Enumerable.h>
#import "FTOLiftWorkoutViewController.h"
#import "FTOWorkout.h"
#import "Workout.h"
#import "FTOWorkoutCell.h"
#import "WorkoutLogStore.h"
#import "WorkoutLog.h"
#import "SetLogStore.h"
#import "Set.h"
#import "FTOLiftWorkoutToolbar.h"
#import "FTORepsToBeatCalculator.h"
#import "FTORepsToBeatBreakdown.h"
#import "FTOSetRepsForm.h"
#import "SetLog.h"
#import "FTOCycleAdjustor.h"

@implementation FTOLiftWorkoutViewController

- (void)viewWillAppear:(BOOL)animated {
    [self.tableView reloadData];
}

- (NSInteger)tableView:(UITableView *)tableView numberOfRowsInSection:(NSInteger)section {
    if ([self shouldShowRepsToBeat] && section == 0) {
        return 1;
    }

    return [self.ftoWorkout.workout.sets count];
}

- (NSInteger)numberOfSectionsInTableView:(UITableView *)tableView {
    return [self shouldShowRepsToBeat] ? 2 : 1;
}

- (UITableViewCell *)tableView:(UITableView *)tableView cellForRowAtIndexPath:(NSIndexPath *)indexPath {
    if (([indexPath section]) == 0 && [self shouldShowRepsToBeat]) {
        return [self buildWorkoutToolbarCell];
    }

    FTOWorkoutCell *cell = [tableView dequeueReusableCellWithIdentifier:NSStringFromClass(FTOWorkoutCell.class)];
    if (!cell) {
        cell = [FTOWorkoutCell create];
    }
    int previousReps = 0;
    NSNumber *previouslyRepsNumber = [self.variableReps objectForKey:[NSNumber numberWithInteger:[indexPath row]]];
    if (previouslyRepsNumber) {
        previousReps = [previouslyRepsNumber intValue];
    }
    [cell setSet:self.ftoWorkout.workout.sets[(NSUInteger) ([indexPath row])] withEnteredReps:previousReps];
    return cell;
}

- (UITableViewCell *)buildWorkoutToolbarCell {
    FTOLiftWorkoutToolbar *cell = [self.tableView dequeueReusableCellWithIdentifier:@"FTOLiftWorkoutToolbar"];
    if (!cell) {
        cell = [FTOLiftWorkoutToolbar create];
        Set *heaviestAmrap = [self heaviestAmrapSet:self.ftoWorkout.workout.sets];
        int repsToBeat = [[FTORepsToBeatCalculator new] repsToBeat:heaviestAmrap.lift atWeight:[heaviestAmrap roundedEffectiveWeight]];
        [cell.repsToBeat setTitle:[NSString stringWithFormat:@"To Beat: %d", repsToBeat] forState:UIControlStateNormal];
        [cell.repsToBeat addTarget:self action:@selector(showRepsToBeatBreakdown:) forControlEvents:UIControlEventTouchUpInside];
    }
    return cell;
}

- (Set *)heaviestAmrapSet:(NSMutableOrderedSet *)sets {
    __block Set *heaviestAmrap = nil;
    [[sets array] each:^(Set *testSet) {
        if ([testSet amrap]) {
            if (!heaviestAmrap) {
                heaviestAmrap = testSet;
            }
            else if ([testSet.roundedEffectiveWeight
                    compare:heaviestAmrap.roundedEffectiveWeight] == NSOrderedDescending) {
                heaviestAmrap = testSet;
            }
        }
    }];
    return heaviestAmrap;
}

- (void)showRepsToBeatBreakdown:(id)showRepsToBeatBreakdown {
    [self performSegueWithIdentifier:@"ftoRepsToBeat" sender:self];
}

- (void)prepareForSegue:(UIStoryboardSegue *)segue sender:(id)sender {
    if ([[segue identifier] isEqualToString:@"ftoRepsToBeat"]) {
        FTORepsToBeatBreakdown *breakdown = [segue destinationViewController];
        [breakdown setLastSet:[self heaviestAmrapSet:self.ftoWorkout.workout.sets]];
    }
    else if ([[segue identifier] isEqualToString:@"ftoSetRepsForm"]) {
        FTOSetRepsForm *form = [segue destinationViewController];
        Set *tappedSet = self.ftoWorkout.workout.sets[[self.tappedSetRow unsignedIntegerValue]];
        NSNumber *previouslyEnteredReps = [self.variableReps objectForKey:self.tappedSetRow];
        if (previouslyEnteredReps) {
            [form setPreviouslyEnteredReps:[previouslyEnteredReps intValue]];
        }
        [form setSet:tappedSet];
        [form setDelegate:self];
    }

    [super prepareForSegue:segue sender:sender];
}

- (void)tableView:(UITableView *)tableView didSelectRowAtIndexPath:(NSIndexPath *)indexPath {
    Set *set = self.ftoWorkout.workout.sets[[indexPath row]];
    if ([set hasVariableReps]) {
        self.tappedSetRow = [NSNumber numberWithInteger:[indexPath row]];
        [self performSegueWithIdentifier:@"ftoSetRepsForm" sender:self];
    }
}

- (IBAction)doneButtonTapped:(id)sender {
    [self logWorkout];
    [self.ftoWorkout setDone:YES];
    if ([self missedAmrapReps]) {
        UIAlertView *alertView = [[UIAlertView alloc] initWithTitle:@"Missed Reps"
                                                            message:@"It looks like you missed a set! Maybe drop your training max for next cycle?"
                                                           delegate:nil cancelButtonTitle:@"OK"
                                                  otherButtonTitles:nil];
        [alertView show];
    }
    [[FTOCycleAdjustor new] checkForCycleChange];
    UIStoryboard *storyboard = [UIStoryboard storyboardWithName:@"Storyboard" bundle:nil];
    [self.viewDeckController setCenterController:[storyboard instantiateViewControllerWithIdentifier:@"ftoTrackNavController"]];
}

- (void)setWorkout:(FTOWorkout *)ftoWorkout1 {
    self.ftoWorkout = ftoWorkout1;
    self.variableReps = [@{} mutableCopy];
}

- (BOOL)missedAmrapReps {
    NSMutableOrderedSet *sets = self.ftoWorkout.workout.sets;
    for (int i = 0; i < [sets count]; i++) {
        Set *set = sets[(NSUInteger) i];
        NSNumber *loggedReps = self.variableReps[[NSNumber numberWithInt:i]];
        if (loggedReps && [loggedReps compare:set.reps] == NSOrderedAscending) {
            return YES;
        }
    }
    return NO;
}

- (void)logWorkout {
    WorkoutLog *log = [[WorkoutLogStore instance] create];
    log.name = @"5/3/1";
    log.date = [NSDate new];

    NSMutableOrderedSet *sets = self.ftoWorkout.workout.sets;
    for (int i = 0; i < [sets count]; i++) {
        Set *set = sets[(NSUInteger) i];
        SetLog *setLog = [[SetLogStore instance] createFromSet:set];
        NSNumber *reps = self.variableReps[[NSNumber numberWithInt:i]];
        if (reps) {
            setLog.reps = reps;
        }
        [log.sets addObject:setLog];
    }
}

- (BOOL)shouldShowRepsToBeat {
    Set *amrapSet = [[[self.ftoWorkout.workout sets] array] detect:^BOOL(Set *set) {
        return set.amrap;
    }];
    return amrapSet != nil;
}

- (void)repsChanged:(NSNumber *)reps {
    self.variableReps[self.tappedSetRow] = reps;
}

- (CGFloat)tableView:(UITableView *)tableView heightForRowAtIndexPath:(NSIndexPath *)indexPath {
    UITableViewCell *cell = [self tableView:tableView cellForRowAtIndexPath:indexPath];
    if ([cell isKindOfClass:FTOWorkoutCell.class]) {
        FTOWorkoutCell *ftoCell = (FTOWorkoutCell *) cell;
        return [[ftoCell setCell] bounds].size.height;
    }
    return [cell bounds].size.height;
}

@end
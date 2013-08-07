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

@interface FTOLiftWorkoutViewController ()

@property(nonatomic) NSMutableDictionary *variableReps;
@end

@implementation FTOLiftWorkoutViewController

- (void)viewWillAppear:(BOOL)animated {
    [self.tableView reloadData];
}

- (NSInteger)tableView:(UITableView *)tableView numberOfRowsInSection:(NSInteger)section {
    NSUInteger setCount = [self.ftoWorkout.workout.sets count];
    if ([self shouldShowRepsToBeat]) {
        return setCount + 1;
    }
    else {
        return setCount;
    }
}

- (UITableViewCell *)tableView:(UITableView *)tableView cellForRowAtIndexPath:(NSIndexPath *)indexPath {
    int row = [indexPath row];

    if ([self shouldShowRepsToBeat]) {
        if (row == 0) {
            return [self buildWorkoutToolbarCell];
        }
        else {
            row--;
        }
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
    [cell setSet:self.ftoWorkout.workout.sets[row] withEnteredReps:previousReps];
    return cell;
}

- (UITableViewCell *)buildWorkoutToolbarCell {
    FTOLiftWorkoutToolbar *cell = [self.tableView dequeueReusableCellWithIdentifier:@"FTOLiftWorkoutToolbar"];
    if (!cell) {
        cell = [FTOLiftWorkoutToolbar create];
        Set *lastSet = [self.ftoWorkout.workout.sets lastObject];
        int repsToBeat = [[FTORepsToBeatCalculator new] repsToBeat:lastSet.lift atWeight:[lastSet roundedEffectiveWeight]];
        [cell.repsToBeat setTitle:[NSString stringWithFormat:@"To Beat: %d", repsToBeat] forState:UIControlStateNormal];
        [cell.repsToBeat addTarget:self action:@selector(showRepsToBeatBreakdown:) forControlEvents:UIControlEventTouchUpInside];
    }
    return cell;
}

- (void)showRepsToBeatBreakdown:(id)showRepsToBeatBreakdown {
    [self performSegueWithIdentifier:@"ftoRepsToBeat" sender:self];
}

- (void)prepareForSegue:(UIStoryboardSegue *)segue sender:(id)sender {
    if ([[segue identifier] isEqualToString:@"ftoRepsToBeat"]) {
        FTORepsToBeatBreakdown *breakdown = [segue destinationViewController];
        [breakdown setLastSet:[self.ftoWorkout.workout.sets lastObject]];
    }
    else if ([[segue identifier] isEqualToString:@"ftoSetRepsForm"]) {
        FTOSetRepsForm *form = [segue destinationViewController];
        Set *tappedSet = self.ftoWorkout.workout.sets[[self.tappedSetRow unsignedIntegerValue] - 1];
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
    NSUInteger setIndex = (NSUInteger) [indexPath row];
    if ([self shouldShowRepsToBeat]) {
        setIndex--;
    }

    Set *set = self.ftoWorkout.workout.sets[setIndex];
    if ([set hasVariableReps]) {
        self.tappedSetRow = [NSNumber numberWithInteger:[indexPath row]];
        [self performSegueWithIdentifier:@"ftoSetRepsForm" sender:self];
    }
}

- (IBAction)doneButtonTapped:(id)sender {
    [self logWorkout];
    [self.ftoWorkout setDone:YES];
    [[FTOCycleAdjustor new] checkForCycleChange];
    UIStoryboard *storyboard = [UIStoryboard storyboardWithName:@"Storyboard" bundle:nil];
    [self.viewDeckController setCenterController:[storyboard instantiateViewControllerWithIdentifier:@"ftoTrackNavController"]];
}

- (void)setWorkout:(FTOWorkout *)ftoWorkout1 {
    self.ftoWorkout = ftoWorkout1;
    self.variableReps = [@{} mutableCopy];
}

- (void)logWorkout {
    WorkoutLog *log = [[WorkoutLogStore instance] create];
    log.name = @"5/3/1";
    log.date = [NSDate new];

    NSMutableOrderedSet *sets = self.ftoWorkout.workout.sets;
    for (int i = 0; i < [sets count]; i++) {
        Set *set = sets[(NSUInteger) i];
        SetLog *setLog = [[SetLogStore instance] createFromSet:set];
        NSNumber *reps = self.variableReps[[NSNumber numberWithInt:(i + 1)]];
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
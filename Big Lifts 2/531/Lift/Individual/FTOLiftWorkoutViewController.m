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
#import "FTOSetChangeForm.h"
#import "SetLog.h"
#import "FTOCycleAdjustor.h"
#import "UITableViewController+NoEmptyRows.h"
#import "SetHelper.h"

@implementation FTOLiftWorkoutViewController

- (void)viewWillAppear:(BOOL)animated {
    [self.tableView reloadData];
    if (self.ftoWorkout.done) {
        [self.doneButton setTitle:@"Not Done"];
    }
    else {
        [self.doneButton setTitle:@"Done"];
    }
}

- (NSInteger)tableView:(UITableView *)tableView numberOfRowsInSection:(NSInteger)section {
    if (section == [self toolbarSection]) {
        return 1;
    }
    else if (section == [self warmupSection]) {
        return [[self.ftoWorkout.workout warmupSets] count];
    }
    else if (section == [self workoutSection]) {
        return [[self.ftoWorkout.workout workSets] count];
    }
    else {
        return [[self.ftoWorkout.workout assistanceSets] count];
    }
}

- (BOOL)hasWarmup {
    return [self.ftoWorkout.workout.orderedSets detect:^BOOL(Set *set) {
        return set.warmup;
    }] != nil;
}

- (BOOL)hasAssistance {
    return [self.ftoWorkout.workout.orderedSets detect:^BOOL(Set *set) {
        return set.assistance;
    }] != nil;
}

- (NSInteger)numberOfSectionsInTableView:(UITableView *)tableView {
    int toolbar = 1;
    int warmup = 1;
    int workout = 1;
    int assistance = 1;

    if ([self toolbarSection] == -1) {
        toolbar = 0;
    }

    if ([self warmupSection] == -1) {
        warmup = 0;
    }

    if ([self assistanceSection] == -1) {
        assistance = 0;
    }

    return toolbar + warmup + workout + assistance;
}

- (UITableViewCell *)tableView:(UITableView *)tableView cellForRowAtIndexPath:(NSIndexPath *)indexPath {
    NSInteger section = [indexPath section];
    if (section == [self toolbarSection]) {
        return [self buildWorkoutToolbarCell];
    }

    int effectiveRow = [self effectiveRowFor:indexPath];
    FTOWorkoutCell *cell = [tableView dequeueReusableCellWithIdentifier:NSStringFromClass(FTOWorkoutCell.class)];
    if (!cell) {
        cell = [FTOWorkoutCell create];
    }
    NSNumber *previousReps = [self.variableReps objectForKey:[NSNumber numberWithInteger:effectiveRow]];
    NSNumber *previousWeight = [self.variableWeight objectForKey:[NSNumber numberWithInteger:effectiveRow]];
    [cell setSet:self.ftoWorkout.workout.orderedSets[(NSUInteger) effectiveRow] withEnteredReps:previousReps withEnteredWeight:previousWeight];
    return cell;
}

- (int)effectiveRowFor:(NSIndexPath *)path {
    if ([path section] == [self warmupSection]) {
        return [path row];
    }
    else if ([path section] == [self workoutSection]) {
        return [[self.ftoWorkout.workout warmupSets] count] + [path row];
    }
    else if ([path section] == [self assistanceSection]) {
        return [[self.ftoWorkout.workout warmupSets] count] + [[self.ftoWorkout.workout workSets] count] + [path row];
    }

    return -1;
}

- (UITableViewCell *)buildWorkoutToolbarCell {
    FTOLiftWorkoutToolbar *cell = [self.tableView dequeueReusableCellWithIdentifier:@"FTOLiftWorkoutToolbar"];
    if (!cell) {
        cell = [FTOLiftWorkoutToolbar create];
        Set *heaviestAmrap = [[SetHelper new] heaviestAmrapSet:self.ftoWorkout.workout.orderedSets];
        int repsToBeat = [[FTORepsToBeatCalculator new] repsToBeat:heaviestAmrap.lift atWeight:[heaviestAmrap roundedEffectiveWeight]];
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
        [breakdown setLastSet:[[SetHelper new] heaviestAmrapSet:self.ftoWorkout.workout.orderedSets]];
    }
    else if ([[segue identifier] isEqualToString:@"ftoSetRepsForm"]) {
        FTOSetChangeForm *form = [segue destinationViewController];
        Set *tappedSet = self.ftoWorkout.workout.orderedSets[[self.tappedSetRow unsignedIntegerValue]];
        NSNumber *previouslyEnteredReps = [self.variableReps objectForKey:self.tappedSetRow];
        NSDecimalNumber *previouslyEnteredWeight = [self.variableWeight objectForKey:self.tappedSetRow];
        if (previouslyEnteredReps) {
            [form setPreviouslyEnteredReps:[previouslyEnteredReps intValue]];
        }
        if (previouslyEnteredWeight) {
            [form setPreviouslyEnteredWeight:previouslyEnteredWeight];
        }
        [form setSet:tappedSet];
        [form setDelegate:self];
    }

    [super prepareForSegue:segue sender:sender];
}

- (void)tableView:(UITableView *)tableView didSelectRowAtIndexPath:(NSIndexPath *)indexPath {
    self.tappedSetRow = [NSNumber numberWithInteger:[self effectiveRowFor:indexPath]];
    [self performSegueWithIdentifier:@"ftoSetRepsForm" sender:self];
}

- (IBAction)doneButtonTapped:(id)sender {
    if (self.ftoWorkout.done) {
        [self unmarkWorkout];
    }
    else {
        [self logAndMoveOn];
    }
}

- (void)unmarkWorkout {
    self.ftoWorkout.done = NO;
    [self viewWillAppear:NO];
}

- (void)logAndMoveOn {
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
    self.variableWeight = [@{} mutableCopy];
}

- (BOOL)missedAmrapReps {
    NSArray *sets = self.ftoWorkout.workout.orderedSets;
    Set *heaviestAmrapSet = [[SetHelper new] heaviestAmrapSet:sets];
    for (int i = 0; i < [sets count]; i++) {
        Set *set = sets[(NSUInteger) i];
        NSNumber *loggedReps = self.variableReps[[NSNumber numberWithInt:i]];
        if (set == heaviestAmrapSet && loggedReps && [loggedReps compare:set.reps] == NSOrderedAscending) {
            return YES;
        }
    }
    return NO;
}

- (void)logWorkout {
    WorkoutLog *workoutLog = [[WorkoutLogStore instance] create];
    workoutLog.name = @"5/3/1";
    workoutLog.date = [NSDate new];

    NSArray *sets = self.ftoWorkout.workout.orderedSets;
    for (int i = 0; i < [sets count]; i++) {
        Set *set = sets[(NSUInteger) i];
        NSNumber *reps = self.variableReps[[NSNumber numberWithInt:i]];
        if (reps != nil && [reps intValue] == 0) {
            continue;
        }
        NSDecimalNumber *weight = self.variableWeight[[NSNumber numberWithInt:i]];

        SetLog *setLog = [[SetLogStore instance] createFromSet:set];
        if (reps != nil) {
            setLog.reps = reps;
        }
        if (weight != nil ) {
            setLog.weight = weight;
        }

        [workoutLog addSet:setLog];
    }
}

- (BOOL)shouldShowRepsToBeat {
    Set *amrapSet = [[self.ftoWorkout.workout orderedSets] detect:^BOOL(Set *set) {
        return set.amrap;
    }];
    return amrapSet != nil;
}

- (void)repsChanged:(NSNumber *)reps {
    self.variableReps[self.tappedSetRow] = reps;
}

- (void)weightChanged:(NSDecimalNumber *)weight {
    if (weight) {
        self.variableWeight[self.tappedSetRow] = weight;
    }
}

- (CGFloat)tableView:(UITableView *)tableView heightForRowAtIndexPath:(NSIndexPath *)indexPath {
    UITableViewCell *cell = [self tableView:tableView cellForRowAtIndexPath:indexPath];
    if ([cell isKindOfClass:FTOWorkoutCell.class]) {
        FTOWorkoutCell *ftoCell = (FTOWorkoutCell *) cell;
        return [[ftoCell setCell] bounds].size.height;
    }
    return [cell bounds].size.height;
}

- (NSString *)tableView:(UITableView *)tableView titleForHeaderInSection:(NSInteger)section {
    if (section == [self warmupSection]) {
        return @"Warm-up";
    }
    else if (section == [self workoutSection]) {
        return @"Workout";
    }
    else if (section == [self assistanceSection]) {
        return @"Assistance";
    }
    return @"";
}

- (UIView *)tableView:(UITableView *)tableView viewForHeaderInSection:(NSInteger)section {
    if (section == [self toolbarSection]) {
        return [self emptyView];
    }
    return [super tableView:tableView viewForFooterInSection:section];
}

- (CGFloat)tableView:(UITableView *)tableView heightForHeaderInSection:(NSInteger)section {
    if (section == [self toolbarSection]) {
        return 0;
    }
    return 20;
}

- (int)toolbarSection {
    int toolbarSection = 0;
    if (![self shouldShowRepsToBeat]) {
        toolbarSection = -1;
    }
    return toolbarSection;
}

- (int)warmupSection {
    int warmupSection = 1;
    if (![self shouldShowRepsToBeat]) {
        warmupSection--;
    }
    if (![self hasWarmup]) {
        warmupSection = -1;
    }
    return warmupSection;
}

- (int)workoutSection {
    int workoutSection = 2;
    if (![self shouldShowRepsToBeat]) {
        workoutSection--;
    }
    if (![self hasWarmup]) {
        workoutSection--;
    }
    return workoutSection;
}

- (int)assistanceSection {
    int assistanceSection = 3;
    if (![self shouldShowRepsToBeat]) {
        assistanceSection--;
    }
    if (![self hasWarmup]) {
        assistanceSection--;
    }
    if (![self hasAssistance]) {
        assistanceSection = -1;
    }
    return assistanceSection;
}

@end
#import <ViewDeck/IIViewDeckController.h>
#import <MRCEnumerable/NSArray+Enumerable.h>
#import <FlurrySDK/Flurry.h>
#import <iAd/iAd.h>
#import "FTOLiftWorkoutViewController.h"
#import "FTOWorkoutCell.h"
#import "JSet.h"
#import "FTOLiftWorkoutToolbar.h"
#import "FTORepsToBeatCalculator.h"
#import "JFTOWorkout.h"
#import "FTORepsToBeatBreakdown.h"
#import "FTOSetChangeForm.h"
#import "FTOCycleAdjustor.h"
#import "UITableViewController+NoEmptyRows.h"
#import "SetHelper.h"
#import "JWorkoutLogStore.h"
#import "JWorkoutLog.h"
#import "JSetLogStore.h"
#import "JSetLog.h"
#import "JWorkout.h"
#import "BLTimer.h"
#import "FTOWorkoutChangeCache.h"
#import "SetChange.h"
#import "Purchaser.h"

@implementation FTOLiftWorkoutViewController

- (void)viewDidLoad {
    [super viewDidLoad];
    [self registerCellNib:FTOWorkoutCell.class];
    [self registerCellNib:FTOLiftWorkoutToolbar.class];
}

- (void)viewWillAppear:(BOOL)animated {
    [Flurry logEvent:@"Workout" withParameters:@{@"Name" : @"5/3/1"}];
    [self.tableView reloadData];
    if (self.ftoWorkout.done) {
        [self.doneButton setTitle:@"Not Done"];
    }
    else {
        [self.doneButton setTitle:@"Done"];
    }

    [[BLTimer instance] setObserver:self];

    if (![Purchaser hasPurchasedAnything]) {
        self.interstitial = [[ADInterstitialAd alloc] init];
        self.interstitial.delegate = self;
        self.interstitialPresentationPolicy = ADInterstitialPresentationPolicyManual;
    }
}

- (void)viewWillDisappear:(BOOL)animated {
    [[BLTimer instance] setObserver:nil];
}

- (void)viewDidDisappear:(BOOL)animated {
    if (![self.navigationController.viewControllers containsObject:self]) {
        [[FTOWorkoutChangeCache instance] clearCompletedSets];
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
    return [[self.ftoWorkout.workout warmupSets] count] > 0;
}

- (BOOL)hasAssistance {
    return [[self.ftoWorkout.workout assistanceSets] count] > 0;
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
    cell.indexPath = indexPath;
    if ([[FTOWorkoutChangeCache instance] isComplete:indexPath]) {
        [cell.contentView setBackgroundColor:[UIColor colorWithRed:179.0f / 255.0f green:255.0f / 255.0f blue:178.0f / 255.0f alpha:1.0]];
    }
    else {
        [cell.contentView setBackgroundColor:nil];
    }

    [cell setDelegate:self];
    SetChange *setChange = [[FTOWorkoutChangeCache instance] changeForWorkout:self.ftoWorkout set:effectiveRow];
    [cell setSet:self.ftoWorkout.workout.sets[(NSUInteger) effectiveRow] withEnteredReps:setChange.reps withEnteredWeight:setChange.weight];
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
    FTOLiftWorkoutToolbar *cell = [self.tableView dequeueReusableCellWithIdentifier:NSStringFromClass(FTOLiftWorkoutToolbar.class)];
    if ([self shouldShowRepsToBeat]) {
        [cell.repsToBeat setHidden:NO];
        JSet *heaviestAmrap = [SetHelper heaviestAmrapSet:self.ftoWorkout.workout.sets];
        int repsToBeat = [[FTORepsToBeatCalculator new] repsToBeat:(id) heaviestAmrap.lift atWeight:[heaviestAmrap roundedEffectiveWeight]];
        [cell.repsToBeat setTitle:[NSString stringWithFormat:@"To Beat: %d", repsToBeat] forState:UIControlStateNormal];
        [cell.repsToBeat addTarget:self action:@selector(showRepsToBeatBreakdown:) forControlEvents:UIControlEventTouchUpInside];
    }
    else {
        [cell.repsToBeat setHidden:YES];
    }

    if ([[BLTimer instance] isRunning]) {
        [cell.timerButton setTitle:[[BLTimer instance] formattedTimeRemaining] forState:UIControlStateNormal];
    }
    else {
        [cell.timerButton setTitle:@"Timer" forState:UIControlStateNormal];
    }

    [cell.timerButton addTarget:self action:@selector(goToTimer) forControlEvents:UIControlEventTouchUpInside];
    [cell setShareDelegate:self];
    return cell;
}

- (void)goToTimer {
    [self performSegueWithIdentifier:@"ftoGoToTimer" sender:self];
}

- (void)timerTick {
    [self.tableView reloadRowsAtIndexPaths:@[NSIP(0, 0)] withRowAnimation:UITableViewRowAnimationNone];
}

- (void)showRepsToBeatBreakdown:(id)showRepsToBeatBreakdown {
    [self performSegueWithIdentifier:@"ftoRepsToBeat" sender:self];
}

- (void)prepareForSegue:(UIStoryboardSegue *)segue sender:(id)sender {
    if ([[segue identifier] isEqualToString:@"ftoRepsToBeat"]) {
        FTORepsToBeatBreakdown *breakdown = [segue destinationViewController];
        [breakdown setLastSet:[SetHelper heaviestAmrapSet:self.ftoWorkout.workout.sets]];
    }
    else if ([[segue identifier] isEqualToString:@"ftoSetRepsForm"]) {
        FTOSetChangeForm *form = [segue destinationViewController];
        JSet *tappedSet = self.ftoWorkout.workout.sets[[self.tappedSetRow unsignedIntegerValue]];
        SetChange *setChange = [[FTOWorkoutChangeCache instance] changeForWorkout:self.ftoWorkout set:[self.tappedSetRow intValue]];
        if (setChange.reps) {
            [form setPreviouslyEnteredReps:[setChange.reps intValue]];
        }
        if (setChange.weight) {
            [form setPreviouslyEnteredWeight:setChange.weight];
        }
        [form setSet:tappedSet];
        [form setDelegate:self];
    }

    [super prepareForSegue:segue sender:sender];
}

- (void)tableView:(UITableView *)tableView didSelectRowAtIndexPath:(NSIndexPath *)indexPath {
    if (indexPath.section != [self toolbarSection]) {
        self.tappedSetRow = [NSNumber numberWithInteger:[self effectiveRowFor:indexPath]];
        [self performSegueWithIdentifier:@"ftoSetRepsForm" sender:self];
    }
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
    FTOCycleAdjustor *cycleAdjustor = [FTOCycleAdjustor new];
    BOOL willIncrement = [cycleAdjustor shouldIncrementLifts];
    [cycleAdjustor checkForCycleChange];
    if (willIncrement) {
        [self performSegueWithIdentifier:@"ftoShowLiftIncrements" sender:self];
    }
    else {
        if ([Purchaser hasPurchasedAnything]) {
            [self makeTrackCenterController];
        }
        else {
            [self requestInterstitialAdPresentation];
            [self makeTrackCenterController];
        }
    }
}

- (void)makeTrackCenterController {
    UIStoryboard *storyboard = [UIStoryboard storyboardWithName:@"Storyboard" bundle:nil];
    [self.viewDeckController setCenterController:[storyboard instantiateViewControllerWithIdentifier:@"ftoTrackNavController"]];
}

- (void)setWorkout:(JFTOWorkout *)ftoWorkout1 {
    self.ftoWorkout = ftoWorkout1;
}

- (BOOL)missedAmrapReps {
    NSArray *sets = self.ftoWorkout.workout.sets;
    JSet *heaviestAmrapSet = [SetHelper heaviestAmrapSet:sets];
    for (int i = 0; i < [sets count]; i++) {
        JSet *set = sets[(NSUInteger) i];
        SetChange *setChange = [[FTOWorkoutChangeCache instance] changeForWorkout:self.ftoWorkout set:i];
        NSNumber *loggedReps = setChange.reps;
        if (set == heaviestAmrapSet && loggedReps && [loggedReps compare:set.reps] == NSOrderedAscending) {
            return YES;
        }
    }
    return NO;
}

- (void)logWorkout {
    JWorkoutLog *workoutLog = [[JWorkoutLogStore instance] create];
    workoutLog.name = @"5/3/1";
    workoutLog.date = [NSDate new];
    workoutLog.deload = self.ftoWorkout.deload;

    NSArray *sets = self.ftoWorkout.workout.sets;
    for (int i = 0; i < [sets count]; i++) {
        JSet *set = sets[(NSUInteger) i];
        SetChange *setChange = [[FTOWorkoutChangeCache instance] changeForWorkout:self.ftoWorkout set:i];
        NSNumber *reps = setChange.reps;
        if (reps != nil && [reps intValue] == 0) {
            continue;
        }
        NSDecimalNumber *weight = setChange.weight;

        JSetLog *setLog = [[JSetLogStore instance] createFromSet:set];
        if (reps != nil) {
            setLog.reps = reps;
        }
        if (weight != nil) {
            setLog.weight = weight;
        }

        [workoutLog addSet:setLog];
    }
    [[FTOWorkoutChangeCache instance] clear];
}

- (BOOL)shouldShowRepsToBeat {
    JSet *amrapSet = [[self.ftoWorkout.workout sets] detect:^BOOL(JSet *set) {
        return set.amrap;
    }];
    return amrapSet != nil;
}

- (void)repsChanged:(NSNumber *)reps {
    SetChange *setChange = [[FTOWorkoutChangeCache instance] changeForWorkout:self.ftoWorkout set:[self.tappedSetRow intValue]];
    setChange.reps = reps;
}

- (void)weightChanged:(NSDecimalNumber *)weight {
    if (weight) {
        SetChange *setChange = [[FTOWorkoutChangeCache instance] changeForWorkout:self.ftoWorkout set:[self.tappedSetRow intValue]];
        setChange.weight = weight;
    }
}

- (void)swipeTableViewCellDidResetState:(RMSwipeTableViewCell *)swipeTableViewCell fromPoint:(CGPoint)point animation:(RMSwipeTableViewCellAnimationType)animation velocity:(CGPoint)velocity {
    FTOWorkoutCell *cell = (FTOWorkoutCell *) swipeTableViewCell;
    [[FTOWorkoutChangeCache instance] toggleComplete:cell.indexPath];
    [self.tableView reloadRowsAtIndexPaths:@[cell.indexPath] withRowAnimation:UITableViewRowAnimationNone];
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
    return 0;
}

- (int)warmupSection {
    int warmupSection = 1;
    if (![self hasWarmup]) {
        warmupSection = -1;
    }
    return warmupSection;
}

- (int)workoutSection {
    int workoutSection = 2;
    if (![self hasWarmup]) {
        workoutSection--;
    }
    return workoutSection;
}

- (int)assistanceSection {
    int assistanceSection = 3;
    if (![self hasWarmup]) {
        assistanceSection--;
    }
    if (![self hasAssistance]) {
        assistanceSection = -1;
    }
    return assistanceSection;
}

- (NSArray *)getSharedWorkout {
    return @[self.ftoWorkout.workout];
}

- (void)interstitialAdDidUnload:(ADInterstitialAd *)interstitialAd {
}

- (void)interstitialAd:(ADInterstitialAd *)interstitialAd didFailWithError:(NSError *)error {
    NSLog(@"%@", error);
}

- (void)interstitialAdDidLoad:(ADInterstitialAd *)interstitialAd {
    NSLog(@"Ad is loaded");
}

@end
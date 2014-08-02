#import <IAPManager/IAPManager.h>
#import <FlurrySDK/Flurry.h>
#import "SSIndividualWorkoutViewController.h"
#import "IIViewDeckController.h"
#import "JWorkoutLogStore.h"
#import "JWorkoutLog.h"
#import "JSSWorkoutSTore.h"
#import "JSSStateStore.h"
#import "SetCellWithPlates.h"
#import "JSetLogStore.h"
#import "JSetLog.h"
#import "JSet.h"
#import "JSSWorkout.h"
#import "JSSState.h"
#import "JWorkout.h"
#import "SSEditSetForm.h"
#import "SetChange.h"
#import "JLift.h"
#import "JSSLift.h"
#import "RestShareToolbar.h"
#import "SetClassGenerator.h"

@interface SSIndividualWorkoutViewController ()
@property(nonatomic, strong) NSMutableArray *loggedWorkouts;
@property(nonatomic, strong) NSMutableDictionary *loggedSets;
@end

@implementation SSIndividualWorkoutViewController

- (void)viewDidLoad {
    [super viewDidLoad];
    self.workoutIndex = 0;
    [self resetLoggedSets];

    [self registerCellNib:SetCellWithPlates.class];
    [self registerCellNib:SetCell.class];
}

- (void)viewWillAppear:(BOOL)animated {
    [super viewWillAppear:animated];
    [Flurry logEvent:@"Workout" withParameters:@{@"Name" : @"Starting Strength"}];
    [self.tableView reloadData];
}

- (void)resetLoggedSets {
    self.loggedSets = [@{} mutableCopy];
    self.loggedWorkouts = [@[] mutableCopy];
}

- (CGFloat)tableView:(UITableView *)tableView heightForRowAtIndexPath:(NSIndexPath *)indexPath {
    UITableViewCell *cell = [self tableView:tableView cellForRowAtIndexPath:indexPath];
    return [cell bounds].size.height;
}

- (IBAction)nextButtonTapped:(id)sender {
    [self.loggedWorkouts addObject:self.loggedSets];
    self.loggedSets = [@{} mutableCopy];

    self.workoutIndex++;
    [self.tableView reloadData];

    if (self.workoutIndex == self.ssWorkout.workouts.count - 1) {
        UIBarButtonItem *doneButton = [[UIBarButtonItem alloc] initWithTitle:@"Done" style:UIBarButtonItemStyleDone target:self action:@selector(doneButtonTapped:)];
        [self navigationItem].rightBarButtonItem = doneButton;
    }
}

- (void)doneButtonTapped:(id)o {
    [self.loggedWorkouts addObject:self.loggedSets];

    [self logWorkout];
    [self saveState];
    [[JSSWorkoutStore instance] incrementWeights:self.ssWorkout];
    UIViewController *controller = [[self navigationController] viewControllers][0];
    UIStoryboard *storyboard = [UIStoryboard storyboardWithName:@"Storyboard" bundle:nil];
    [controller.viewDeckController setCenterController:[storyboard instantiateViewControllerWithIdentifier:@"ssTrackViewController"]];
}

- (void)adjustAlternation {
    if ([self.ssWorkout.name isEqualToString:@"A"]) {
        JSSState *state = [[JSSStateStore instance] first];
        state.workoutAAlternation = [state.workoutAAlternation intValue] == 0 ? @1 : @0;
    }
}

- (void)saveState {
    JSSState *state = [[JSSStateStore instance] first];
    state.lastWorkout = self.ssWorkout;
    [self adjustAlternation];
}

- (void)logWorkout {
    JWorkoutLogStore *store = [JWorkoutLogStore instance];
    JWorkoutLog *log = [store create];
    log.name = @"Starting Strength";
    log.date = [NSDate date];

    for (int workoutIndex = 0; workoutIndex < [self.ssWorkout.workouts count]; workoutIndex++) {
        NSDictionary *loggedSets = self.loggedWorkouts[(NSUInteger) workoutIndex];
        JWorkout *workout = self.ssWorkout.workouts[(NSUInteger) workoutIndex];

        for (int setIndex = 0; setIndex < [[workout workSets] count]; setIndex++) {
            JSet *set = workout.workSets[(NSUInteger) setIndex];
            JSetLog *setLog = [[JSetLogStore instance] createFromSet:set];
            setLog.name = [(JSSLift *) set.lift effectiveName];
            SetChange *change = loggedSets[[NSNumber numberWithInt:setIndex]];
            if (change) {
                setLog.weight = change.weight;
                setLog.reps = change.reps;
            }
            [log addSet:setLog];
        }
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
        return [[[self getCurrentWorkout] sets] count];
    }
}

- (JWorkout *)getCurrentWorkout {
    return [self.ssWorkout.workouts count] > 0 ? self.ssWorkout.workouts[(NSUInteger) self.workoutIndex] : nil;
}

- (UITableViewCell *)tableView:(UITableView *)tableView cellForRowAtIndexPath:(NSIndexPath *)indexPath {
    if (indexPath.section == 0) {
        return [self restToolbar:tableView];
    }
    else {
        Class setClass = [SetClassGenerator generate];
        SetCell *cell = [tableView dequeueReusableCellWithIdentifier:NSStringFromClass(setClass)];
        JSet *set = [self setForIndexPath:indexPath];
        SetChange *data = self.loggedSets[[NSNumber numberWithInt:indexPath.row]];
        NSNumber *enteredReps = data ? data.reps : nil;
        NSDecimalNumber *enteredWeight = data ? data.weight : nil;
        [cell setSet:set withEnteredReps:enteredReps withEnteredWeight:enteredWeight];
        [cell.liftLabel setText:[(JSSLift *) set.lift effectiveName]];

        if ([set.percentage isEqual:N(100)]) {
            [cell.percentageLabel setHidden:YES];
        }
        else {
            [cell.percentageLabel setHidden:NO];
        }
        return cell;
    }
}

- (JSet *)setForIndexPath:(NSIndexPath *)indexPath {
    JWorkout *workout = [self getCurrentWorkout];
    JSet *set = [workout.sets objectAtIndex:(NSUInteger) [indexPath row]];
    return set;
}

- (void)tableView:(UITableView *)tableView didSelectRowAtIndexPath:(NSIndexPath *)indexPath {
    if ([indexPath section] == 1) {
        self.tappedSet = [self setForIndexPath:indexPath];
        self.tappedIndexPath = indexPath;
        [self performSegueWithIdentifier:@"ssEditSet" sender:self];
    }
}

- (void)prepareForSegue:(UIStoryboardSegue *)segue sender:(id)sender {
    if ([segue.identifier isEqualToString:@"ssEditSet"]) {
        SSEditSetForm *form = [segue destinationViewController];
        [form setDelegate:self];
        [form setSet:self.tappedSet];
        SetChange *change = self.loggedSets[[NSNumber numberWithInt:self.tappedIndexPath.row]];
        if (change) {
            [form setPreviousChange:change];
        }
    }
}

- (void)goToTimer {
    [self performSegueWithIdentifier:@"ssGoToTimer" sender:self];
}

- (void)repsChanged:(NSNumber *)reps {
    SetChange *data = self.loggedSets[[NSNumber numberWithInt:self.tappedIndexPath.row]];
    if (!data) {
        data = [SetChange new];
        data.weight = [[self setForIndexPath:self.tappedIndexPath] roundedEffectiveWeight];
        self.loggedSets[[NSNumber numberWithInt:self.tappedIndexPath.row]] = data;
    }
    data.reps = reps;
}

- (void)weightChanged:(NSDecimalNumber *)weight {
    SetChange *data = self.loggedSets[[NSNumber numberWithInt:self.tappedIndexPath.row]];
    if (!data) {
        data = [SetChange new];
        data.reps = [[self setForIndexPath:self.tappedIndexPath] reps];
        self.loggedSets[[NSNumber numberWithInt:self.tappedIndexPath.row]] = data;
    }
    data.weight = weight;
}

- (NSArray *)getSharedWorkout {
    return self.ssWorkout.workouts;
}

@end
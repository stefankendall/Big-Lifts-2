#import <CoreGraphics/CoreGraphics.h>
#import "SSIndividualWorkoutViewController.h"
#import "SSIndividualWorkoutDataSource.h"
#import "SSWorkout.h"
#import "SSMiddleViewController.h"
#import "IIViewDeckController.h"
#import "WorkoutLogStore.h"
#import "WorkoutLog.h"
#import "Workout.h"
#import "Set.h"
#import "SetLogStore.h"

@implementation SSIndividualWorkoutViewController

- (void)viewDidLoad {
    [super viewDidLoad];

    self.workoutIndex = 0;
    self.individualWorkoutDataSource = [[SSIndividualWorkoutDataSource alloc] initWithSsWorkout:self.ssWorkout];
    [self.workoutTable setDataSource:self.individualWorkoutDataSource];
    [self.workoutTable setDelegate:self];
}

- (UIView *)tableView:(UITableView *)tableView viewForFooterInSection:(NSInteger)section {
    UIView *emptyViewToPreventEmptyRows = [UIView new];
    return emptyViewToPreventEmptyRows;
}

- (CGFloat)tableView:(UITableView *)tableView heightForRowAtIndexPath:(NSIndexPath *)indexPath {
    UITableViewCell *cell = [self.individualWorkoutDataSource tableView:tableView cellForRowAtIndexPath:indexPath];
    return [cell bounds].size.height;
}


- (IBAction)nextButtonTapped:(id)sender {
    self.workoutIndex++;

    [self.individualWorkoutDataSource setWorkoutIndex:self.workoutIndex];
    [self.workoutTable reloadData];

    if (self.workoutIndex == self.ssWorkout.workouts.count - 1) {
        UIBarButtonItem *doneButton = [[UIBarButtonItem alloc] initWithTitle:@"Done" style:UIBarButtonItemStyleDone target:self action:@selector(doneButtonTapped:)];
        [self navigationItem].rightBarButtonItem = doneButton;
    }
}

- (void)doneButtonTapped:(id)o {
    [self logWorkout];
    SSMiddleViewController *controller = [[self navigationController] viewControllers][0];
    UIStoryboard *storyboard = [UIStoryboard storyboardWithName:@"Storyboard" bundle:nil];
    [controller.viewDeckController setCenterController:[storyboard instantiateViewControllerWithIdentifier:@"ssTrackViewController"]];
}

- (void)logWorkout {
    WorkoutLogStore *store = [WorkoutLogStore instance];
    WorkoutLog *log = [store create];

    for (Workout *workout in self.ssWorkout.workouts) {
        for (Set *set in workout.sets) {
            [log.sets addObject:[[SetLogStore instance] createFromSet: set]];
        }
    }
}

@end
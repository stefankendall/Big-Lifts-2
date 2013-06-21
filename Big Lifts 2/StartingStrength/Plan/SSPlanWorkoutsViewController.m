#import "SSPlanWorkoutsViewController.h"
#import "SSWorkoutDataSource.h"
#import "SSVariant.h"
#import "SSVariantStore.h"

@implementation SSPlanWorkoutsViewController
@synthesize workoutDataSource;

- (void)viewDidLoad {
    [super viewDidLoad];

    workoutDataSource = [SSWorkoutDataSource new];

    [workoutTableView setDataSource:workoutDataSource];
    [workoutTableView setDelegate:workoutDataSource];
    [workoutTableView setEditing:YES];
}

- (void)viewWillAppear:(BOOL)animated {
    [workoutTableView reloadData];
    SSVariant *variant = [[SSVariantStore instance] first];
    [self.variantButton setTitle:variant.name];
}


@end
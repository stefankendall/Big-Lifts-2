#import <MRCEnumerable/NSArray+Enumerable.h>
#import "FTOTriumvirateSetupViewController.h"
#import "FTOTriumvirate.h"
#import "Set.h"
#import "Lift.h"
#import "TextViewInputAccessoryBuilder.h"
#import "Workout.h"
#import "SetStore.h"

@interface FTOTriumvirateSetupViewController ()
@property(nonatomic, strong) FTOTriumvirate *triumvirate;
@property(nonatomic, strong) Set *set;
@end

@implementation FTOTriumvirateSetupViewController

- (void)viewDidLoad {
    [[TextViewInputAccessoryBuilder new] doneButtonAccessory:self.nameField];
    [[TextViewInputAccessoryBuilder new] doneButtonAccessory:self.repsField];
    [[TextViewInputAccessoryBuilder new] doneButtonAccessory:self.setsField];

    [self.nameField setDelegate:self];
    [self.repsField setDelegate:self];
    [self.setsField setDelegate:self];
}

- (void)setupForm:(FTOTriumvirate *)triumvirate forSet:(Set *)set {
    self.triumvirate = triumvirate;
    self.set = set;
}

- (void)viewWillAppear:(BOOL)animated {
    [self.nameField setText:self.set.lift.name];
    [self.repsField setText:[self.set.reps stringValue]];
    int sets = [self.triumvirate countMatchingSets:self.set];
    [self.setsField setText:[NSString stringWithFormat:@"%d", sets]];
}

- (void)textFieldDidEndEditing:(UITextField *)textField {
    self.set.lift.name = [self.nameField text];
    [[self.triumvirate matchingSets:self.set] each:^(Set *set) {
        set.reps = [NSNumber numberWithInteger:[[self.repsField text] intValue]];
    }];

    int oldSetCount = [self.triumvirate countMatchingSets:self.set];
    int newSetCount = [[self.setsField text] intValue];
    if (newSetCount < oldSetCount && newSetCount > 0) {
        [self removeSets:oldSetCount - newSetCount];
    }
    else if (newSetCount > oldSetCount) {
        [self addSets:newSetCount - oldSetCount];
    }
}

- (void)removeSets:(int)count {
    NSArray *setsToRemove = [[self.triumvirate matchingSets:self.set] subarrayWithRange:NSMakeRange(0, (NSUInteger) count)];
    [self.triumvirate.workout.sets removeObjectsInArray:setsToRemove];
}

- (void)addSets:(int)count {
    for (int i = 0; i < count; i++) {
        Set *newSet = [[SetStore instance] create];
        newSet.lift = self.set.lift;
        newSet.reps = self.set.reps;
        [self.triumvirate.workout.sets addObject:newSet];
    }
}
@end

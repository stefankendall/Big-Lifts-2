#import <MRCEnumerable/NSArray+Enumerable.h>
#import "FTOTriumvirateSetupViewController.h"
#import "JSet.h"
#import "TextViewInputAccessoryBuilder.h"
#import "JLift.h"
#import "JFTOTriumvirate.h"
#import "JWorkout.h"
#import "JSetStore.h"

@interface FTOTriumvirateSetupViewController ()
@property(nonatomic, strong) JFTOTriumvirate *triumvirate;
@property(nonatomic, strong) JSet *set;
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

- (void)setupForm:(JFTOTriumvirate *)triumvirate forSet:(JSet *)set {
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
    [[self.triumvirate matchingSets:self.set] each:^(JSet *set) {
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
    [self.triumvirate.workout removeSets:setsToRemove];
}

- (void)addSets:(int)count {
    for (int i = 0; i < count; i++) {
        JSet *newSet = [[JSetStore instance] create];
        newSet.lift = self.set.lift;
        newSet.reps = self.set.reps;
        [self.triumvirate.workout addSet:newSet];
    }
}
@end

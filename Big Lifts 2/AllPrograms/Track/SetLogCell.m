#import "SetLogCell.h"
#import "SetLog.h"
#import "Settings.h"
#import "SettingsStore.h"
#import "SetLogContainer.h"

@implementation SetLogCell

int const SET_LOG_CELL_HEIGHT = 30;

- (void)setSetLogContainer:(SetLogContainer *)setLogContainer {
    self.setLog = setLogContainer.setLog;
    [self.liftNameLabel setText:[self.setLog name]];
    [self.setsLabel setText:[NSString stringWithFormat:@"%dx", setLogContainer.count]];
    [self.repsLabel setText:[NSString stringWithFormat:@"%d", [[self.setLog reps] intValue]]];

    Settings *settings = [[SettingsStore instance] first];
    NSString *weightText = [NSString stringWithFormat:@"%@ %@", [self.setLog weight], [settings units]];
    [self.weightLabel setText:weightText];
}

@end
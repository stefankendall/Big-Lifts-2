#import "SetLogCell.h"
#import "SetLog.h"
#import "Settings.h"
#import "SettingsStore.h"
#import "SetLogContainer.h"

@implementation SetLogCell
@synthesize setLog, liftNameLabel, setsLabel, repsLabel, weightLabel;

int const SET_LOG_CELL_HEIGHT = 30;

- (void)setSetLogContainer:(SetLogContainer *)setLogContainer {
    setLog = setLogContainer.setLog;
    [liftNameLabel setText:[setLog name]];
    [setsLabel setText:[NSString stringWithFormat:@"%dx", setLogContainer.count]];
    [repsLabel setText:[NSString stringWithFormat:@"%d", [[setLog reps] intValue]]];

    Settings *settings = [[SettingsStore instance] first];
    NSString *weightText = [NSString stringWithFormat:@"%@ %@", [setLog weight], [settings units]];
    [weightLabel setText:weightText];
}

@end
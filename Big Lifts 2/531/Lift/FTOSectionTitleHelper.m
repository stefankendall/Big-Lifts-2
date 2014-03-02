#import "FTOSectionTitleHelper.h"
#import "JFTOSettingsStore.h"
#import "JFTOSettings.h"
#import "JFTOWorkoutSetsGenerator.h"
#import "JFTOVariantStore.h"
#import "JFTOVariant.h"
#import "JFTOPlan.h"

@implementation FTOSectionTitleHelper

- (NSString *)titleForSection:(NSInteger)section {
    JFTOVariant *variant = [[JFTOVariantStore instance] first];
    NSObject <JFTOPlan> *ftoPlan = [[JFTOWorkoutSetsGenerator new] planForVariant:variant.name];

    int titleSection = 0;
    if ([[[JFTOSettingsStore instance] first] sixWeekEnabled]) {
        if (section < 3) {
            titleSection = section;
        }
        else {
            titleSection = section - 3;
        }
    }
    else {
        titleSection = section;
    }

    NSArray *weekNames = [ftoPlan weekNames];
    if (titleSection >= [weekNames count]) {
        return @"";
    }
    return weekNames[(NSUInteger) titleSection];
}

@end
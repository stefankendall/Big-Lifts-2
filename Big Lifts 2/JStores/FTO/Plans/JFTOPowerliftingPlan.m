#import "JFTOPowerliftingPlan.h"
#import "JLift.h"
#import "JFTOStandardPlan.h"

@implementation JFTOPowerliftingPlan

- (NSDictionary *)generate:(JLift *)lift {
    NSMutableDictionary *workout = [[[JFTOStandardPlan new] generate:lift] mutableCopy];
    NSArray *week1 = workout[@1];
    NSArray *week2 = workout[@2];
    workout[@2] = week1;
    workout[@1] = week2;
    return workout;
}

- (NSArray *)deloadWeeks {
    return @[@4];
}

- (NSArray *)incrementMaxesWeeks {
    return @[@4];
}

- (NSArray *)weekNames {
    return @[@"3/3/3", @"5/5/5", @"5/3/1", @"Deload"];
}

@end
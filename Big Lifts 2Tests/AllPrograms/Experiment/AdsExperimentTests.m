#import "AdsExperimentTests.h"
#import "AdsExperiment.h"
#import "IAPAdapter.h"
#import "Purchaser.h"

@implementation AdsExperimentTests

- (void)testNotInExperimentIfNotSet {
    STAssertFalse([AdsExperiment isInExperiment], @"");
}

- (void)testNotInExperimentIfIap {
    [[IAPAdapter instance] addPurchase:IAP_1RM];
    [AdsExperiment placeInExperimentOrNot];
    STAssertFalse([AdsExperiment isInExperiment], @"");
}

- (void)testInExperimentIfNoIap {
    [AdsExperiment placeInExperimentOrNot];
    STAssertTrue([AdsExperiment isInExperiment], @"");
}

@end
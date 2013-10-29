#import "Purchaser.h"
#import "IAPAdapter.h"

NSString *const IAP_BAR_LOADING = @"barLoading";
NSString *const IAP_GRAPHING = @"graphing";
NSString *const IAP_1RM = @"oneRepMax";

NSString *const IAP_SS_WARMUP = @"ssWarmup";
NSString *const IAP_SS_ONUS_WUNSLER = @"ssOnusWunsler";
NSString *const IAP_SS_PRACTICAL_PROGRAMMING = @"ssPracticalProgramming";

NSString *const IAP_PURCHASED_NOTIFICATION = @"iapPurchased";
NSString *const IAP_FTO_JOKER = @"ftoJoker";
NSString *const IAP_FTO_ADVANCED = @"ftoAdvanced";
NSString *const IAP_FTO_TRIUMVIRATE = @"ftoTriumvirate";
NSString *const IAP_FTO_SST = @"ftoSst";
NSString *const IAP_FTO_FIVES_PROGRESSION = @"ftoFivesProgression";
NSString *const IAP_FTO_CUSTOM = @"ftoCustom";

@interface Purchaser ()

@property(nonatomic, strong) NSDictionary *buyMessages;
@end

@implementation Purchaser

- (id)init {
    self = [super init];
    if (self) {
        self.buyMessages = @{
                IAP_BAR_LOADING : @"Bar loading is now available throughout the app.",
                IAP_GRAPHING : @"Graphing is now available.",
                IAP_1RM : @"One rep maxes are now available.",
                IAP_SS_ONUS_WUNSLER : @"Onus Wunsler is now available in Starting Strength.",
                IAP_SS_PRACTICAL_PROGRAMMING : @"Practical Programming is now available in Starting Strength.",
                IAP_SS_WARMUP : @"Warm-up sets added to Starting Strength.",
                IAP_FTO_JOKER : @"Joker Sets are now available in 5/3/1.",
                IAP_FTO_ADVANCED : @"Advanced programming is now available for 5/3/1.",
                IAP_FTO_FIVES_PROGRESSION : @"Five's Progression is now available in 5/3/1."
        };
    }

    return self;
}


- (void)purchase:(NSString *)purchaseId {
    [[IAPAdapter instance] purchaseProductForId:purchaseId completion:^(NSObject *_) {
        [self successfulPurchase:purchaseId];
    }                                     error:^(NSError *err) {
        [self erroredPurchase:err];
    }];
}

- (void)erroredPurchase:(NSError *)err {
    UIAlertView *error = [[UIAlertView alloc] initWithTitle:@"Could not purchase..."
                                                    message:@"Something went wrong trying to connect to the store. Please try again later."
                                                   delegate:nil cancelButtonTitle:@"OK" otherButtonTitles:nil];
    [error performSelectorOnMainThread:@selector(show) withObject:nil waitUntilDone:YES];
}

- (void)successfulPurchase:(NSString *)purchaseId {
    [self savePurchase:purchaseId];
    NSString *buyMessage = self.buyMessages[purchaseId];
    if (buyMessage) {
        UIAlertView *thanks = [[UIAlertView alloc] initWithTitle:@"Purchased!"
                                                         message:buyMessage
                                                        delegate:nil cancelButtonTitle:@"OK" otherButtonTitles:nil];
        [thanks performSelectorOnMainThread:@selector(show) withObject:nil waitUntilDone:YES];
    }
    [[NSNotificationCenter defaultCenter] postNotification:[NSNotification notificationWithName:IAP_PURCHASED_NOTIFICATION object:nil]];
}

- (void)savePurchase:(NSString *)purchaseId {
    [[NSUserDefaults standardUserDefaults] setBool:YES forKey:purchaseId];
    [[NSUserDefaults standardUserDefaults] synchronize];
}

@end
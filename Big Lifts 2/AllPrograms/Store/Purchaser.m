#import "Purchaser.h"
#import "IAPAdapter.h"

NSString * const IAP_BAR_LOADING = @"barLoading";
NSString * const IAP_SS_WARMUP = @"ssWarmup";
NSString * const IAP_SS_ONUS_WUNSLER = @"ssOnusWunsler";
NSString * const IAP_SS_PRACTICAL_PROGRAMMING = @"ssPracticalProgramming";

NSString * const IAP_PURCHASED_NOTIFICATION = @"iapPurchased";
NSString * const FTO_JOKER = @"ftoJoker";

@interface Purchaser ()

@property(nonatomic, strong) NSDictionary *buyMessages;
@end

@implementation Purchaser

- (id)init {
    self = [super init];
    if (self) {
        self.buyMessages = @{
                IAP_BAR_LOADING : @"Bar loading is now available throughout the app.",
                IAP_SS_ONUS_WUNSLER : @"Onus Wunsler is now available in Starting Strength.",
                IAP_SS_PRACTICAL_PROGRAMMING : @"Practical Programming is now available in Starting Strength.",
                IAP_SS_WARMUP : @"Warm-up sets added to Starting Strength.",
                FTO_JOKER : @"Joker Sets are now available in 5/3/1."
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
    UIAlertView *thanks = [[UIAlertView alloc] initWithTitle:@"Purchased!"
                                                     message:self.buyMessages[purchaseId]
                                                    delegate:nil cancelButtonTitle:@"OK" otherButtonTitles:nil];
    [thanks performSelectorOnMainThread:@selector(show) withObject:nil waitUntilDone:YES];
    [[NSNotificationCenter defaultCenter] postNotification:[NSNotification notificationWithName:IAP_PURCHASED_NOTIFICATION  object:nil]];
}

@end
#import "Purchaser.h"
#import "IAPAdapter.h"

@interface Purchaser ()

@property(nonatomic, strong) NSDictionary *buyMessages;
@end

@implementation Purchaser

- (id)init {
    self = [super init];
    if (self) {
        self.buyMessages = @{
                @"barLoading" : @"Bar loading is now available throughout the app.",
                @"ssOnusWunsler" : @"Onus Wunsler is now available in Starting Strength.",
                @"ssPracticalProgramming" : @"Practical Programming is now available in Starting Strength.",
                @"ssWarmup" : @"Warm-up sets added to Starting Strength."
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
    NSLog(@"%@", [err localizedDescription]);
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
    [[NSNotificationCenter defaultCenter] postNotification:[NSNotification notificationWithName:@"iapPurchased" object:nil]];
}

@end
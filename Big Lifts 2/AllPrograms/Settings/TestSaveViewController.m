#import <MessageUI/MessageUI.h>
#import "TestSaveViewController.h"
#import "BLJStore.h"
#import "BLJStoreManager.h"
#import "JModel.h"

@implementation TestSaveViewController

- (void)viewWillAppear:(BOOL)animated {
    [self.startButton setEnabled:YES];
    [self.emailButton setEnabled:NO];
}

- (IBAction)startButtonTapped:(id)sender {
    [self.startButton setEnabled:NO];
    [self runTest];
}

- (IBAction)emailButtonTapped:(id)sender {
    NSString *allData = [self naiveSerializeAllData];

    if ([MFMailComposeViewController canSendMail]) {
        MFMailComposeViewController *controller = [MFMailComposeViewController new];
        controller.mailComposeDelegate = self;
        [controller setSubject:@"Big Lifts 2 - Data Save Test Run Results"];
        [controller setToRecipients:@[@"biglifts@stefankendall.com"]];
        [controller addAttachmentData:[allData dataUsingEncoding:NSUTF8StringEncoding] mimeType:@"text/plain" fileName:@"data.txt"];
        [self presentViewController:controller animated:YES completion:nil];
    }
    else {
        UIAlertView *alertView = [[UIAlertView alloc] initWithTitle:@"Can't open email" message:@"No mail account configured" delegate:nil cancelButtonTitle:@"OK" otherButtonTitles:nil];
        [alertView show];
    }
}

- (void)mailComposeController:(MFMailComposeViewController *)controller didFinishWithResult:(MFMailComposeResult)result error:(NSError *)error {
    [self dismissViewControllerAnimated:YES completion:nil];
}

- (NSString *)naiveSerializeAllData {
    NSMutableArray *data = [@[] mutableCopy];
    for (BLJStore *store in [[BLJStoreManager instance] allStores]) {
        NSMutableArray *serializedModels = [@[] mutableCopy];
        for (JModel *model in [store findAll]) {
            [serializedModels addObject:[[model toDictionary] description]];
        }
        [data addObject:[NSString stringWithFormat:@"%@: %@", NSStringFromClass([store modelClass]), serializedModels]];
    }
    NSString *dataString = [data componentsJoinedByString:@""];
    NSLog(@"%@", dataString);
    return dataString;
}

- (void)runTest {
    NSArray *stores = [[BLJStoreManager instance] allStores];
    dispatch_after(dispatch_time(DISPATCH_TIME_NOW, NSEC_PER_SEC / 4), dispatch_get_main_queue(), ^{
        [self runTestFrom:stores[0]];
    });
}

- (void)runTestFrom:(BLJStore *)store {
    NSString *status = [NSString stringWithFormat:@"Saving %@", NSStringFromClass([store modelClass])];
    [self.statusLabel setText:status];

    @try {
        [store sync];
    }
    @catch (NSException *e) {
        NSString *brokenModel = NSStringFromClass([store modelClass]);
        NSString *errorStatus = [NSString stringWithFormat:@"COULD NOT SAVE: %@", brokenModel];
        [self.statusLabel setText:errorStatus];
    }

    NSArray *stores = [[BLJStoreManager instance] allStores];
    int indexOfStore = [stores indexOfObject:store];
    if (indexOfStore == [stores count] - 1) {
        [self endTest];
    }
    else {
        dispatch_after(dispatch_time(DISPATCH_TIME_NOW, NSEC_PER_SEC / 4), dispatch_get_main_queue(), ^{
            [self runTestFrom:stores[(NSUInteger) (indexOfStore + 1)]];
        });
    }
}

- (void)endTest {
    [self.emailButton setEnabled:YES];
    [[BLJStoreManager instance] syncStores];
}

@end
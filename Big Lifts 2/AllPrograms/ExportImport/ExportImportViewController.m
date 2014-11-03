#import "ExportImportViewController.h"
#import "LogJsonExporterImporter.h"

@implementation ExportImportViewController

- (IBAction)importTapped:(id)sender {
    UIDocumentPickerViewController *documentPicker = [[UIDocumentPickerViewController alloc] initWithDocumentTypes:@[@"public.text"]
                                                                                                            inMode:UIDocumentPickerModeImport];
    documentPicker.delegate = self;
    documentPicker.modalPresentationStyle = UIModalPresentationFormSheet;
    [self presentViewController:documentPicker animated:YES completion:nil];
}

- (IBAction)exportTapped:(id)sender {
    NSURL *url = [self writeLogToFile];
    UIDocumentPickerViewController *documentPicker =
            [[UIDocumentPickerViewController alloc] initWithURL:url
                                                         inMode:UIDocumentPickerModeExportToService];
    documentPicker.delegate = self;
    documentPicker.modalPresentationStyle = UIModalPresentationFormSheet;
    [self presentViewController:documentPicker animated:YES completion:nil];
}

- (NSURL *)writeLogToFile {
    NSString *tempPath = NSTemporaryDirectory();
    NSString *tempFile = [tempPath stringByAppendingPathComponent:@"BigLifts.json"];
    NSData *data = [[LogJsonExporterImporter export] dataUsingEncoding:NSUTF8StringEncoding];
    [data writeToFile:tempFile options:NSDataWritingAtomic error:nil];
    return [NSURL fileURLWithPath:tempFile];
}

- (void)documentPicker:(UIDocumentPickerViewController *)controller didPickDocumentAtURL:(NSURL *)url {
    if (controller.documentPickerMode == UIDocumentPickerModeImport) {
        NSData *data = [[NSFileManager defaultManager] contentsAtPath:[url path]];
        NSString *json = [[NSString alloc] initWithData:data encoding:NSUTF8StringEncoding];
        BOOL success = [LogJsonExporterImporter importJson:json];

        UIAlertView *alert = nil;
        if (success) {
            alert = [[UIAlertView alloc]
                    initWithTitle:@"Import Finished"
                          message:@"The workout log imported successfully."
                         delegate:nil
                cancelButtonTitle:@"OK"
                otherButtonTitles:nil];
        }
        else {
            alert = [[UIAlertView alloc] initWithTitle:@"Import Failed" message:
                            @"The file could not be read. Did you pick the right file?"
                                              delegate:nil
                                     cancelButtonTitle:@"OK"
                                     otherButtonTitles:nil];
        }
        [alert show];
    }
}

@end
@interface BLStore : NSObject

- (void)contentChange:(NSNotification *)note;

- (void)empty;

- (NSString *) modelName;

- (id) first;
@end
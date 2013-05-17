@interface BLStore : NSObject

- (void)contentChange:(NSNotification *)note;

- (void)empty;

- (void) setupDefaults;

- (NSString *) modelName;

- (id) first;

- (NSArray *) findAll;

- (id) atIndex: (int) index;

- (int) count;

@end
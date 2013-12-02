@interface MigrateDataViewController : UIViewController {}
- (void)markHasSeenMigrationPrompt:(BOOL)hasSeen;

- (BOOL)hasSeenMigrationPrompt;
@property (weak, nonatomic) IBOutlet UIButton *migrateDataButton;
@property (weak, nonatomic) IBOutlet UIButton *startFreshButton;

@end
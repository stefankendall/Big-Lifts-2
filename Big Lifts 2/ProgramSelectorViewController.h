@interface ProgramSelectorViewController : UITableViewController {
    __weak IBOutlet UISegmentedControl *unitsSegmentedControl;
}
- (IBAction)unitsChanged:(id)sender;

- (void)rememberSelectedProgram:(NSString *)segueName;

- (void)chooseSavedProgram;

@end
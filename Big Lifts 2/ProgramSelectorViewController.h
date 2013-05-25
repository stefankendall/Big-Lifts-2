@interface ProgramSelectorViewController : UITableViewController {
    __weak IBOutlet UISegmentedControl *unitsSegmentedControl;
    NSDictionary *segueToProgramNames;
}
- (IBAction)unitsChanged:(id)sender;

- (void)rememberSelectedProgram:(NSString *)segueName;

- (void)chooseSavedProgram;

@end
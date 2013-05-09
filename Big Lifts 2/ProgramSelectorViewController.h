@interface ProgramSelectorViewController : UITableViewController
{
    __weak IBOutlet UISegmentedControl *unitsSegmentedControl;
}
- (IBAction)unitsChanged:(id)sender;

@end
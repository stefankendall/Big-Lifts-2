#import "LikeViewController.h"

@implementation LikeViewController

- (void)tableView:(UITableView *)tableView didSelectRowAtIndexPath:(NSIndexPath *)indexPath {
    UITableViewCell *cell = [self tableView:tableView cellForRowAtIndexPath:indexPath];
    if([cell viewWithTag:1]){
        [self shareOnFacebook];
    }
}

- (void)shareOnFacebook {

}


@end
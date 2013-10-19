extern int kPurchaseOverlayTag;

@interface PurchaseOverlay : UIView
{}
@property (weak, nonatomic) IBOutlet UIButton *buyImage;
@property (weak, nonatomic) IBOutlet UIActivityIndicatorView *loadingIndicator;
@property (weak, nonatomic) IBOutlet UILabel *price;

- (void) setLoading: (BOOL) loading;

@end
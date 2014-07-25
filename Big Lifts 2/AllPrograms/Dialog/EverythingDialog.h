@interface EverythingDialog : NSObject
@property(nonatomic) NSInteger noButtonIndex;
@property(nonatomic) NSInteger yesButtonIndex;

- (void)show;
@end
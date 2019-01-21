#import <UIKit/UIKit.h>
#import <EXBlur/EXBlurEffectWithAmount.h>

@interface EXBlurView : UIView

@property (nonatomic, copy) NSString *blurType;
@property (nonatomic, copy) NSNumber *blurAmount;

@property (nonatomic, strong) EXBlurEffectWithAmount *blurEffect;
@property (nonatomic, strong) UIVisualEffectView *blurEffectView;

- (void)updateBlurEffect;
@end

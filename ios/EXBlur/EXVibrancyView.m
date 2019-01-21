#import <EXBlur/EXBlurView.h>
#import <EXBlur/EXVibrancyView.h>

@interface EXVibrancyView ()

@property (nonatomic, strong) UIVibrancyEffect *vibrancyEffect;
@property (nonatomic, strong) UIVisualEffectView *vibrancyEffectView;

@end

@implementation EXVibrancyView

- (instancetype)initWithFrame:(CGRect)frame {
    if (self = [super initWithFrame:frame]) {
        self.vibrancyEffectView = [[UIVisualEffectView alloc] init];
        self.vibrancyEffectView.frame = frame;
        [self updateVibrancyEffect];

        [self.blurEffectView.contentView addSubview:self.vibrancyEffectView];
    }

    return self;
}

- (void)layoutSubviews
{
    [super layoutSubviews];
    self.vibrancyEffectView.frame = self.bounds;
}

- (void)insertSubview:(UIView *)view atIndex:(NSInteger)index {
    [self.vibrancyEffectView.contentView addSubview:(UIView*)view];
}

- (void)updateBlurEffect
{
  [super updateBlurEffect];
  [self updateVibrancyEffect];
}

- (void)updateVibrancyEffect
{
  self.vibrancyEffect = [UIVibrancyEffect effectForBlurEffect:self.blurEffect];
  self.vibrancyEffectView.effect = self.vibrancyEffect;
}

@end

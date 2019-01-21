#import <UIKit/UIKit.h>

@interface EXBlurEffectWithAmount : UIBlurEffect
@property (nonatomic, strong) NSNumber *blurAmount;

+ (instancetype)effectWithStyle:(UIBlurEffectStyle)style andBlurAmount:(NSNumber*)blurAmount;
@end

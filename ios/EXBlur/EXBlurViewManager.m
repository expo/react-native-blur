#import <EXBlur/EXBlurViewManager.h>
#import <EXBlur/EXBlurView.h>
#import <EXCore/EXUIManager.h>

@interface EXBlurViewManager ()

@property (weak, nonatomic) EXModuleRegistry *moduleRegistry;

@end

@implementation EXBlurViewManager

EX_EXPORT_MODULE(BlurViewManager);

- (NSString *)viewName
{
  return @"BlurView";
}

- (UIView *)view
{
    return [[EXBlurView alloc] init];
}

EX_VIEW_PROPERTY(blurType, NSString *, EXBlurView)
{
  [view setBlurType:value];
}

EX_VIEW_PROPERTY(blurAmount, NSNumber *, EXBlurView)
{
  [view setBlurAmount:value];
}

EX_EXPORT_METHOD_AS(updateProps,
                    updateProps:(NSDictionary *)props
                    onViewOfId:(id)viewId
                    resolve:(EXPromiseResolveBlock)resolver
                    reject:(EXPromiseRejectBlock)rejecter)
{
  [[_moduleRegistry getModuleImplementingProtocol:@protocol(EXUIManager)] addUIBlock:^(id view) {
    if ([view isKindOfClass:[EXBlurView class]]) {
      EXBlurView *blurView = view;
      if (props[@"blurAmount"]) {
        [blurView setBlurAmount:props[@"blurAmount"]];
      }
      if (props[@"blurType"]) {
        [blurView setBlurType:props[@"blurType"]];
      }
      [blurView updateBlurEffect];
      resolver([NSNull null]);
    } else {
      rejecter(@"E_INVALID_VIEW", @"Invalid view found for requested tag", nil);
    }
  } forView:viewId ofClass:[EXBlurView class]];
}

- (void)setModuleRegistry:(EXModuleRegistry *)moduleRegistry {
  _moduleRegistry = moduleRegistry;
}

@end

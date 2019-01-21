#import <EXBlur/EXVibrancyViewManager.h>
#import <EXBlur/EXVibrancyView.h>
#import <EXCore/EXUIManager.h>

@interface EXVibrancyViewManager ()

@property (weak, nonatomic) EXModuleRegistry *moduleRegistry;

@end

@implementation EXVibrancyViewManager

EX_EXPORT_MODULE(VibrancyViewManager);

- (NSString *)viewName
{
  return @"VibrancyView";
}

- (UIView *)view
{
  return [[EXVibrancyView alloc] init];
}

- (void)setModuleRegistry:(EXModuleRegistry *)moduleRegistry
{
  _moduleRegistry = moduleRegistry;
}

EX_VIEW_PROPERTY(blurType, NSString *, EXVibrancyView)
{
  [view setBlurType:value];
}

EX_VIEW_PROPERTY(blurAmount, NSNumber *, EXVibrancyView)
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
    if ([view isKindOfClass:[EXVibrancyView class]]) {
      EXVibrancyView *vibrancyView = view;
      if (props[@"blurAmount"]) {
        [vibrancyView setBlurAmount:props[@"blurAmount"]];
      }
      if (props[@"blurType"]) {
        [vibrancyView setBlurType:props[@"blurType"]];
      }
      [vibrancyView updateBlurEffect];
      resolver([NSNull null]);
    } else {
      rejecter(@"E_INVALID_VIEW", @"Invalid view found for requested tag", nil);
    }
  } forView:viewId ofClass:[EXVibrancyView class]];
}

@end

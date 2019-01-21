package expo.modules.blurview;

import android.content.Context;
import android.view.View;

import expo.core.ModuleRegistry;
import expo.core.Promise;
import expo.core.ViewManager;
import expo.core.interfaces.ExpoMethod;
import expo.core.interfaces.ExpoProp;
import expo.core.interfaces.ModuleRegistryConsumer;
import expo.core.interfaces.services.UIManager;


public class BlurViewManager extends ViewManager<BlurringView> implements ModuleRegistryConsumer {
  public static final String REACT_CLASS = "BlurView";

  public static final int defaultRadius = 10;
  public static final int defaultSampling = 10;

  private ModuleRegistry mModuleRegistry;

  @Override
  public String getName() {
    return REACT_CLASS;
  }

  @Override
  public BlurringView createViewInstance(Context ctx) {
    BlurringView blurringView = new BlurringView(ctx);
    blurringView.setBlurRadius(defaultRadius);
    blurringView.setDownsampleFactor(defaultSampling);
    return blurringView;
  }

  @Override
  public ViewManagerType getViewManagerType() {
    return ViewManagerType.SIMPLE;
  }

  @ExpoProp(name = "blurRadius")
  public void setRadius(BlurringView view, int radius) {
    view.setBlurRadius(radius);
    view.invalidate();
  }

  @ExpoProp(name = "overlayColor")
  public void setColor(BlurringView view, int color) {
    view.setOverlayColor(color);
    view.invalidate();
  }

  @ExpoProp(name = "downsampleFactor")
  public void setDownsampleFactor(BlurringView view, int factor) {
    view.setDownsampleFactor(factor);
  }

  @ExpoProp(name = "viewRef")
  public void setViewRef(final BlurringView view, int viewRef) {
    mModuleRegistry.getModule(UIManager.class).addUIBlock(viewRef, new UIManager.UIBlock<View>() {
      @Override
      public void resolve(View viewToBlur) {
        view.setBlurredView(viewToBlur);
      }

      @Override
      public void reject(Throwable throwable) {
        // do nothing
      }
    }, View.class);
  }

  @Override
  public void setModuleRegistry(ModuleRegistry moduleRegistry) {
    mModuleRegistry = moduleRegistry;
  }

  @ExpoMethod
  public void startObserving(Promise promise) {
    promise.resolve(null);
  }

  @ExpoMethod
  public void stopObserving(Promise promise) {
    promise.resolve(null);
  }
}

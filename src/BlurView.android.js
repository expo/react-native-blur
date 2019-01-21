import React, { Component } from 'react';
import PropTypes from 'prop-types';
import { requireNativeViewManager, EventEmitter, NativeModulesProxy } from 'expo-core';
import { View, requireNativeComponent, DeviceEventEmitter, ViewPropTypes } from 'react-native';

const OVERLAY_COLORS = {
  light: 'rgba(255, 255, 255, 0.2)',
  xlight: 'rgba(255, 255, 255, 0.75)',
  dark: 'rgba(16, 12, 12, 0.64)',
};

class BlurView extends Component {
  componentWillMount() {
    this._eventEmitter = new EventEmitter({});
    this._eventEmitter.addListener('ReactNativeBlurError', ({ message }) => {
      throw new Error(`[ReactNativeBlur]: ${message}`);
    });
  }

  componentWillUnmount() {
    if (this._eventEmitter) {
      this._eventEmitter.removeAllListeners('ReactNativeBlurError');
      this._eventEmitter = null;
    }
  }

  overlayColor() {
    if (this.props.overlayColor != null) return this.props.overlayColor;
    return OVERLAY_COLORS[this.props.blurType] || OVERLAY_COLORS.dark;
  }

  blurRadius() {
    const { blurRadius, blurAmount } = this.props;

    if (blurRadius != null) {
      if (blurRadius > 25) {
        throw new Error(`[ReactNativeBlur]: blurRadius cannot be greater than 25! (was: ${blurRadius})`);
      }
      return blurRadius;
    }

    // iOS seems to use a slightly different blurring algorithm (or scale?).
    // Android blurRadius + downsampleFactor is approximately 80% of blurAmount.
    const equivalentBlurRadius = Math.round(blurAmount * 0.8);

    if (equivalentBlurRadius > 25) return 25;
    return equivalentBlurRadius;
  }

  downsampleFactor() {
    const { downsampleFactor, blurRadius } = this.props;
    if (downsampleFactor != null) return downsampleFactor;
    return blurRadius;
  }

  render() {
    if (this.props.children != null) {
      throw new Error(
        '[ReactNativeBlur]: BlurView cannot contain any child views on Android. ' +
        'You should use "position: absolute" on the BlurView, ' +
        'and place other views in front of it.');
    }

    const { viewRef, style } = this.props;

    return (
      <NativeBlurView
        viewRef={viewRef}
        blurRadius={this.blurRadius()}
        downsampleFactor={this.downsampleFactor()}
        overlayColor={this.overlayColor()}
        style={[
          { backgroundColor: 'transparent' },
          style,
        ]}
      />
    );
  }
}

BlurView.propTypes = {
  ...(ViewPropTypes || View.propTypes),
  blurAmount: PropTypes.number,
  blurType: PropTypes.oneOf(['dark', 'light', 'xlight']),

  blurRadius: PropTypes.number,
  downsampleFactor: PropTypes.number,
  overlayColor: PropTypes.string,
  viewRef: PropTypes.number.isRequired,
};

BlurView.defaultProps = {
  blurType: 'dark',
  blurAmount: 10,
};

const NativeBlurView = requireNativeViewManager('BlurView');

module.exports = BlurView;

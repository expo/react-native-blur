import React, { Component } from 'react';
import PropTypes from 'prop-types';
import { View, ViewPropTypes, findNodeHandle } from 'react-native';
import { NativeModulesProxy, requireNativeViewManager } from 'expo-core';

class BlurView extends Component {
  setNativeProps = nativeProps => {
    if (this._root) {
      NativeModulesProxy.BlurViewManager.updateProps(nativeProps, findNodeHandle(this._root));
    }
  };

  render() {
    return (
      <NativeBlurView
        ref={e => (this._root = e)}
        {...this.props}
        style={[{ backgroundColor: 'transparent' }, this.props.style]}
      />
    );
  }
}

BlurView.propTypes = {
  ...(ViewPropTypes || View.propTypes),
  blurType: PropTypes.oneOf(['dark', 'light', 'xlight', 'prominent', 'regular', 'extraDark']),
  blurAmount: PropTypes.number,
};

BlurView.defaultProps = {
  blurType: 'dark',
  blurAmount: 10,
};

const NativeBlurView = requireNativeViewManager('BlurView');

module.exports = BlurView;

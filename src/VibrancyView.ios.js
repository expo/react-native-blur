import React, { Component } from 'react';
import PropTypes from 'prop-types';
import { NativeModulesProxy, requireNativeViewManager } from 'expo-core';
import { findNodeHandle } from 'react-native';

export class VibrancyView extends Component {
  setNativeProps = nativeProps => {
    if (this._root) {
      NativeModulesProxy.VibrancyViewManager.updateProps(nativeProps, findNodeHandle(this._root));
    }
  };

  render() {
    return (
      <NativeVibrancyView
        {...this.props}
        style={[
          {
            backgroundColor: 'transparent',
          },
          this.props.style,
        ]}
      />
    );
  }
}

VibrancyView.propTypes = {
  blurType: PropTypes.string,
  blurAmount: PropTypes.number.isRequired,
};

VibrancyView.defaultProps = {
  blurAmount: 10,
};

const NativeVibrancyView = requireNativeViewManager('VibrancyView');

import React from "react"
import PropTypes from "prop-types"
import GoogleMapReact from 'google-map-react';

class Map extends React.Component {
  static defaultProps = {
    center: {
      lat: 52.54,
      lng: -1.77
    },
    zoom: 7
  };

  componentDidMount() {
    console.log('hello from CDM');
  }  


  render () {
    return (
      <div style={{ height: '100vh', width: '100%' }}>
        <GoogleMapReact
          bootstrapURLKeys={{ key: 'AIzaSyD3nqUGFkDrCCDA8os-XGLGCMRxRCYW0tU' }}
          defaultCenter={this.props.center}
          defaultZoom={this.props.zoom}
        >

        </GoogleMapReact>
      </div>
    );
  }
}

export default Map

import React from "react"
import PropTypes from "prop-types"
import GoogleMapReact from 'google-map-react';
import $ from 'jquery'
import Marker from 'components/Marker'

class Map extends React.Component {
  static defaultProps = {
    center: {
      // lat: 52.54,
      lat: 51.54,
      lng: -5.77
      // lng: -1.77
    },
    zoom: 7
  };

  componentDidMount() {
    console.log('hello from CDM');
    $.ajax({
      url: '/end_to_end_example_main_route.gpx',
      dataType: 'xml',
      success: function(data){
        console.log('we got' + data.getElementsByTagName('trkpt').length + 'points');
        console.log('first lat is ' + data.getElementsByTagName('trkpt')[1].getAttribute('lat'));
        console.log('first lng is ' + data.getElementsByTagName('trkpt')[1].getAttribute('lon'));
        // debugger;
      }
    });
  }  

  render () {
    return (
      <div style={{ height: '100vh', width: '100%' }}>
        <GoogleMapReact
          bootstrapURLKeys={{ key: 'AIzaSyD3nqUGFkDrCCDA8os-XGLGCMRxRCYW0tU' }}
          defaultCenter={this.props.center}
          defaultZoom={this.props.zoom}
          yesIWantToUseGoogleMapApiInternals
        >
          <Marker lat = {50.06605} lng = {-5.71292}/> 
        </GoogleMapReact>
      </div>
    );
  }
}

export default Map





import React from "react"
import PropTypes from "prop-types"
import GoogleMapReact from 'google-map-react';
import $ from 'jquery'
import Marker from 'components/Marker'

class Map extends React.Component {
  constructor(props) {
    super(props);
    this.state = { markers: {} }
  };
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
    var that = this;
    $.ajax({
      url: '/end_to_end_example_main_route.gpx',
      dataType: 'xml',
      success: function(data){
        console.log('we got' + data.getElementsByTagName('trkpt').length + 'points');
        var dataSet = data.getElementsByTagName('trkpt');
        var result = Object.keys(dataSet).map(function(key){ return [ dataSet[key].getAttribute('lat'), dataSet[key].getAttribute('lon') ]  });

        that.setState({
          markers: result
        });
      }
    });
  }  

  render () {
    if(this.state.markers.length > 0){
      var allTheMarkers = this.state.markers.map(
        function(mkr) { 
          return {foo: mkr[0]}
          // return <Marker>             // does not work
         }
      );
    }

    return (
      <div style={{ height: '100vh', width: '100%' }}>
        <GoogleMapReact
          bootstrapURLKeys={{ key: 'AIzaSyD3nqUGFkDrCCDA8os-XGLGCMRxRCYW0tU' }}
          defaultCenter={this.props.center}
          defaultZoom={this.props.zoom}
          yesIWantToUseGoogleMapApiInternals>
            <Marker lat = {52.54} lng={-5.77}   />
        </GoogleMapReact>
      </div>
    );
  }
}

export default Map

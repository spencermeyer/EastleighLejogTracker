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
      lat: 54,
      lng: -1.77
    },
    zoom: 6
  };

  componentDidMount() {
    console.log('hello from CDM');
    var that = this;
    $.ajax({
      url: '/end_to_end_example_main_route_965nodes.gpx',
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

    $.ajax({
      url: '/leader_data', 
      dataType: 'json',
      success: function(data){
        console.log('leader data', data);



  // have to match distances with progres
  // there are 965 points of markers about one per mile.
  // select the one that is nearest the mile in the total for lat and long.
      }
    })

  }

  renderMarkers() {
    if(this.state.markers.length > 1) {
      return this.state.markers.map((mkr, i) => {
        return <Marker lat = { mkr[0] } lng = { mkr[1] } />
      })
    }
  }


  render () {
    return (
      <div style={{ height: '100vh', width: '100%' }}>
        { console.log('from within return') }
        <GoogleMapReact
          bootstrapURLKeys={{ key: 'AIzaSyD3nqUGFkDrCCDA8os-XGLGCMRxRCYW0tU' }}
          defaultCenter={this.props.center}
          defaultZoom={this.props.zoom}
          yesIWantToUseGoogleMapApiInternals>
            { this.renderMarkers() }
        </GoogleMapReact>
      </div>
    );
  }
}

export default Map

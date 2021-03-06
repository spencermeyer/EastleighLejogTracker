import React from "react"
import PropTypes from "prop-types"
import GoogleMapReact from 'google-map-react';
import $ from 'jquery'
import Marker from 'components/Marker'
import ProgressMarker from 'components/ProgressMarker'

class Map extends React.Component {
  constructor(props) {
    super(props);
    this.state = { markers: {}, positions:{} }
  };
  static defaultProps = {
    center: {
      lat: 54,
      lng: -1.77
    },
    zoom: 6
  };

  componentDidMount() {
    var that = this;
    $.ajax({
      url: '/end_to_end_example_main_route_965nodes.gpx',
      dataType: 'xml',
      success: function(data){
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
        var dataWithCoordinates = data.map(function(point){
          return {'name' : point.screen_name, 'coords' : that.state.markers[point.total_miles] }
           });
        that.setState({
          positions: dataWithCoordinates
        })
      }
    })

  }

  renderMarkers() {
    if(this.state.markers.length > 1) {
      return this.state.markers.map((mkr, i) => {
        return <Marker lat = { mkr[0] } lng = { mkr[1] } key = {i}/>
      })
    }
  }

  renderPositions() {
    // have to match the distances with positions there are 965 points about one per mile
    if(this.state.positions.length > 1) {
      return this.state.positions.map((pos, i) => {
        if(pos['coords']) {
          return <ProgressMarker lat = {pos['coords'][0]} lng = {pos['coords'][1] } text = {pos['name']} key = {i}/>
        }
      })
    }
  }

  render () {
    return (
      <div style={{ height: '100vh', width: '100%' }}>
        <GoogleMapReact
          bootstrapURLKeys={{ key: 'AIzaSyCQhRgUp3DxbGV47K6g7UzWHFsfw2hFppc' }}
          defaultCenter={this.props.center}
          defaultZoom={this.props.zoom}
          yesIWantToUseGoogleMapApiInternals>
            { this.renderMarkers() }
            { this.renderPositions() }
        </GoogleMapReact>
      </div>
    );
  }
}

export default Map

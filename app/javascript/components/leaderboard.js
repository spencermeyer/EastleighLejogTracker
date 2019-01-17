import React from "react"
import PropTypes from "prop-types"

class Leaderboard extends React.Component {
  constructor(props) {
    super(props);
    this.state = {}
  };
  static defaultProps = {};

  componentDidMount() {
    console.log('LeaderBoard Did Mount');
    var that = this;
    $.ajax({
      url: '/leader_data',
      dataType: 'json',
      success: function(data){
        console.log('we got' + data.getElementsByTagName('trkpt').length + 'points');
        // var dataSet = data.getElementsByTagName('trkpt');
        // var result = Object.keys(dataSet).map(function(key){ return [ dataSet[key].getAttribute('lat'), dataSet[key].getAttribute('lon') ]  });

        // that.setState({
        //   markers: result
        // });
        // TODO
      }
    });
  }

  renderLeaderTable() {
    //  make a table row for each data, in order.
  }

  render () {
    return (
      <div className='leaderboard'>
        <h2>Individual Leaderboard</h2>
        <table>

        </table>
      </div>
    );
  }
}

export default LeaderBoard

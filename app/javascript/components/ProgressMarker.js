import React from "react"
import PropTypes from "prop-types"
class ProgressMarker extends React.Component {
  render () {
    return (
      <div className='progressmarker'>
        {this.props.text}
      </div>
    );
  }
}

export default ProgressMarker

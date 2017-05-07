/**
 * Created by kim on 2017-05-07.
 */

import React from 'react';
import {connect} from 'react-redux'
import Header from './../components/Header';
import Footer from './../components/Footer';
import App from './../components/App';
import '../styles/AppContainer.css'
import * as actions from '../actions/';

class AppContainer extends React.Component {

    render() {
        return (
            <div className="app-container container-fluid">
                <div className="row">
                    <Header/>
                </div>
                <div className="row">
                    <div className="col-sm-1"></div>
                    <div className="col-sm-10">
                        <App connected={this.props.connected} connectedUpdate={this.props.connectedUpdate}/>
                    </div>
                    <div className="col-sm-1"></div>
                </div>
                <div className="row">
                    <Footer />
                </div>
            </div>
        );
    }
}

AppContainer.propTypes = {}

function mapStateToProps(state) {
    return {
        connected: state.app.get("connected")
    }
}

const mapDispatchToProps = (dispatch) => {
    return {
        connectedUpdate: (connectedMsg) => {
            dispatch(actions.pengineConnected(connectedMsg))
        }
    }
}

export default connect(
    mapStateToProps,
    mapDispatchToProps
)(AppContainer)

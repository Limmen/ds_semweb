/**
 * Created by kim on 2017-05-07.
 */

import React from 'react';
import {Router, Route, IndexRedirect} from 'react-router'

import App from './../containers/AppContainer';

/**
 * Creates the react-router given a history
 *
 * @param history
 * @returns {XML}
 */
export default (history) => {
    return(
        <Router history={history}>
            <Route path="/" component={App}>
            </Route>
        </Router>
    );
}

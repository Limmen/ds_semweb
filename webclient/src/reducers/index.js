/**
 * Created by kim on 2016-08-11.
 */

import { combineReducers } from 'redux'
import { routerReducer } from 'react-router-redux'
import {reducer as formReducer} from 'redux-form';
import app from './app'

const rootReducer = combineReducers({
    app,
    routing: routerReducer,
    form: formReducer
})

export default rootReducer

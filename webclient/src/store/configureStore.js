/**
 * Created by kim on 2017-05-07.
 */

import { applyMiddleware, createStore } from 'redux'
import rootReducer from '../reducers'
import { createLogger } from 'redux-logger'

/**
 * Creates the store of the redux app.
 *
 * @param initialState initial state
 * @returns {*} the single store of the redux app
 */
export default function configureStore() {
    const logger = createLogger();
    const store = createStore(
        rootReducer,
        applyMiddleware(logger)
    )
    return store
}

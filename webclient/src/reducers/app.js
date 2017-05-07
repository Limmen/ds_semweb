/**
 * Created by kim on 2017-05-07.
 */

import {PENGINE_CONNECTED} from '../constants/ActionTypes'
import {Map} from 'immutable'

/**
 * Initialstate
 */
// eslint-disable-next-line
const initialState = Map(
    {
        connected: "no"
    }
)

/**
 * Takes an action and a given state and returns a new state
 *
 * @param state old state
 * @param action action
 * @returns {*} new state
 */
export default function game(state = initialState, action) {
    switch (action.type) {
        case PENGINE_CONNECTED:
            return state.set("connected", action.connectedMsg);
        default:
            return state
    }
}

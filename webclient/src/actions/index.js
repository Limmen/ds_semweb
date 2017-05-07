/**
 * Created by kim on 2016-08-11.
 */

import * as types from '../constants/ActionTypes'

export function pengineConnected(connectedMsg) {
    return {
        type: types.PENGINE_CONNECTED,
        connectedMsg
    }
}
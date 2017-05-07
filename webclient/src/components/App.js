/**
 * Created by kim on 2017-05-07.
 */

import React, {Component} from 'react';
import PropTypes from 'prop-types';
import '../styles/App.css';
import Pengine from './../lib/pengines';
import Console from 'react-console-component';
import 'react-console-component/main.css';

const pengine = new Pengine({
    oncreate: handleCreate,
    onsuccess: handleSuccess,
    onfailure: handleFailure,
    onerror: handleError,
    onprompt: handlePrompt,
    onoutput: handleOutput,
    onstop: handleStop,
    onabort: handleAbort,
    ondestroy: handleDestroy,
    destroy: false
});

function handleCreate() {
    connectedUpdate("yes, pengine id: " + this.id);
}

function handleSuccess() {
    for (let i = 0; i < this.data[0].length; i++) {
        cons.log(variables.charAt(i) + " = " + this.data[0][i]);
    }
    if (this.more)
        cons.log("more solutions exist, enter ; to find");
    cons.return();
}

function handleFailure() {
    cons.log("false");
    cons.return();
}

function handleError() {
    cons.log("error: " + this.data);
    cons.return();
}

function handlePrompt() {
    console.log("prompt, data:" + this.data + " id: " + this.id);
}

function handleOutput() {
    console.log("output, data: " + this.data + " id: " + this.id);
}

function handleStop() {
    console.log("stop, id: " + this.id);
}

function handleAbort() {
    console.log("abort, id: " + this.id);
}

function handleDestroy() {
    connectedUpdate("no");
}
let cons;
let variables;
let connectedUpdate;
class App extends Component {
    eval(text) {
        cons = this.refs.console;
        let vars = text.replace(/[^A-Z]/g, '');
        let varlist = "";
        for (let i = 0; i < vars.length; i++) {
            if (varlist.length > 0)
                varlist = varlist + ",";
            varlist = varlist + vars.charAt(i);
        }
        if (text.charAt(text.length - 1) === ".")
            text = text.slice(0, -1);
        if (text === ";")
            pengine.next()
        else {
            variables = vars;
            pengine.ask(text, {
                template: "[" + varlist + "]"
            });
        }
    }

    render() {
        connectedUpdate = this.props.connectedUpdate;
        return (
            <div className="app-component">
                <div className="col-sm-2"/>
                <div className="col-sm-8">
                    <p><span className="connected-label">Ontology: </span><a href="ontology/ds_ontology.owl">Click to download</a></p>
                    <p><span className="connected-label">Connected: </span> {this.props.connected}</p>
                    <Console ref="console" handler={this.eval.bind(this)} autofocus={true}/>
                </div>
                <div className="col-sm-2"/>
            </div>
        );
    }
}
App.displayName = 'App';
App.propTypes = {
    connected: PropTypes.object.isRequired,
    connectedUpdate: PropTypes.func.isRequired
}
export default App;

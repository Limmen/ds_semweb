/**
 * Created by kim on 2017-05-07.
 */
import React from 'react';
import './../styles/Header.css';

class Header extends React.Component {

    render() {
        return(
            <div className="header-component">
                        <h1 className="title-text">Pengine connected to DS_Reasoner</h1>
            </div>
        );
    }
}
Header.displayName = 'Header';
export default Header;

# ds_semweb

## Description

A simple ontology and reasoner for distributed systems theory.

## Usage

    $ swipl

    ?- ['ds_reasoner'].

    ?- run_tests.
    
    ?- ?- reducible('http://www.limmen.kth.se/ontologies/ds_ontology#EventuallyWeakFailureDetector', X).
       X = 'http://www.limmen.kth.se/ontologies/ds_ontology#EventualLeaderElector' ;
       X = 'http://www.limmen.kth.se/ontologies/ds_ontology#EventuallyPerfectFailureDetector' ;
       X = 'http://www.limmen.kth.se/ontologies/ds_ontology#WeakFailureDetector' ;
       false.

## Author

Kim Hammar

<kimham@kth.se>

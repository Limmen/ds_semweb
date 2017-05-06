# ds_semweb

## Description

A simple ontology and reasoner for distributed systems theory.

## Usage

    $ swipl

    ?- ['ds_reasoner'].

    ?-  setof(X, reducible('http://www.limmen.kth.se/ontologies/ds_ontology#EventuallyWeakFailureDetector', X), Y).
    Y = ['http://www.limmen.kth.se/ontologies/ds_ontology#Detector',
         'http://www.limmen.kth.se/ontologies/ds_ontology#EventualLeaderElector',
         'http://www.limmen.kth.se/ontologies/ds_ontology#EventuallyDetector',
         'http://www.limmen.kth.se/ontologies/ds_ontology#EventuallyPerfectFailureDetector',
         'http://www.limmen.kth.se/ontologies/ds_ontology#EventuallyStrongFailureDetector',
         'http://www.limmen.kth.se/ontologies/ds_ontology#EventuallyWeakFailureDetector',
         'http://www.limmen.kth.se/ontologies/ds_ontology#LeaderElector',
         'http://www.limmen.kth.se/ontologies/ds_ontology#PerfectFailureDetector',
         'http://www.limmen.kth.se/ontologies/ds_ontology#StrongDetector',
         'http://www.limmen.kth.se/ontologies/ds_ontology#WeakFailureDetector'].

## Author

Kim Hammar

<kimham@kth.se>

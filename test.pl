:- use_module(library(semweb/rdf_db)).

test(X,Y,Z):-
    rdf_load('ontology/ds_ontology.owl'),
    rdf(X, Y, Z).
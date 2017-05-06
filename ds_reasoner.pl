%% ds_reasoner.pl
%% swi-prolog
%% compile: ['ds_reasoner.pl']
%%
%% Simple reasoner API for the ds_ontology
%%
%% Author Kim Hammar limmen@github.com <kimham@kth.se>

%%%===================================================================
%%% Facts
%%%===================================================================

:- module(ds_reasoner, [
                        reducible/2,
                        solvable/2,
                        stronger_model/2,
                        equivalent_model/2,
                        algorithm_can_solve/2,
                        algorithm_stronger_than/2
                       ]).
:- use_module(library(semweb/rdf_db)).
:- rdf_load('ontology/ds_ontology.owl').

%%%===================================================================
%%% Tests
%%% run with: run_tests, or run_tests(Spec).
%%%===================================================================

:- begin_tests(ds_reasoner).

test(reducible):-
    reducible('http://www.limmen.kth.se/ontologies/ds_ontology#EventuallyWeakFailureDetector', 'http://www.limmen.kth.se/ontologies/ds_ontology#StrongDetector'),
    reducible('http://www.limmen.kth.se/ontologies/ds_ontology#EventuallyWeakFailureDetector', 'http://www.limmen.kth.se/ontologies/ds_ontology#PerfectFailureDetector'),
    reducible('http://www.limmen.kth.se/ontologies/ds_ontology#EventuallyWeakFailureDetector', 'http://www.limmen.kth.se/ontologies/ds_ontology#EventualLeaderElector'),
    reducible('http://www.limmen.kth.se/ontologies/ds_ontology#EventuallyWeakFailureDetector', 'http://www.limmen.kth.se/ontologies/ds_ontology#LeaderElector'),
    reducible('http://www.limmen.kth.se/ontologies/ds_ontology#PerfectFailureDetector', 'http://www.limmen.kth.se/ontologies/ds_ontology#Detector'),
    \+ reducible('http://www.limmen.kth.se/ontologies/ds_ontology#PerfectFailureDetector', 'http://www.limmen.kth.se/ontologies/ds_ontology#StrongDetector').

test(solvable):-
    solvable('http://www.limmen.kth.se/ontologies/ds_ontology#BestEffortBroadcast', 'http://www.limmen.kth.se/ontologies/ds_ontology#FailSilent'),
    solvable('http://www.limmen.kth.se/ontologies/ds_ontology#BestEffortBroadcast', 'http://www.limmen.kth.se/ontologies/ds_ontology#AsynchronousSystem'),
    solvable('http://www.limmen.kth.se/ontologies/ds_ontology#CausalBroadcast', 'http://www.limmen.kth.se/ontologies/ds_ontology#AsynchronousSystem'),
    \+ solvable('http://www.limmen.kth.se/ontologies/ds_ontology#TotalOrderBroadcast', 'http://www.limmen.kth.se/ontologies/ds_ontology#AsynchronousSystem'),
    solvable('http://www.limmen.kth.se/ontologies/ds_ontology#TotalOrderBroadcast', 'http://www.limmen.kth.se/ontologies/ds_ontology#FailStop'),
    solvable('http://www.limmen.kth.se/ontologies/ds_ontology#UniformSequenceConsensus', 'http://www.limmen.kth.se/ontologies/ds_ontology#SynchronousSystem'),
    solvable('http://www.limmen.kth.se/ontologies/ds_ontology#UniformSequenceConsensus', 'http://www.limmen.kth.se/ontologies/ds_ontology#PartiallySynchronousSystem'),
    solvable('http://www.limmen.kth.se/ontologies/ds_ontology#UniformSequenceConsensus', 'http://www.limmen.kth.se/ontologies/ds_ontology#FailNoisy'),
    solvable('http://www.limmen.kth.se/ontologies/ds_ontology#UniformSequenceConsensus', 'http://www.limmen.kth.se/ontologies/ds_ontology#FailStop'),
    \+ solvable('http://www.limmen.kth.se/ontologies/ds_ontology#UniformSequenceConsensus', 'http://www.limmen.kth.se/ontologies/ds_ontology#FailSilent'),
    \+ solvable('http://www.limmen.kth.se/ontologies/ds_ontology#UniformSequenceConsensus', 'http://www.limmen.kth.se/ontologies/ds_ontology#AsynchronousSystem'),
    solvable('http://www.limmen.kth.se/ontologies/ds_ontology#PerfectLink', 'http://www.limmen.kth.se/ontologies/ds_ontology#FailSilent').

test(stronger_model):-
    stronger_model('http://www.limmen.kth.se/ontologies/ds_ontology#FailStop', 'http://www.limmen.kth.se/ontologies/ds_ontology#FailNoisy'),
    stronger_model('http://www.limmen.kth.se/ontologies/ds_ontology#FailStop', 'http://www.limmen.kth.se/ontologies/ds_ontology#FailSilent'),
    stronger_model('http://www.limmen.kth.se/ontologies/ds_ontology#FailStop', 'http://www.limmen.kth.se/ontologies/ds_ontology#PartiallySynchronousSystem'),
    stronger_model('http://www.limmen.kth.se/ontologies/ds_ontology#FailNoisy', 'http://www.limmen.kth.se/ontologies/ds_ontology#FailSilent'),
    \+ stronger_model('http://www.limmen.kth.se/ontologies/ds_ontology#FailSilent', 'http://www.limmen.kth.se/ontologies/ds_ontology#FailNoisy'),
    stronger_model('http://www.limmen.kth.se/ontologies/ds_ontology#SynchronousSystem', 'http://www.limmen.kth.se/ontologies/ds_ontology#PartiallySynchronousSystem'),
    stronger_model('http://www.limmen.kth.se/ontologies/ds_ontology#SynchronousSystem', 'http://www.limmen.kth.se/ontologies/ds_ontology#FailNoisy'),
    stronger_model('http://www.limmen.kth.se/ontologies/ds_ontology#PartiallySynchronousSystem', 'http://www.limmen.kth.se/ontologies/ds_ontology#AsynchronousSystem'),
    \+ stronger_model('http://www.limmen.kth.se/ontologies/ds_ontology#PartiallySynchronousSystem', 'http://www.limmen.kth.se/ontologies/ds_ontology#SynchronousSystem').

test(equivalent_model):-
    equivalent_model('http://www.limmen.kth.se/ontologies/ds_ontology#FailSilent', 'http://www.limmen.kth.se/ontologies/ds_ontology#AsynchronousSystem'),
    equivalent_model('http://www.limmen.kth.se/ontologies/ds_ontology#FailNoisy', 'http://www.limmen.kth.se/ontologies/ds_ontology#PartiallySynchronousSystem'),
    equivalent_model('http://www.limmen.kth.se/ontologies/ds_ontology#FailStop', 'http://www.limmen.kth.se/ontologies/ds_ontology#SynchronousSystem'),
    \+ equivalent_model('http://www.limmen.kth.se/ontologies/ds_ontology#FailSilent', 'http://www.limmen.kth.se/ontologies/ds_ontology#SynchronousSystem').


test(algorithm_can_solve):-
    algorithm_can_solve('http://www.limmen.kth.se/ontologies/ds_ontology#FloodingConsensus', 'http://www.limmen.kth.se/ontologies/ds_ontology#TotalOrderBroadcast'), algorithm_can_solve('http://www.limmen.kth.se/ontologies/ds_ontology#MultiPaxos', 'http://www.limmen.kth.se/ontologies/ds_ontology#TotalOrderBroadcast'), algorithm_can_solve('http://www.limmen.kth.se/ontologies/ds_ontology#MonarchicalLeaderElection', 'http://www.limmen.kth.se/ontologies/ds_ontology#EventuallyWeakFailureDetector'), algorithm_can_solve('http://www.limmen.kth.se/ontologies/ds_ontology#MonarchicalEventualLeaderElection', 'http://www.limmen.kth.se/ontologies/ds_ontology#EventuallyWeakFailureDetector'), algorithm_can_solve('http://www.limmen.kth.se/ontologies/ds_ontology#IncreasingTimeout', 'http://www.limmen.kth.se/ontologies/ds_ontology#EventuallyStrongFailureDetector'), algorithm_can_solve('http://www.limmen.kth.se/ontologies/ds_ontology#ExcludeOnTimeout', 'http://www.limmen.kth.se/ontologies/ds_ontology#EventualLeaderElector'), algorithm_can_solve('http://www.limmen.kth.se/ontologies/ds_ontology#EagerReliableBroadcast', 'http://www.limmen.kth.se/ontologies/ds_ontology#BestEffortBroadcast'),
    \+ algorithm_can_solve('http://www.limmen.kth.se/ontologies/ds_ontology#BasicBroadcast', 'http://www.limmen.kth.se/ontologies/ds_ontology#ReliableBroadcast').

test(algorithm_stronger_than):-
    algorithm_stronger_than('http://www.limmen.kth.se/ontologies/ds_ontology#FloodingConsensus', 'http://www.limmen.kth.se/ontologies/ds_ontology#EagerReliableBroadcast'),
    algorithm_stronger_than('http://www.limmen.kth.se/ontologies/ds_ontology#EagerReliableBroadcast', 'http://www.limmen.kth.se/ontologies/ds_ontology#BasicBroadcast'),
    \+ algorithm_stronger_than('http://www.limmen.kth.se/ontologies/ds_ontology#EagerReliableBroadcast', 'http://www.limmen.kth.se/ontologies/ds_ontology#LazyReliableBroadcast'),
    \+ algorithm_stronger_than('http://www.limmen.kth.se/ontologies/ds_ontology#BasicBroadcast', 'http://www.limmen.kth.se/ontologies/ds_ontology#MultiPaxos').

:- end_tests(ds_reasoner).

%%%===================================================================
%%% Helpers
%%%===================================================================

base_uri('http://www.limmen.kth.se/ontologies/ds_ontology#').

convert_to_uri(KeyWord, Uri):-
    base_uri(X),
    atom_concat(X, KeyWord, Uri).

%%%===================================================================
%%% API
%%%===================================================================

%% True if problem P is solvable in model M
%% solvable(+-, +-).
%% solvable(P,M).
solvable(P, M):-
    rdf(P, 'http://www.limmen.kth.se/ontologies/ds_ontology#solvableIn', M).

solvable(P, M):-
    rdf(P, 'http://www.limmen.kth.se/ontologies/ds_ontology#solvableIn', Z),
    stronger_model(M, Z).

%% True if model M1 is stronger than model M2
%% stronger_model(+-, +-).
%% stronger_model(M1,M2).
stronger_model(M1, M2):-
    rdf(M1, 'http://www.limmen.kth.se/ontologies/ds_ontology#strongerModel', M2).

stronger_model(M1, M2):-
    rdf(M1, 'http://www.limmen.kth.se/ontologies/ds_ontology#strongerModel', M3),
    \+ equivalent_model(M1, M3),
    stronger_model(M3, M2).

%% True if model M1 is and model M2 are equivalent
%% equivalent_model(+-, +-).
%% equivalent_model(M1,M2).
equivalent_model(M1, M2):-
    rdf(M1, 'http://www.limmen.kth.se/ontologies/ds_ontology#strongerModel', M2),
    rdf(M2, 'http://www.limmen.kth.se/ontologies/ds_ontology#strongerModel', M1).

%% True if problem P1 is reducible to problem P2
%% solvable(+-, +-).
%% solvable(P1,P2).
reducible(P1, P2):-
    reducible(P1, P2, [P1,P2]).

%% True if problem P1 is reducible to problem P2.
%% Maintains cache Seen to avoid infinite loop in case of cyclic relations.
%% reducible(+-, +-, +).
%% reducible(P1,P2, Seen).
reducible(P1, P2, _):-
    rdf(P1, 'http://www.limmen.kth.se/ontologies/ds_ontology#problemEquivalent', P2).

reducible(P1, P2, _):-
    rdf(P1, 'http://www.limmen.kth.se/ontologies/ds_ontology#reducibleTo', P2).

reducible(P1, P2, Seen):-
    (rdf(P1, 'http://www.limmen.kth.se/ontologies/ds_ontology#reducibleTo', P3)
    ;
     rdf(P1, 'http://www.limmen.kth.se/ontologies/ds_ontology#problemEquivalent', P3)
    ),
    \+ member(P3, Seen),
    reducible(P3, P2, [P3|Seen]).

%% True if algorithm A can be used to solve problem P
%% algorithm_can_solve(+-, +-).
%% algorithm_can_solve(A,P).
algorithm_can_solve(A, P):-
    rdf(A, 'http://www.limmen.kth.se/ontologies/ds_ontology#implements', P).

algorithm_can_solve(A, P):-
    rdf(A, 'http://www.limmen.kth.se/ontologies/ds_ontology#implements', P1),
    reducible(P, P1).

%% True if algorithm Algorithm A1 is stronger than A2.
%% If the algorithms are uncomparable it is false
%% algorithm_stronger_than(+-, +-).
%% algorithm_stronger_than(A1,A2).
algorithm_stronger_than(A1, A2):-
    rdf(A2, 'http://www.limmen.kth.se/ontologies/ds_ontology#implements', P2),
    rdf(A1, 'http://www.limmen.kth.se/ontologies/ds_ontology#usesComponent', P2).

algorithm_stronger_than(A1, A2):-
    rdf(A1, 'http://www.limmen.kth.se/ontologies/ds_ontology#implements', P1),
    rdf(A2, 'http://www.limmen.kth.se/ontologies/ds_ontology#implements', P2),
    reducible(P2, P1).

algorithm_stronger_than(A1, A2):-
    rdf(A1, 'http://www.limmen.kth.se/ontologies/ds_ontology#implements', P),
    rdf(A2, 'http://www.limmen.kth.se/ontologies/ds_ontology#implements', P),
    rdf(A1, 'http://www.limmen.kth.se/ontologies/ds_ontology#implementableIn', M1),
    rdf(A2, 'http://www.limmen.kth.se/ontologies/ds_ontology#implementableIn', M2),
    stronger_model(M1, M2).


:- consult('planning_BlocksWorld.pl').


%
% Figure 17.4 - A simple means-ends planner.
%


% A simple means-ends planner
% plan(State, Goals, Plan, FinalState)
plan(State, Goals, [], State) :-    % Plan empty
	satisfied(State, Goals).        % Goals true in State


plan(State, Goals, Plan, FinalState) :-
% COMMENT / UNCOMMENT
	% append(Plan, _, _),                             % Try plans of increasing length
	append(PrePlan, [Action | PostPlan], Plan),     % Divide Plan to PrePlan, Action and PostPlan
	select(State, Goals, Goal),                   % Select a goal
	achieves(Action, Goal),                       % Relevant action
	can(Action, Condition),                 
	plan(State, Condition, PrePlan, MidState1),   % Enable Action
	apply(MidState1, Action, MidState2),          % Apply Action
	plan(MidState2, Goals, PostPlan, FinalState). % Achieve remaining goals


% satisfied(State, Goals): Goals are true in State
satisfied(State, []).

satisfied(State, [Goal | Goals]) :-
	member(Goal, State),
	satisfied(State, Goals).

select(State, Goals, Goal) :-
	member(Goal, Goals),
	\+ member(Goal, State).   % Goal not satisfied already

% achieves(Action, Goal): Goal is in add-list of Action
achieves(Action, Goal) :-
	adds(Action, Goals),
	member(Goal, Goals).

% apply(State, Action, NewState): Action executed in State produces NewState
apply(State, Action, NewState) :-
	deletes(Action, DelList),
	delete_all(State, DelList, State1), !,
	adds(Action, AddList),
	append(AddList, State1, NewState).


% delete_all(L1, L2, Diff) if Diff is set-difference of L1 and L2
delete_all([], _, []).

delete_all([X | L1], L2, Diff) :-
	member(X, L2), !,
	delete_all(L1, L2, Diff).

delete_all([X | L1], L2, [X | Diff]) :-
	delete_all(L1, L2, Diff).


/*
?- Start = [ clear(2), clear(4), clear(b), clear(c), on(a, 1), on(b, 3), on(c, a) ], 
plan(Start, [on(a, b)], Plan, FinState).

 Plan = [ move(c, a, 2), move(a, 1, b) ]
 FinState = [ on(a, b), clear(1), on(c, 2), clear(a), clear(4), clear(c), on(b, 3) ]
*/


% Let us try the task in Figure 17.1. The initial state in Figure 17.1 is
% defined by the predicate statel in Figure 17.2. So the task of Figure 17.1 can be
% solved by:
%
%?- state1(Start), plan(Start, [on(a, b), on(b, c)], Plan, _).
%
% This produces a surprising answer:
%
% Plan = [ move(c, a, 2), move(b, 3, a), move(b, a, c), move(a, 1, b) ]
%
% You can test also with the goals in reversed order.
%?- state1(Start), plan(Start, [on(b, c), on(a, b)], Plan, _).


/*

With Depth-first search (1st line commented):

?- state1(Start), plan(Start, [on(b, c), on(a, b)], Plan, _).
Start = [clear(2), clear(4), clear(b), clear(c), on(a, 1), on(b, 3), on(c, a)],
Plan = [move(b, 3, c), move(b, c, 3), move(c, a, 4), move(a, 1, b), move(a, b, 2), move(b, 3, c), move(a, 2, b)] 


*/



/*

% A state in the blocks world

      c
      a   b
      = = = =
place 1 2 3 4

Next moves:

move(c, a, 2), 
    
      a c b
      = = = =
place 1 2 3 4


move(b, 3, a), 

      b
      a c 
      = = = =
place 1 2 3 4


move(b, a, c), 

        b
      a c 
      = = = =
place 1 2 3 4


move(a, 1, b) 

        a
        b
        c 
      = = = =
place 1 2 3 4



% Final state in the blocks world (the stack a,b,c could be anywhere)

      a
      b
      c   
      = = = =
place 1 2 3 4


*/






























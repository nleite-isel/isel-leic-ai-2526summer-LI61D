/*
% Fact
first(empty, empty).

first(H, mylist(H, Tail)).
*/

first([], []).

first(H, [H | Tail]).

%?- first(X, mylist(a, mylist(b, mylist(c, empty)))).
% ?- first(X, [a, b, c]).

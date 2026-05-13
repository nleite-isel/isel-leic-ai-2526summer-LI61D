Search for word [HERE]

in dump_means_ends_planner_WITH_DEBUG.txt


You can see that the planner is working on Goal = on(b,c), and that is achieved, for example, with Action = move(b,a,c):

[HERE]


### Call plan
--> Selected Action (Before calling plan): can(Action, Condition), 
Action = move(b,a,c)
Condition = [clear(b),clear(c),on(b,a)]
Goal = on(b,c)

But move(b,a,c) needs to have on(b,a), so this is the next subgoal. This subgoal leads to the planner choosing 

[HERE]



### Call plan
--> Selected Action (Before calling plan): can(Action, Condition), 
Action = move(b,3,a)
Condition = [clear(b),clear(a),on(b,3)]
Goal = on(b,a)


This explains in part why the generated plan was:

Start = [clear(2), clear(4), clear(b), clear(c), on(a, 1), on(b, 3), on(c, a)],
Plan = [move(c, a, 2), move(b, 3, a), move(b, a, c), move(a, 1, b)] 


The planner was working miopically on one goal while not relating with other goals.

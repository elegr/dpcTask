function [ J_opt, u_opt_ind ] = LinearProgramming( P, G )
%LINEARPROGRAMMING Value iteration
%   Solve a stochastic shortest path problem by linear programming.
%
%   [J_opt, u_opt_ind] = LinearProgramming(P, G) computes the optimal cost
%   and the optimal control input for each state of the state space.
%
%   Input arguments:
%
%       P:
%           A (MN x MN x L) matrix containing the transition probabilities
%           between all states in the state space for all attainable
%           control inputs. The entry P(i, j, l) represents the transition
%           probability from state i to state j if control input l is
%           applied.
%
%       G:
%           A (MN x L) matrix containing the stage costs of all states in
%           the state space for all attainable control inputs. The entry
%           G(i, l) represents the cost if we are in state i and apply
%           control input l.
%
%   Output arguments:
%
%       J_opt:
%       	A (1 x MN) matrix containing the optimal cost-to-go for each
%       	element of the state space.
%
%       u_opt_ind:
%       	A (1 x MN) matrix containing the indices of the optimal control
%       	inputs for each element of the state space.

% put your code here
    
    numberOfInputs = size(G, 2);   
    numberOfCells = size(G, 1);

    f = -ones(numberOfCells, 1);

    b = [];
    A = [];

    for u = 1:numberOfInputs
        for i = 1:numberOfCells
            if G(i, u) ~= Inf
                b = [b; G(i, u)];
                vec = zeros(1, numberOfCells);
                vec(i) = 1;
                A = [A; vec - squeeze(P(i,:,u))];
            end
        end
    end
      
    x = linprog(f, A, b);
    x
    
        
    
end


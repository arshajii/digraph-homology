classdef digraph
% DIGRAPH Represents a directed graph.
%
% Represents a directed graph with a binary adjacency matrix, in which no
% vertex is connected to itself (i.e. the adjacency matrix has 0s along
% its diagonal).
%
% For example the digraph:
%
% (1) ---> (2) ---> (3)
%
% would be represented by the matrix:
%
% [ 0 1 0
%   0 0 1
%   0 0 0 ]

    properties (SetAccess = private)
        AdjMatrix;
    end
    
    methods
        function DG = digraph(AdjMatrix)
            DG.AdjMatrix = logical(AdjMatrix);
        end
        
        function dim = hdim(DG, n)
            import core.dimker
            omega = DG.omega(n + 1);
            dim = dimker(DG.omega(n)) + dimker(omega) - length(omega); 
        end
        
        function count = deadnodes(DG)
            count = 0;
            for i=1:length(DG.AdjMatrix)
                if ~any(DG.AdjMatrix(i,:)) && ~any(DG.AdjMatrix(:,i))
                    count = count + 1;
                end
            end
        end
    end
    
end


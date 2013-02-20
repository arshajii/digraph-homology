classdef digraph
% DIGRAPH - Represents a directed graph
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
        
        function allowed = isallowed(DG, v)
        % ISALLOWED - Determines if the vector of vertices v represents a
        % path on this digraph.
            for i=1:(length(v)-1)
                if ~DG.AdjMatrix(v(i), v(i+1))
                    allowed = false;
                    return
                end
            end
            allowed = true;
        end
        
        function vecs = aspace(DG, n)
            b = counter(n+1, length(DG.AdjMatrix));
            r = 1;
            vecs = zeros(size(b));
            for i=1:(length(DG.AdjMatrix)^(n+1))
                if DG.isallowed(b(i,:))
                    vecs(r,:) = b(i,:);
                    r = r + 1;
                end
            end
            vecs = vecs(1:r-1,:);
        end
        
        function basis = omega(DG, n)
            aspace = DG.aspace(n);
            
            if isempty(aspace)
                basis = {};
                return
            end
            
            boundarized = boundarize(DG.aspace(n)); 
            nonalloweds = cell(1, sum(cellfun(@(v)size(v,1), boundarized)));  % elements that should cancel out
            r = 1;
            for i=1:length(boundarized)
                for col=(boundarized{i}')
                    v = col(2:end)';
                    if ~DG.isallowed(v)
                        b = true;
                        for k=1:r-1  % check if v has already been encountered
                            if nonalloweds{k} == v
                                b = false;
                                break
                            end
                        end
                        
                        if b  % i.e. if "v is not already in this list"
                            nonalloweds{r} = v;
                            r = r + 1;
                        end
                    end
                end
            end
            nonalloweds = nonalloweds(1:r-1);
            
            X = null(gennull(boundarized, nonalloweds), 'r');
            omega_raw = vertcat(aspace);  % no coefficients
            
            basis = cell(1, size(X, 2));
            
            r = 1;
            for col=X
                elem = [col omega_raw];
                basis{r} = elem(elem(:, 1) ~= 0, :);
                r = r + 1;
            end
        end
        
        function dim = hdim(DG, n)
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


function dg = g(n, p)
% G Creates a "random" directed graph with n nodes and edge-probability p.
% In other words, this function generates the Erdos-Renyi graph G(n,p).

    A = zeros(n, n);
    
    for i=1:n
        for j=1:n
            if i ~= j
                A(i,j) = (rand() < p);
            end
        end
    end
    
    dg = digraph(A);
end


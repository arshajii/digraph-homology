function vecs = aspace(DG, n)
% ASPACE - Computes the basis of the A_n vector space for this digraph. 
% Returns a matrix in which each row is a coefficient-less element of this
% basis. For example, a digraph with allowed paths 1-2-4 and 1-3-4 would,
% for n=2, produce the matrix
%
% [ 1 2 3
%   1 3 4 ]

    b = core.counter(n+1, length(DG.AdjMatrix));
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


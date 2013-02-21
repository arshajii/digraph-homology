function vecs = aspace(DG, n)
% ASPACE Computes the basis of the A_n vector space for this digraph. 
% Returns a matrix in which each row is a coefficient-less element of this
% basis. For example, a digraph with allowed paths 1-2-4 and 1-3-4 would,
% for n=2, produce the matrix:
%
% [ 1 2 3
%   1 3 4 ]

    len = length(DG.AdjMatrix);

    if n == 0
        vecs = (1:len)';
        return
    end

    prev = DG.aspace(n-1);    
    vecs = zeros(sum(sum(DG.AdjMatrix(prev(:,end),:))), n+1);
    r = 1;
    
    for row=prev'
        v = 1:len;
        v = v(DG.AdjMatrix(row(end),:));
        nrows = length(v);
        
        vecs(r:r+nrows-1,:) = [repmat(row', nrows, 1) v'];
        r = r + nrows;
    end
end


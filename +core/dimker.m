function dim = dimker(basis)
% DIMKER Computes the dimension of the kernel of a vector space, given by
% its basis. Used to compute dim ker \Omega_n.
%
% The basis is a cell array of matrices, each representing an vertex
% polynomial. For example, the polynomial 3(1)(2) - 2(3)(4) would be
% represented by the matrix:
%
% [ 3 1 2
%  -2 3 4 ]
%
% Hence, the argument of this function should consist of a cell array of
% such matrices.

    boundarized = cell(length(basis), 1);  % boundary of each element of basis
    r = 1;
    for i=1:length(basis)
        [nrows, ncols] = size(basis{i});
        m = zeros(nrows * (ncols - 1), ncols - 1);
        for row=(basis{i}')
            v = row';
            c = v(1);
            b = core.boundary(v(2:end));
            m(r:r+size(b,1)-1,:) = [b(:,1).*c b(:,2:end)];
            r = r + size(b,1);
        end
        boundarized{i} = m(m(:,1) ~= 0, :);
    end
    
    nonalloweds = cell2mat(boundarized);
    A = core.gennull(boundarized, unique(nonalloweds(:,2:end), 'rows'));
    
    if issparse(A)
        dim = size(null(A,'r'), 2);  % rank does not work for sparse matrices
    else
        dim = size(A, 2) - rank(A);
    end
end


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

    boundarized = cell(1, length(basis));  % boundary of each element of basis
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
    
    nonalloweds = cell(1, sum(cellfun(@(v)size(v,1), boundarized)));  % elements that should cancel out
    r = 1;
    for i=1:length(boundarized)
        for col=(boundarized{i}')
            v = col(2:end)';
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
    nonalloweds = nonalloweds(1:r-1);
    
    A = core.gennull(boundarized, nonalloweds);
    dim = size(A, 2) - rank(A);
end


function basis = omega(DG, n)
% OMEGA Computes the basis of the \Omega_n vector space for this digraph.
% Returns a cell array of matrices, each representing a generator of this
% basis. For instance, the vector space "span{1(1 2) - 2(3 4), 4(5 6)}"
% would be represented by the cell array:
%
% / [ 1 1 2     [4 5 6 ] \
% \  -2 3 4 ] ,          /

    aspace = DG.aspace(n);

    if isempty(aspace)
        basis = {};
        return
    end

    boundarized = core.boundarize(DG.aspace(n));
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

    X = null(core.gennull(boundarized, nonalloweds), 'r');
    omega_raw = vertcat(aspace);  % no coefficients

    basis = cell(1, size(X, 2));

    r = 1;
    for col=X
        elem = [col omega_raw];
        basis{r} = elem(elem(:, 1) ~= 0, :);
        r = r + 1;
    end
end


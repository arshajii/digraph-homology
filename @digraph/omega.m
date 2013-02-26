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

    boundarized = core.boundarize(aspace);
    
    nonalloweds = cell2mat(boundarized);
    nonalloweds = unique(nonalloweds(:,2:end), 'rows');
    
    X = null(core.gennull(boundarized, nonalloweds(logical(~DG.isallowed(nonalloweds)),:)), 'r');
    basis = cell(1, size(X, 2));

    r = 1;
    for col=X
        elem = [col aspace];
        basis{r} = elem(elem(:, 1) ~= 0, :);
        r = r + 1;
    end
end


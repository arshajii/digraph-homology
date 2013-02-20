function blist = boundarize(aspace)
% BOUNDARIZE Generates list of boundaries for given A-space matrix.
%
% Argument is a matrix in which each row represents a coefficient-less
% element of the A-space of a certain digraph. This function produces a
% cell array in which each element is the boundary of a row of this
% matrix.

    n = size(aspace, 1);
    blist = cell(1, n);
    for i=1:n
        blist{i} = boundary(aspace(i,:));
    end
end
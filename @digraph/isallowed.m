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


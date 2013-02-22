function allowed = isallowed(DG, v)
% ISALLOWED Determines if the vector of vertices v represents a path
% on this digraph.

    if size(v,1) > 1
        allowed = zeros(size(v,1),1);
        for i=1:size(v,1)
            allowed(i) = DG.isallowed(v(i,:));
        end
        return
    end

    for i=1:(length(v)-1)
        if ~DG.AdjMatrix(v(i), v(i+1))
            allowed = false;
            return
        end
    end
    allowed = true;
end


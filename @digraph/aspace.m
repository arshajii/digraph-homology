function vecs = aspace(DG, n)
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
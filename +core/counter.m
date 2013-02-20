function prod = counter(n, k)
% COUNTER - Returns the basis of Z^n mod k in the form of a matrix. Each
% row of this matrix represents an element of the basis.

    v = int16(ones(1, n));
    prod = zeros(k ^ n, n);
    r = 1;
    while ~all(v == k)
        prod(r,:) = v;
        v = step(v, k, length(v));
        r = r + 1;
    end
    prod(r, :) = v;
end

function next = step(v, k, pos)
    if v(pos) == k
        v(pos) = 1;
        next = step(v, k, pos - 1);
    else
        v(pos) = v(pos) + 1;
        next = v;
    end
end


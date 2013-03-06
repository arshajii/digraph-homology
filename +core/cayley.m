function dg = cayley(d, p)
% CAYLEY Generates a Cayley digraph based on the group Z^d mod p.

    n = p ^ d;
    group = counter(d, p);
    %gens = group(randperm(n, d),:);
    gens = eye(d);
    
    A = zeros(n);
    for i=1:n
        for j=1:n
            if i ~= j
                for k=1:d
                    if mod(group(i,:) + gens(k,:), p) == group(j,:)
                        A(i,j) = true;
                        break
                    end
                end
            end
        end
    end
    
    dg = digraph(A);
end

function prod = counter(d, p)
% COUNTER Returns the basis of Z^d mod p in the form of a matrix. Each
% row of this matrix represents an element of the basis.

    n = p ^ d;
    v = int16(zeros(1, d));
    prod = zeros(n, d);
    for i=1:n
        prod(i,:) = v;
        if i ~= n
            v = step(v, p-1, d);
        end
    end
end

function next = step(v, k, pos)
    if v(pos) == k
        v(pos) = 0;
        next = step(v, k, pos - 1);
    else
        v(pos) = v(pos) + 1;
        next = v;
    end
end
function result = boundary(v)
% BOUNDARY - Takes an element of V^n and returns its 'boundary matrix'.
% For example, for an input of
%
% [ 1 2 3 4 ]
%
% The following matrix will be produced:
%
% [ 1 2 3 4
%  -1 1 3 4
%   1 1 2 4
%  -1 1 2 3 ]
%
% where the first element of each row represents a coefficient and the
% rest of the row represents an element of V^{n-1}. In other words, the
% first column of this matrix is one of only coefficients.

    n = length(v);
    k = 1;
    result = int16(zeros(n));
    
    for i=1:n
        row = [(-1)^(i+1) v(1,1:i-1) v(1,i+1:n)];
        
        b = true;
        for j=2:(n-1)
            if row(j) == row(j+1)
                b = false;
                break
            end
        end
        
        if b
            result(k,:) = row;
            k = k + 1;
        end
    end
    
    result = result(1:(k-1), :);
end


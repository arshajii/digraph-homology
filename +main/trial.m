function result = trial(n, h, dp, autoquit)
% TRIAL Performs a single trial of computing dim H_n for random graphs of
% given size.
%
% Arguments:
% n - Number of nodes each random graph will have; this will remain
% constant as p varies from 0 to 1 in increments of dp. At each stage, the
% homology dimension of a random graph G(n,p) will be calculated.
% h - The homology group whose dimension will be calculated, e.g. 1 for
% H_1, 2 for H_2 etc.
% dp - Step-size of p, defaults to 0.025.
% autoquit - Number of 0s after initial non-zero dimension after which the
% trial should automatically end, defaults to 4. A value of -1 will turn
% off this feature.
%
% This function returns the result of the trial in the form of a matrix
% consisting of rows of length 2, the first elements of which are the
% p-values, and the second elements of which are the homology dimensions.

    switch nargin
        case 2
            result = main.trial(n, h, 0.025, 4);
            return
        case 3
            result = main.trial(n, h, dp, 4);
            return
    end

    pvals = 0:dp:1;
    result = zeros(length(pvals), 2);
    count = 0;
    b = false;  % whether a non-zero dimension has been encountered
    
    r = 1;
    for p=pvals
        dg = core.g(n, p);
        dim = dg.hdim(h);
        result(r,:) = [p dim];
        r = r + 1;
        
        fprintf('%.3f\t%d\n', p, dim);
        
        % auto-quit:
        if dim > 0
            b = true;
            count = 0;
        else
            count = count + 1;
        end
        
        if count == autoquit && b
            break
        end
    end
    result = result(1:r-1,:);
end


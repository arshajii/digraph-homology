function trial(n, h, dp, autoquit)
% RUN - Performs a single trial of computing dim H_n for random graphs of
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

    switch nargin
        case 2
            main.trial(n, h, 0.025, 4);
            return
        case 3
            main.trial(n, h, dp, 4);
            return
    end

    count = 0;
    b = false;  % whether a non-zero dimension been encountered
    for p=0:dp:1
        dg = core.g(n, p);
        dim = dg.hdim(h);
        
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
end


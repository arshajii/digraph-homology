for d=1:3
    for p=2:10
        fprintf('Z^%d mod %d\n', d, p);
        
        for i=1:5
            dg = core.cayley(d,p);
            disp(dg.hdim(1));
        end
    end
end
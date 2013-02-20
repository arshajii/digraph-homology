function A = gennull(boundarized, nonalloweds)
    A = zeros(length(nonalloweds), length(boundarized));
    for i=1:length(nonalloweds)
        v = nonalloweds{i};
        
        for j=1:length(boundarized)
            c = 0;
            generator = boundarized{j};
            covered = zeros(1, size(generator,1));  % rows that we cover in next loop
            
            for k=1:size(generator,1)
                if v == generator(k,2:end)
                    c = c + generator(k,1);
                    covered(k) = true;
                else
                    covered(k) = false;
                end
            end
                    
            A(i,j) = c;
            generator(logical(covered),:) = [];  % delete covered rows (performance boost)
            boundarized{j} = generator;  % reassign modified matrix
        end
    end
end


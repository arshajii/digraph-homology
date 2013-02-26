function A = gennull(boundarized, nonalloweds)
% GENNULL Generates the "null" matrix for a certain "boundarized" vector
% space basis and a cell array of nonallowed terms (terms that should
% cancel). This function is used in OMEGA and DIMKER.

    A = zeros(size(nonalloweds,1), length(boundarized));

    for i=1:length(boundarized)
        generator = boundarized{i};
        for j=1:size(generator,1)
            v = generator(j,:);
            [~,indx] = ismember(v(2:end), nonalloweds, 'rows');
            
            if indx
                A(indx, i) = A(indx, i) + v(1);
            end
        end
    end
end


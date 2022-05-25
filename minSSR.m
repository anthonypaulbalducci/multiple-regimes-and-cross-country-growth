function [minimum_SSR, index_value, graph_SSR]=minSSR(X, Y, Z)
% set counter and starting variables
i = 0;
j = size(X, 1);
minimum_SSR = 100;
current_SSR = 0;
index_value = 0;

for i = 0:size(X, 1)
% i and k are counters for traversing 'up' (i) and 'down' (k) the set.
    k = i + 1; 
    
        if i == 0
            current_set_SSR = 0;    
        else
            current_set_SSR = getSSR(X (1:i,:), Y (1:i,:));        
        end
        
        if k > size(X,1)
            current_set_compliment_SSR = 0;
        else  
            current_set_compliment_SSR = getSSR(X (k:j,:), Y (k:j,:));    
        end

        set_SSR = current_set_SSR + current_set_compliment_SSR;
        
        if i == 0
        else
            graph_SSR (i) = set_SSR;
        end
        
        if set_SSR < minimum_SSR 
            minimum_SSR = set_SSR;
            index_value = i;
        else
        end
end
% We can't have splitting at an index of 0 (no such index exists, so 1 is
% assumed.

        if index_value == 0, minimum_SSR == 0;
            disp(['trouble']);
            graph_SSR = 0;
        else
        end


        if index_value == 0;
           index_value = 1;
           
           % If we get an index of zero it didn't survive the minimum_SSR =
           % set_SSR routine above.
           
           minimum_SSR = 0;
        else
        end
        
disp(['The minimum SSR of ', num2str(minimum_SSR), ' occurs at an index value of ', num2str(index_value), '.']);
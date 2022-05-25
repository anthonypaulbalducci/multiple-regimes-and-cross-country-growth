function optimal_tree = Xvalidate (data_tree)

tic % start the clock

num_of_trees = size(data_tree, 2); % determine the number of trees
num_of_t_nodes = 0; % start with no terminal nodes
t_node_counter = 0; % start with no terminal nodes in the outer loop counter
num_of_t_node_pairs = 0; % start with no terminal node pairs
t_parents = []; % and no terminal node parents
totalXvalSSR = 0; % start with no value for total Xval SSR

for k = 1:num_of_trees % one loop for each pruned tree
    
    current_tree = data_tree(k).tree;

    tree_counter = k;
    tree_size = size(current_tree, 2);
    %%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%
    % I know it is a bit repetitive here, but it makes the outer loop easier
    % and lowers the number of required inputs.
    for i = 1:tree_size
               if current_tree(i).STOP == 1 % identify terminal nodes
               t_node_counter = t_node_counter + 1; % add one to the counter 
               else
               end
    end

% smaller inside loop
for i = 1:tree_size
           if current_tree(i).STOP == 1 % identify terminal nodes
               if i == 1 % is root node
                    t_pair_parent = 1;
                    else    
                    num_of_t_nodes = num_of_t_nodes + 1; % add one to the counter 
                     %%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%5
                        switch (rem(i,2)) % determine if terminal node's partner is also terminal
                            case 0, % If the node is a left node, its partner is to the right
                                if current_tree(i + 1).STOP == 1
                                     partner_also_terminal = 1; % if its partner is also terminal
                                     t_pair_parent = i / 2; % find the pairs parents
                                     num_of_t_node_pairs = num_of_t_node_pairs + 1;    
                                else
                                partner_also_terminal = 0; % partner not terminal
                                end
                        
                             case 1, % If the node is a right node, its partner is to the left
                                 if current_tree(i - 1).STOP == 1
                                     partner_also_terminal = 1; % if its partner is also terminal 
                                     t_pair_parent = (i - 1) / 2;
                                     num_of_t_node_pairs = num_of_t_node_pairs + 1;    
                                 else
                                 partner_also_terminal = 0; % partner not terminal
                                 end
                             otherwise,
                             end
                 end
                 %%%%%%%%%%%%%%%%%%%%%%%
                    if partner_also_terminal == 1
                        t_parents = union(t_pair_parent, t_parents);
                    else
                    end
             else  % from 'if data_tree(i)... above.   
             end  % from 'if data_tree(i)... above. 
                    
        end % from for..loop
disp(['-------------------------------']);
disp(['Tree - ',num2str(tree_counter),'']);
disp(['Number of terminal nodes: ',num2str(num_of_t_nodes),'']);
disp(['']);
disp(['-------------------------------']);
disp(['Canidate terminal node parents:']);
disp(num2str(t_parents));
disp([' ']);
for j = 1:size(t_parents, 2) % check XvalSSR at each canidate terminal node parent
       t_parents_XvalSSR(j) = XvalSSR(current_tree(t_parents(j)).X, current_tree(t_parents(j)).Y);
       disp([' ',num2str(t_parents(j)),' --> XvalSSR: ', num2str(t_parents_XvalSSR(j)),'']);    
end
totalXvalSSR = sum(t_parents_XvalSSR);
disp([' ']);
disp(['Total Cross-Validated SSR: ', num2str(totalXvalSSR),'']);
tree_XvalSSR(k) = totalXvalSSR;

% reset our variables for the next run
t_parents_XvalSSR = 0;
t_parents = [];
num_of_t_nodes = 0; % now we can reset the t_node counter for the individual tree
end
disp([' ']);
disp(['------------------------------']);
disp(['   Cross-validation report    ']);
disp(['------------------------------']);
disp([' ']);
for l = 1:num_of_trees
    disp(['Tree - ',num2str(l),' X-Validated SSR: ', num2str(tree_XvalSSR(l)),'']);
end
[min_Xval_SSR, min_Xval_SSR_Tree] = min(tree_XvalSSR);
disp([' ']);
disp(['The minimum X-Validated SSR is: ', num2str(min_Xval_SSR),'']);
disp([' ']);
disp(['Therefore tree ',num2str(min_Xval_SSR_Tree),' is the optimal tree.']);

optimal_tree = data_tree(min_Xval_SSR_Tree).tree; % return the optimal tree

toc % done

function pruned_trees = prune(data_tree, alpha_increment)

alpha_value = 0; % Start at an alpha of zero.
alpha_run = 0; % set run counter to zero

tree_size = size(data_tree, 2); % determine the size of the tree
num_of_t_nodes = 0; % start with no terminal nodes
t_node_counter = 0; % start with no terminal nodes in the outer loop counter
num_of_t_node_pairs = 0; % start with no terminal node pairs
t_parents = []; % and no terminal node parents

%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%
% I know it is a bit repetitive here, but it makes the outer loop easier
% and lowers the number of required inputs.
for i = 1:tree_size
           if data_tree(i).STOP == 1 % identify terminal nodes
           t_node_counter = t_node_counter + 1 % add one to the counter 
           else
           end
end

% Here comes our big outside loop: one tree for each alpha
while t_node_counter > 1 % continue until only the root node is left (i.e. only one terminal node)       

% Our smaller inside loop
for i = 1:tree_size
           if data_tree(i).STOP == 1 % identify terminal nodes
           num_of_t_nodes = num_of_t_nodes + 1; % add one to the counter 
               %%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%5
                switch (rem(i,2)) % determine if terminal node's partner is also terminal
                    case 0, % If the node is a left node, its partner is to the right
                        if data_tree(i + 1).STOP == 1
                            partner_also_terminal = 1; % if its partner is also terminal we can split it, else, don't
                            t_pair_parent = i / 2; % find the pairs parents
                            num_of_t_node_pairs = num_of_t_node_pairs + 1;    
                        else
                            partner_also_terminal = 0; % partner not terminal, so don't split
                        end
                        
                    case 1, % If the node is a right node, its partner is to the left
                        if data_tree(i - 1).STOP == 1
                            partner_also_terminal = 1; % if its partner is also terminal we can split it, else, don't
                            t_pair_parent = (i - 1) / 2;
                            num_of_t_node_pairs = num_of_t_node_pairs + 1;    
                        else
                            partner_also_terminal = 0; % partner not terminal, so don't split
                        end
                 otherwise,
                 end
                 %%%%%%%%%%%%%%%%%%%%%%%
                 t_parents = union(t_pair_parent, t_parents);
             else  % from 'if data_tree(i)... above.   
             end  % from 'if data_tree(i)... above. 
                    
        end % from for..loop
disp(['-------------------------------']);
disp(['Alpha = ', num2str(alpha_value),'']);
disp(['Number of terminal nodes: ',num2str(num_of_t_nodes),'']);
disp(['']);
disp(['Pruning Rule: min (SSR + Alpha(#(N) - 1)']);
disp(['-------------------------------']);
disp(['Canidate terminal node parents:']);
disp(num2str(t_parents));
disp([' ']);
    for j = 1:size(t_parents, 2) % check SSR at each canidate terminal node parent
        t_parents_SSR(j) = getSSR(data_tree(t_parents(j)).X, data_tree(t_parents(j)).Y);
        pruning_rule(j) = t_parents_SSR(j) + (alpha_value * (num_of_t_nodes - 1));
        disp([' ',num2str(t_parents(j)),' --> SSR: ', num2str(t_parents_SSR(j)),' --> Pruning rule: ', num2str(pruning_rule(j)),'']);    
    end
[min_prune_rule, min_prune_node] = min(pruning_rule); % find out what value and node minimizes this rule -- thats the one we want to prune

left_child = t_parents(min_prune_node) * 2; % find the left and right child nodes to prune
right_child = (t_parents(min_prune_node) * 2) + 1;

disp([' ']);
disp(['-------------------------------']);
disp(['Terminal node ',num2str(t_parents(min_prune_node)),' minimizes the pruning rule at ', num2str(min_prune_rule),'.']);
disp([' ']);
disp(['Therefore pruning their children, nodes: ',num2str(left_child),', ',num2str(right_child),'']);
% prune the nodes:
                % Left node:
                data_tree(left_child).X = 0;
                data_tree(left_child).Y = 0;
                data_tree(left_child).Z = 0;
                data_tree(left_child).STOP = 0; % no longer a terminal node
                data_tree(left_child).split_label = '';
                % all other fields are already empty
                
                % Right node:
                data_tree(right_child).X = 0;
                data_tree(right_child).Y = 0;
                data_tree(right_child).Z = 0;
                data_tree(right_child).STOP = 0; % no longer a terminal node
                data_tree(right_child). split_label = '';
                % all other fields are already empty
                
                % Finally set the parent node as a new terminal node
                data_tree(t_parents(min_prune_node)).STOP = 1; % now terminal
                data_tree(t_parents(min_prune_node)).right = 0; % remove reference to right child
                data_tree(t_parents(min_prune_node)).left = 0; % remove reference to left child
                data_tree(t_parents(min_prune_node)).graph = 0; % remove any SSR split graph
                data_tree(t_parents(min_prune_node)).split_value = 0; % remove any split value
                data_tree(t_parents(min_prune_node)).split_label = ''; % remove any split value label
                data_tree(t_parents(min_prune_node)).SSR = t_parents_SSR(min_prune_node); % set SSR at this node

% return the new data_tree
pruned_trees(alpha_run + 1).tree = data_tree;
pruned_trees(alpha_run + 1).alpha = alpha_value; % display associated alpha_value

% reset our variables for the next run
t_parents = [];
pruning_rule = 0;
min_prune_rule = 0;
min_prune_node = 0;
alpha_value = alpha_value + alpha_increment;
alpha_run = alpha_run + 1;

t_node_counter = num_of_t_nodes - 1; % subtract one from our outer loop counter

num_of_t_nodes = 0; % now we can reset the t_node counter for the individual tree

end
         % !!!!!!!!!!
        % clear terminal_parents ( don't forget to dump the array of parent
        % nodes each time this is run !
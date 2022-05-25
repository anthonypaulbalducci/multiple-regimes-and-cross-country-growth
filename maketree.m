
function data_tree=maketree (X, Y, Z, Z_labels, depth)
tic % start the clock

% depth is the maximal depth of the tree
% start off with no nodes in the tree or in counters
total_nodes = 0;
num_of_nodes = 0;
num_of_T_nodes = 0;

for i = 0:depth
    total_nodes = total_nodes + (2^i);
end

root_node = root(X, Y, Z);
data_tree(1) = root_node;

% create a graphical tree obj. using 'bt_new'
graphical_tree = bt_new;
current_position = 0;
% graphical_tree = bt_put(graphical_tree, root_node.split_value, 0);

    for i = 1:total_nodes

    %set current node
    i
    total_nodes
    data_tree
    current_node = data_tree(i);

    key = i;
    
 %       switch (rem(i,2))
 %           case 0,
%                current_position = 10 + (10/2);
%                
%                graphical_tree = bt_put(graphical_tree, current_node.split_value, (key/-i));
%            case 1,
%                current_position = 10 - (10/2);
%                graphical_tree = bt_put(graphical_tree, current_node.split_value, (key/i)); 
%            otherwise,    
%        end
    %set data array index variable
    index = i*2;
    current_node.STOP;
    current_node;
    current_node.left;
    if current_node.STOP == 0
    %split node
    %    - Left
        left_node = split(current_node.left, current_node.SSR);
        data_tree(index) = left_node; 
        
            if left_node.STOP == 0
                num_of_nodes = num_of_nodes + 1;
            end
        
            if left_node.STOP == 1
                num_of_T_nodes = num_of_T_nodes + 1;
            end
        
        %    - Right
        % add one to the index value
        index = index + 1;
        
        right_node = split(current_node.right, current_node.SSR);
        data_tree(index) = right_node;   
        
            if right_node.STOP == 0
                num_of_nodes = num_of_nodes + 1;
            end
        
            if right_node.STOP == 1
                num_of_T_nodes = num_of_T_nodes + 1;
            end    
    else % avoid splitting the node    
    %%%%%%%% Work in progress    
    % right_node = dead_node; % returns a dead node if branch is already terminal (i.e. we've run out of regressors)
    % left_node = dead_node;
    
    % data_tree(index) = left_node; % puts dead nodes in the tree
    % data_tree(index + 1) = right_node; 
    
    end
 %   bt_graph(graphical_tree);    % remove after    
    end
disp([' ']);    
disp(['--------------------------------------------------------']);    
disp(['Number of internal nodes: ', num2str(num_of_nodes), ' ']);
disp(['Number of terminal nodes: ', num2str(num_of_T_nodes), ' ']);
disp(['Total number of nodes: ', num2str(num_of_nodes + num_of_T_nodes), ' ']);
toc
end 

% create a graphical tree obj. using 'bt_new'
%graphical_tree = bt_new;
%root_node = root(X, Y, Z)
%graphical_tree = bt_put(graphical_tree, root_node.split_value, 1);

% create a data tree for storing nodes
% store root
%data_tree(1) = root_node

%current_node = root_node;

%left_node=split(current_node.left);
%left_node.split_value
%graphical_tree = bt_put(graphical_tree, left_node.split_value, -2);

%data_tree(2) = left_node

% split right node
%right_node=split(current_node.right);
% store right node
%data_tree(3) = right_node
% draw right node`  
%graphical_tree = bt_put(graphical_tree, right_node.split_value, 2);


% again

% Need this for left node below
%current_node2 = left_node;

%
%current_node = right_node;

%right_node=split(current_node.right);
%graphical_tree = bt_put(graphical_tree, right_node.split_value, 3);

%left_node=split(current_node.left);
%graphical_tree = bt_put(graphical_tree, left_node.split_value, 1.5);

%current_node3 = right_node;

% and again
%current_node = current_node2;

%right_node=split(current_node.right);
%tree = bt_put(graphical_tree, right_node.split_value, -3);

%left_node=split(current_node.left);
%left_node.split_value
%graphical_tree = bt_put(graphical_tree, left_node.split_value, -1.5);

% yet again
%current_node = current_node3;

%right_node=split(current_node.right);
%tree = bt_put(graphical_tree, right_node.split_value, 4);

%left_node=split(current_node.left);
%graphical_tree = bt_put(graphical_tree, left_node.split_value, 2.2);

%for i = 2:3
%    right_node=split(current_node.right);
%    tree = bt_put(tree, right_node.split_value, (i - 1) / i);
%    
%    left_node=split(current_node.left);
%    tree = bt_put(tree, left_node.split_value, -(i - 1) / i);
% reassign 'root' node
%current_node = right_node;
%end

%for i = 2:5
%    right_node=split(current_node.right);
%    tree = bt_put(tree, right_node.split_value, i + 1);
%    
%    left_node=split(current_node.left);
%    tree = bt_put(tree, left_node.split_value, i - 1);
% reassign 'root' node
% current_node = left_node;
% end

% ` bt_graph(graphical_tree);
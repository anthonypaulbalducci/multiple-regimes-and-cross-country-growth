function node= split(this_node, parent_node_SSR)

current_minimum_SSR = 99999999;

% Store details about current node before splitting
node.X = this_node.X;
node.Y = this_node.Y;
node.Z = this_node.Z;
node.STOP = 0; % continue splitting

if size(this_node.Z, 1) <= (size(this_node.X, 2) * 2) % condition to stop splitting
node.STOP = 1; % set flag to stop splitting
node.split_label = 0;
node.split_value = 0; % provide some null values to maintain data structure
node.right = 0;
node.left = 0;
node.graph = 0;
node.SSR = 0;

else
for i = 1:size(this_node.Z, 2)
        [Xsorted, Ysorted, Zsorted]=Zsort(this_node.X, this_node.Y, this_node.Z, i);
        disp([' ']);
        disp(['For column ',num2str(i),' of Z']);
        disp(['--------------------------------------------------------']);
        [minimum_SSR, split_index, graph(i,:)] = minSSR(Xsorted, Ysorted, Zsorted);
        if minimum_SSR < current_minimum_SSR
            current_minimum_SSR = minimum_SSR;
            
            disp([' ']);
            disp(['     ****Split assignment made****']);
            disp([' ']);
            disp(['     If x > ', num2str(Zsorted(split_index, i)) ,' go right, else go left']);
                        
            node.split_label = i; % reference for labeling
            if current_minimum_SSR < parent_node_SSR % only split if there is a reduction in SSR by doing so
                
                % Assign value at split
                node.split_value = Zsorted(split_index, i);

                % Create child nodes
                node.right.X = Xsorted(split_index:size(Xsorted,1),:);
                node.right.Y = Ysorted(split_index:size(Ysorted,1),:);
                node.right.Z = Zsorted(split_index:size(Zsorted,1),:);
            
                node.left.X = Xsorted(1: split_index - 1, :);
                node.left.Y = Ysorted(1: split_index - 1, :);
                node.left.Z = Zsorted(1: split_index - 1, :);
                
                node.STOP = 0; % flag as non-terminal node
            else
                node.STOP = 1; % otherwise flag as terminal    
            end
          else
        end
    end
    % Adds graph of node split threshold    
    node.graph = graph;
    % Adds SSR value for this split for later comparision
    node.SSR = current_minimum_SSR;
    end
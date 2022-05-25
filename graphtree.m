function graphtree(tree, Z_labels, label_spacer)
% Syntax - drawtree (x, y, l_scale, r_scale, x_scale, label_spacer, label)

tic % start the clock
disp([' ']);
disp(['------------------------']);
disp(['Graphing... please wait.']);

tree_x = [0 0 0];
tree_y = [0 0 0];
nodes.right = [0 0];
nodes.left = [0 0];
node(1).x = 0;
current_node = 1;
current_arc = 1;
level = 0;
use_key = 0;
% label_spacer = 0.5; otherwise default
% the following key, which restricts the presentable tree to 6 levels, is
% needed to correctly place labels for nodes in the drawn tree, as my
% recursive algorithm here seems to do things a bit haphazardly.
key = [1 2 3 6 7 4 5 10 11 8 9 14 15 12 13 26 27 24 25 30 31 28 29 18 19 16 17 22 23 20 21 42 43 40 41 46 47 44 45 34 35 32 33 38 39 36 37 58 59 56 57 62 63 60 61 50 51 48 49 54 55 52 53];
for i = 0:5
for j = 1:2^i
  use_key = key(current_node);
  if isempty((tree(use_key).split_value))
    label = num2str(-999);  
    else
    label = num2str(tree(use_key).split_value);
  end
   left_and_right = drawtree(node(current_node).x, level, 1, 1, current_arc, current_node, label_spacer, label, tree(use_key).split_label, Z_labels);
   
   node((current_node*2)).x = left_and_right(2); % for the left node
   node((current_node*2)+1).x = left_and_right(1); % for the right node
 
   current_node = current_node + 1; % step up counter
  
end
level = level - 1; % step up to next level (i.e. make Y 'shift')
current_arc = current_arc - (1-.90^i);
end
toc % we're done    
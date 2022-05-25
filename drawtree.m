function [left_and_right] = drawtree (x, y, l_scale, r_scale, x_scale, current_node, label_spacer, label, text_label, Zlabel)
% a helper application for graphtree -- used for recursive drawing,
% drawtree.m auctually does the drawing while graphtree.m feeds it data.

tree_x = [-1 0 1];
tree_x = tree_x * x_scale;
tree_x = tree_x - x;
    

stop_drawing = 0;

tree_y = [-1 0 -1];
tree_y = tree_y + y;

if text_label > 0 % avoid labeling null or terminal cells
    formatted_label = strcat(cellstr(Zlabel(text_label)),' >  ', label);
    else 
    formatted_label = '';
end
%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%
% Artificial Adjustments !

    if current_node == 1 % make adjustment to widen tree for root node
        tree_x = tree_x * 3.7;
    else % do nothing
    end
if current_node == -999 % void this while its worked on
   if current_node == 3 
        tree_x(1);
        tree_x(3);
        tree_x(1) = tree_x(1) - 2;
        tree_x(3) = tree_x(3) + 2;
    else
    end
    
    if current_node > 3
        switch (rem(current_node,2))
           case 0, 
               tree_x(1) = tree_x(1) - 2
               tree_x(2) = tree_x(2) - 2
               tree_x(3) = tree_x(3) - 2
                
           case 1, 
                tree_x(1) = tree_x(1) + 2
                tree_x(2) = tree_x(2) + 2
                tree_x(3) = tree_x(3) + 2
         otherwise,
         end
        
        
     else
     end
 else
 end
%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%

if str2num(label) == 0 || str2num(label) == -999 % check for terminal node
    stop_drawing = 1; % set a flag to stop drawing this tree    
else
    plot(tree_x, tree_y, '-o');
end
if str2num(label) == -999
else
text(tree_x(2), tree_y(2) - label_spacer, formatted_label, 'HorizontalAlignment','center');
hold('on');
end
left_and_right = [tree_x(1) tree_x(3)];
left_and_right;
tree_y;

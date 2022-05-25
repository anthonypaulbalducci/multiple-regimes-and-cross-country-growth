function root_node=root (X, Y, Z)
% returns a root 'node' obj. to begin splitting

% creates small temporary 'node' obj.
temp_node.X = X;
temp_node.Y = Y;
temp_node.Z = Z;


root_node = split(temp_node, 999999999); % provides outlandish SSR to ensure split takes place
function SSRplot(node, Zlabels)

graph = node.graph;
num_of_X_val = size(graph, 2);
X = 1:num_of_X_val;

line(X,graph);

%%%%%%%%%%%%%%%%%%%%%%%%%
%Note: Currently only supports two labels; add more here :
Label1 = char(Zlabels(1));
Label2 = char(Zlabels(2));
legend(Label1,Label2,0);
%%%%%%%%%%%%%%%%%%%%%%%%%

xlabel('Z-sorted index value');
ylabel('SSR')




An example usage is as follows:
 
Loading multiple_regimes.mat brings four variables to the workspace:
 
     1. A 96 x 5 matrix of regressors, X
     2. A 96 x 1 vector of the regressand, Y
     3. A 96 x 2 matrix of associated potential split values, Z
     4. A 1 x 2 cellular array containing labels for each associated column of Z
 
These data are all from the 1998 Summers-Heston data set, and are more fully described in the paper by Durlauf and Johnson, "Multiple Regimes and Cross-Country Growth Behavior".
 
First we must grow a tree based the regression model specified above, and for which splits are obtained by minimizing within node SSR relative to all possible subsamples based on split criteria. We do this using 'maketree', a typical syntax of which is as follows:
 
mytree = maketree(X, Y, Z, Zlabels, 6)
 
Where X, Y, Z, and Zlabels are described above. '6' specifies the depth of the tree to be computed (number of node levels). This can be computationally expensive, as well as difficult to graph, so at the moment 6 is the maximum value that will work reliably (and the ammount of levels needed to compute the tree contained in the paper). Running 'maketree' returns a tree object (in this case, 'mytree').
 
We can now view a graph of this unpruned tree as follows:
 
2. graphtree(mytree, Zlabels, 0.5)
 
Having no built-in way to visualize this tree structure (I couldn't find information on how to use matlab's associated structure), I had to design my own utility for viewing the tree representation. This, suprisingly, is much more difficult than it sounds, and so there are a few problems with this at the moment (branches will overlap due to insufficent spacing, and tree size is again limited to a depth of 6). If I have time I will try and remedy some of these problems, but as they are less central to my current analysis and the work related to the paper, I leave them be for now. The graphtree utility above takes in a tree object, 'mytree', the labels for the splits, and finally a value for label spacing (i.e. the vertical distance to place the split label from the parent node). I find that using a value of '0.5' tends to be best. Even though branches over-lap a bit, zooming on the graph makes the structure distinct.
 
One can also view a graph of the calculated SSR for each split node based on the competing split values of Z. Suppose we wanted to view the results of the first split at the root node:
 
3. SSRplot(mytree(1), Zlabels)
 
The graph plots the index value of the associated split canidate from the Z vector in ascending order vs. the associated SSR if the particular Z is used to split the sample. A similar plot is available for any non-terminal, non-void node by changing the selected element of the tree: i.e. mytree(2) is node 2, etc. 
 
[Note: Given the fact that there was no good underlying tree data structure in Matlab, and for ease of manipulation, the nodes are stored in a sequential array based on a full tree of the specified depth. I.E. some mytree(x) values may be void if they were not used in the tree, and the index values are not sequential (a left-child node is twice the index value of its parent, and the right-child is the same plus one)]
 
Next, we can prune the tree:
 
4. pruned_tree = prune(mytree, 0.5)
 
Pruning returns a pruned tree object (a series of trees pruned at different levels of alpha), and requires the specification of a tree to be pruned and an incremental value for alpha (here, 0.5). Any small value is sufficent, as the program will loop each time increasing alpha (and therefore the resulting pruning rule) until the tree has been reduced to only a root node which contains all observations.
 
Graphs for the tree at different stages of pruning are available as described before. (I.E. To view the tree at the 9th stage of pruning we would use:
 
5. graphtree(pruned_tree(9).tree, Zlabels, 0.5)   
 
[Note: in the pruned_tree object, trees are stored at an index value (x), under some sub structure 'tree'. That is, pruned_tree(x).tree.]
 
Finally, we seek to cross-validate our regression tree by finding which of these pruned trees minimizes the cross-validated SSR. This tree will be the optimal tree.
        
We can do this by typing:
 
6. optimal_tree = Xvalidate(pruned_tree)
 
Where 'pruned_tree' is a pruned tree object. As a result, this returns an object, (optimal_tree) which represents the best piecewise linear approximation. This tree can be viewed using methods described before. (I.E. graphtree (optimal_tree, Zlabels, 0.5).
 
Now I am sure there are still some bugs in this code, and some of the implementation may be less efficent than it ought to be, as this is my first time programming in Matlab. The book was helpful; Thank you for letting me borrow it.
 
All this being said, after implementing the algorithm here in (which is described here in the paper) it is still not clear how they managed the split values they did. As I mentioned they split on values which are not contained in the sample set of possible Z values, and splits, esp. in GDP, consistently occur in whole numbers (I.E. the first split at the terminal node occurs at 800). I think that even had I gotten the algorithm wrong here, the numbers would not have come out in this way. 
        
That being said, they are similar, especially in the first few cases. (I.E. the first three right node split-values of GDP60 > 800, LIT60 > 46 and GDP60 > 4850 are comparable to the splits I find of GDP60 > 863, LIT60 > 45, GDP > 4802. However the differences increase as we go down the tree (compounded by continued effect of a different sample splitting criterion). Their full, unpruned tree is visible here.

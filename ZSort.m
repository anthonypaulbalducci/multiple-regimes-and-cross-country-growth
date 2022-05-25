function [XSorted, YSorted, ZSorted]=ZSort(X, Y, Z, col)
% Sort the matrix by data in column 'col' creating temporary vectors of
% sorted values and their corresponding indices.
[tmp, idx] = sort(Z(:,col));
% Create matrix for holding the sorted values, and then sort X by the index
% of Z values
ZSorted = Z(idx,:);
XSorted = X(idx,:);
YSorted = Y(idx,:);
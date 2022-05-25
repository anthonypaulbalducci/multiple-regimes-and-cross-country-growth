function totalSSR = XvalSSR (X,Y)

residuals = 0;
current_set_SSR = 0;
totalSSR = 0;
bhat = 0;
X_size = size(X, 1);
num_of_regressors = size(X, 2);

for i = 1:X_size 
current_xi = X(i, 1:num_of_regressors);
current_yi = Y(i);

current_X_set = setdiff(X,current_xi, 'rows');
current_Y_set = setdiff(Y,current_yi);
bhat = current_X_set\current_Y_set;
residuals = (bhat' * current_X_set');
current_set_SSR = sum((current_Y_set' - residuals).^2);

totalSSR = totalSSR + current_set_SSR;
end

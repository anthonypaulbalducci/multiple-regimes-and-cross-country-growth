function SSR=getSSR(X, Y)

residuals = 0;
SSR = 0;
bhat = 0;

bhat = X\Y;
residuals = (bhat' * X');
SSR = sum((Y' - residuals).^2);
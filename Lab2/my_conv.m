function [y,t] = my_conv(x)
    a = -0.0625;
    b = 0.25;
    c = 0.625;
    d = 0.25;
    N = [a b c d a];
    D = [1 0 0 0 0];
    [h,] = impz(N,D);
    m = length(x); % Length of input vector
    n = length(h); % Length of filter
    k = m + n - 1; % Length of output
    y = zeros(1,k);
    t = 1:k;
    for i=1:k
        for l=max(1,i+1-n):min(i,m) %Range where convolution generates values.
            y(i) = y(i) + (x(l) * h(i-l+1));
        end
    end
end


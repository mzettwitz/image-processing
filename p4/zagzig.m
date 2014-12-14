function data = zagzig(x)

if size(x,1) > size(x,2), x = x'; end % if x is a column vector, tronspose

if (mod(sqrt(size(x,2)), 1) ~= 0.0) 
    error('not quadratic matrix!');
end

s = size(x,2);
s_q = sqrt(s);
data = zeros(s_q, s_q);
run = 1;
cur = 1;

b = false;

for i = 1 : s_q
    for j = 1 : cur
        if (b == 0)
            data(i-(j-1), j) = x(run);
        else
            data(i-(cur-j), cur-(j-1)) = x(run);
        end
        
        if (j == cur)
            b = ~b;
        end
        
        run = run + 1;
    end
    
    cur = cur + 1;
end

cur = cur - 2;

for k = s_q+1 : (s_q*2)-1
    for m = 1 : cur
        if (b == 0) % rauf
            data(s_q-(m-1), k-s_q+m) = x(run);
        else % runter
            data(k-s_q+m, s_q-(m-1)) = x(run);
        end
        
        if (m == cur)
            b = ~b;
        end
        
        run = run + 1;
    end
    cur = cur - 1;    
end
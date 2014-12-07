function data = zigzag(x)

s = size(x);
if (s(1) ~= s(2))
    error('not quadratic matrix!');
end

data = zeros(1, s(1)*s(1));
run = 1;
cur = 1;

b = false;

for i = 1 : s(1)
    for j = 1 : cur
        if (b == 0)
            data(run) = x(i-(j-1), j);
        else
            data(run) = x(i-(cur-j), cur-(j-1));
        end
        
        if (j == cur)
            b = ~b;
        end
        
        run = run + 1;
    end
    
    cur = cur + 1;
end

cur = cur - 2;

for k = s(1)+1 : (s(1)*2)-1
    for m = 1 : cur
        if (b == 0) % rauf
            data(run) = x(s(1)-(m-1), k-s(1)+m);
        else % runter
            data(run) = x(k-s(1)+m, s(1)-(m-1));
        end
        
        if (m == cur)
            b = ~b;
        end
        
        run = run + 1;
    end
    cur = cur - 1;
end


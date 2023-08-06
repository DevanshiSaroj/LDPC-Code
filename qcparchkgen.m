

function [Base, Mat] = qcparchkgen(j, k, a, b, p)
Ha = zeros(j, k);
Ha(1, 1) = 1;
Ha(1, 2) = a;
Ha(2, 1) = b;

for ii = 2:size(Ha, 2)
    Ha(1, ii) = a ^ (ii-1);
    
    if (Ha(1, ii) > p)
        Ha(1, ii) = rem(Ha(1, ii), p);
    else
        continue
    end
    
    ii = ii+1;
end

for jj = 2:size(Ha, 1)
    Ha(jj, 1) = b ^ (jj-1);
    
    if (Ha(jj, 1) > p)
        Ha(jj, 1) = rem(Ha(jj, 1), p);
    else
        continue
    end
    
    jj = jj+1;
end

for m = 2 : size(Ha, 1)
    for n = 2 : size(Ha, 2)
        
        Ha(m, n) = Ha(1, n) * Ha(m, 1);
        
        if (Ha(m, n) > p)
            Ha(m, n) = rem(Ha(m, n), p);
        else
            continue
        end
        n = n+1;
    end
    m = m+1;
end

Base = Ha;
HaC = cell(size(Ha));
Ha(1, 1) = 0;  
Data = eye(p);
for k = 1:numel(HaC)
    HaC{k} = circshift(Data, -Ha(k), 1);
end
Mat = cell2mat(HaC);

end
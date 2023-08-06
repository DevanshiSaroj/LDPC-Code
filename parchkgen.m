function [Parity_check_Matrix,R] = parchkgen(n,wc,wr)
    m = n*wc/wr;
    Parity_check_Matrix_sub = zeros(n/wr,n);

 for i = 1:n/wr
        for j = (i-1)*wr+1:i*wr
            Parity_check_Matrix_sub(i,j) = Parity_check_Matrix_sub(i,j) + 1;
        end
 end

    Parity_check_Matrix_temp = Parity_check_Matrix_sub;
 for t = 2:wc
    x = randperm(n);
    Parity_check_Matrix_sub_perm = Parity_check_Matrix_sub(:,x);
    Parity_check_Matrix_temp = [Parity_check_Matrix_temp Parity_check_Matrix_sub_perm];
 end
 
 Parity_check_Matrix = zeros(m,n);
 for k = 1:wc
    Parity_check_Matrix((k-1)*(n/wr)+1:(k)*(n/wr),1:n) = Parity_check_Matrix((k-1)*(n/wr)+1:(k)*(n/wr),1:n) + Parity_check_Matrix_temp(:,(k-1)*n+1:k*n);
 end
 
 fprintf('Required PCM of order (%d X %d)\n', size(Parity_check_Matrix,1),size(Parity_check_Matrix,2));
  disp(Parity_check_Matrix)
  density = wc/m;
  fprintf('Density = %f\n', density);
  R=1-(rank(Parity_check_Matrix)/n);
  fprintf('Code Rate for given H = %f \n',R);
  save('Parity_check_Matrix_H.mat','Parity_check_Matrix');
end


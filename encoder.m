function [C, Hsys] = encoder(H)
[m,n]=size(H);
Ht=H';
tol=1e-10;

if rank(H)==m
  fprintf('The Matrix is already a Full Matrix\n');
  H_fullrank=H;
else
   [Q, P, E] = qr(Ht,0); 
    if ~isvector(P)
    diagr = abs(diag(P));
   else
    diagr = P(1);   
   end
   r = find(diagr >= tol*diagr(1), 1, 'last'); 
   index=sort(E(1:r));
   Rsub=Ht(:,index);
   H_fullrank=Rsub';
end

[m_fr,n] = size(H_fullrank);   
swaps=zeros(m_fr,2);       
swaps_count=1;
H_fr_temp=H_fullrank;  
j=1;
index=1;

while index<=m_fr
    i=index;
    while (H_fr_temp(i,j)==0)&&(i<m_fr)
        i=i+1;
    end
    if H_fr_temp(i,j)==1
        temp=H_fr_temp(i,:);
        H_fr_temp(i,:)=H_fr_temp(index,:);
        H_fr_temp(index,:)=temp;
        for i=1:m_fr
            if (index~=i)&&(H_fr_temp(i,j)==1)
                H_fr_temp(i,:)=mod(H_fr_temp(i,:)+H_fr_temp(index,:),2);
            end
        end
        swaps(swaps_count,:)=[index j];
        swaps_count=swaps_count+1;
        index=index+1;
        j=index;
    else
        j=j+1;
    end
end

for i=1:swaps_count-1
    temp=H_fr_temp(:,swaps(i,1));
    H_fr_temp(:,swaps(i,1))=H_fr_temp(:,swaps(i,2));
    H_fr_temp(:,swaps(i,2))=temp;
end

I = H_fr_temp(:,1:m_fr);
A = H_fr_temp(:,(m_fr+1):n);
Hsys =[A I];
fprintf(' H in systematic form of order (%d X %d), rank %d and density of %f\n', size(Hsys,1),size(Hsys,2),rank(Hsys),(sum(Hsys(:) == 1)/(m_fr*n)));
disp(Hsys)

k=n-m_fr;
G = gen2par(Hsys);
fprintf('Required G in systematic form of order (%d X %d), rank %d \n', size(G,1),size(G,2),rank(G));
disp(G)

fprintf('RANDOM MESSAGE BITS \n');
msg_tx = round(rand(1,k)) ;
disp(msg_tx)

C = mod(double(msg_tx)*double(G),2);    
fprintf('ENCODED(TRANSMITTED) CODEWORD = \n');
disp(C)
end
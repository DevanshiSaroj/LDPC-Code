function [Y,LLR] = BPSK_AWGN_channel(C)
Sn=C; 
n=size(C,2);

for i =1:n
    Sn(i)=(2*Sn(i))-1;  
end

dB=4;                          
SNR=10^(dB/10);                
No_org=1/SNR;             
No=No_org;      
for z=1:length(SNR) 
        sigma=sqrt(No(z)/2);
        Y=Sn + sigma*randn(1,length(Sn));
end
fprintf(' - \n - \n - \nRECIEVED CODEWORD : \n');
disp(Y)
LLR=(4/No(z))*Y;
end
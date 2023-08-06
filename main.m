clc;
n = input('Enter the number of bits in the codeword (n)=  '); 
wc = input('Enter the number of ones in each column (Wc)=  '); 
wr = input('Enter the number of ones in each row (Wr) [Wr>Wc]=  ');

%[H,rate] = parchkgen(n,wc,wr);
[base, H]=qcparchkgen(wc,wr,2,5,n/wr);
[codeword, Hsys]=encoder(H);
[Y_AWGN,LLR] = BPSK_AWGN_channel(codeword);
     
[decoded_codeword,BE] = decoder(LLR,Hsys,codeword);
fprintf('\n DECODED RECIEVED CODEWORD : \n');
disp(decoded_codeword)
fprintf('no. of error bits = %d\n', BE);
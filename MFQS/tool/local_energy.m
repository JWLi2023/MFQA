%%local_energy
function cp=local_energy(matrix, W2)    

[row,column]=size(matrix);
cp=zeros(row,column);

spread=(W2-1)/2;
matrix_en=abs(padarray(matrix,[spread spread],'symmetric'));  
for i=1:row
    for j=1:column
        window=abs(matrix_en(i:1:(i+2*spread),j:1:(j+2*spread)));
        cp(i,j)=sum(window(:));
    end
end 
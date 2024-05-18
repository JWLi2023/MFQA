function value = Fq_value(input_image, window_wide)

    matrix=input_image;
    spread=(window_wide-1)/2;
    matrix=double(matrix);
    [row,column]=size(matrix);
    cp=zeros(row,column);

    matrix_en=padarray(matrix,[spread spread],0,'both');

    load('FQPath_kernel.mat');
    kernel_sheet = FQPath_kernel{:};

    FQ_image=zeros(row,column);
    
    for i=1:row
        for j=1:column
            path=matrix_en(i:window_wide+i-1,j:window_wide+j-1);
             FQ_image(i,j) = FQPath(path, kernel_sheet);
        end
        
       
  
    end
    value=FQ_image;

end
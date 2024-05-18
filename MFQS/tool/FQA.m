function fousionimage=FQA(f1,f2,wiondsize)


    image1=f1;
    image2=f2;
    load('FQPath_kernel.mat');
    kernel_sheet = FQPath_kernel{:};

    % 

    [h,w]=size(image1);
    h_number=ceil(h/wiondsize);
    w_number=ceil(w/wiondsize);

    test_image1=zeros(h_number*wiondsize,w_number*wiondsize);
    test_image1(1:h,1:w)=image1;

    test_image2=zeros(h_number*wiondsize,w_number*wiondsize);
    test_image2(1:h,1:w)=image2;

    test_F=zeros(h_number*wiondsize,w_number*wiondsize);

    for i=0:h_number-1
        for j=0:w_number-1

           patch_1= test_image1(1+i*wiondsize:(i+1)*wiondsize,1+j*wiondsize:(j+1)*wiondsize);  
           patch_2= test_image2(1+i*wiondsize:(i+1)*wiondsize,1+j*wiondsize:(j+1)*wiondsize);       

           k1 = FQPath(patch_1, kernel_sheet);
           k2 = FQPath(patch_2, kernel_sheet);

           if k1<=k2
               patch_f = patch_2;
           else  
               patch_f = patch_1;
           end

           test_F(1+i*wiondsize:(i+1)*wiondsize,1+j*wiondsize:(j+1)*wiondsize)=patch_f;

        end

    end
    
    fousionimage=test_F(1:h,1:w);




end
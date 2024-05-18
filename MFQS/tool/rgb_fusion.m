function fusion_image=rgb_fusion(f1,f2)

    if size(f1,3) == 3
        for i=1:3
            image1=f1(:,:,i);
            image2=f2(:,:,i);

            fousion_iamge1=fousion(image1,image2,21);

            fusion_image(:,:,i)=fousion_iamge1;
        end
    else
         fusion_image=fousion(f1,f2,21);

    end

end
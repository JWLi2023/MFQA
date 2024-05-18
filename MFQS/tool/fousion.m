function fousion=fousion(iamge1,iamge2,win_size)



[h1,w1]=size(iamge1);

if (mod(h1,2) || mod(w1,2))
    f1=zeros(h1+mod(h1,2),w1+mod(w1,2));
    f1(1:end-mod(h1,2),1:end-mod(w1,2))=iamge1; 
    f2=zeros(h1+mod(h1,2),w1+mod(w1,2));
    f2(1:end-mod(h1,2),1:end-mod(w1,2))=iamge2;     
else    
    f1=iamge1;
    f2=iamge2;
    
end



filter=pyramid_filter;
f1_down=downsample(f1,filter);
f1_up=upsample(f1,[0,0],filter);


f2_down=downsample(f2,filter);
f2_up=upsample(f2,[0,0],filter);


MF1=FQA(f1_down,f2_down,win_size-4); 
MF2=FQA(f1,f2,win_size); 
MF3=FQA(f1_up,f2_up,win_size+4); 
% 
% figure
% imshow(MF2)


G=fspecial('gaussian',8,20); 
MF1=imfilter(MF1,G,'same');

MF2=imfilter(MF2,G,'same');

MF3=imfilter(MF3,G,'same');


MF=(0.5*MF2+0.25*upsample(MF1,[0,0],filter)+0.25*downsample(MF3,filter));

%MF=MF2;


D1=f1-MF;
D2=f2-MF;


temp1=SML(D1,5).*local_energy(D1,5);
temp2=SML(D2,5).*local_energy(D1,5);

map=(temp1>=temp2);

[h,w]=size(f1);
ratio=0.015;%0.015 
area=ceil(ratio*h*w);
map=bwareaopen(map,area);

k=1.4*log(h*w);
k=round(k);
if mod(k,2)==0
    k=k-1;
end

map=majority_consist_new(map,k);

% figure
% imshow (map)

fousion_F=D1.*map+D2.*(1-map)+ MF;

if (mod(h1,2) || mod(w1,2))
    fousion=zeros(h1-mod(h1,2),w1-mod(w1,2));
    fousion=fousion_F(1:end-mod(h1,2),1:end-mod(w1,2)); 

else    
    fousion=fousion_F;

end



end







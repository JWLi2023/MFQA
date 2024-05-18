close all
clear
clc
tic
addpath tool;

%%File reading%%
Original_Image_path= 'C:\Users\';
Save_path='C:\Users\';



Original_Image_list= dir(strcat(Original_Image_path,'*.jpg'));
Original_Image_num=length(Original_Image_list);
Original_Image=cell(1,Original_Image_num);
fileNames={Original_Image_list.name};

for i=1:Original_Image_num
    image_name = Original_Image_list(i).name
    image =  imread(strcat(Original_Image_path,image_name));
    Original_Image{i}=image;  
    fprintf('%d  %s\n',i,strcat(Original_Image_path,image_name));
end


j=0;
for i=1:2:Original_Image_num-1


	Fusion_Image=rgb_fusion(im2double(cell2mat(Original_Image(i))),im2double(cell2mat(Original_Image(i+1))));


    %Image saving and display
    figure
   imshow(Fusion_Image,'border','tight')

   
	name=char(fileNames(i));
    K = find('.'==name);
    imname = name(1: K-1);
    path=strcat(Save_path,imname,'.jpg');
  
  %  imwrite(Fusion_Image,path)
   clear  Fusion_Image Image1 Image2
end


toc


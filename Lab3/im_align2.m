function im_align2 = im_align2()
for t = 1:6
    
    I1=imread(strcat(strcat("image",num2str(t)),".jpg"));
    Ib1 = imcrop(I1, [0 0 393 342]);
    Ig1 = imcrop(I1, [0 342 393 341]);
    Ir1 = imcrop(I1, [0 683 393 341]);
    Ix1= cat(3, Ir1,Ig1,Ib1);
    %imwrite (Ix1,'image1-color.jpg');
    %figure(1)
    %imshow(Ix1) 
    [w1b,h1b]=size(Ib1);
    [w1g,h1g]=size(Ig1);
    [w1r,h1r]=size(Ir1);

    Ib1c = imcrop (Ib1,[ 160 100 99 49]);
           
    
    cur_norm_g = normxcorr2(Ib1c,Ig1);
    [ypeak_g, xpeak_g] = find(cur_norm_g==max(cur_norm_g(:)));
    yoffSet_g = ypeak_g-size(Ib1c,1);
    xoffSet_g = xpeak_g-size(Ib1c,2);
    
    x_g = xoffSet_g - 160;
    y_g = yoffSet_g - 100;
    
    
       %100 150 160 260
         
      
      cur_norm_r=normxcorr2(Ib1c,Ir1);
      
      [ypeak_r, xpeak_r] = find(cur_norm_r==max(cur_norm_r(:)));
      yoffSet_r = ypeak_r-size(Ib1c,1);
      xoffSet_r = xpeak_r-size(Ib1c,2);
      x_r = xoffSet_r - 160;
      y_r = yoffSet_r - 100;
    

        
    container = zeros(300,300,3,'uint8');

    Imb1c = imcrop (Ib1,[ (w1b/2)-160 (h1b/2)-160 369 319]);
    Img1c = imcrop (Ig1,[ (w1g/2)-160+x_g (h1g/2)-160+y_g 369 319]);
    Imr1c = imcrop (Ir1,[ (w1g/2)-160+x_r (h1g/2)-160+y_r 369 319]);

    container(1:size(Imr1c,1),1:size(Imr1c,2),1)=Imr1c;
    container(1:size(Img1c,1),1:size(Img1c,2),2)=Img1c;
    container(1:size(Imb1c,1),1:size(Imb1c,2),3)=Imb1c;

    %Im1=cat(3,Imr1c,Img1c,Imb1c)
    figure(t+12)
    imshow(container)
    imwrite (container,strcat(strcat('image',num2str(t)),'-ncc.jpg'));
    
    x_g
    y_g
    
    x_r
    y_r
end

end
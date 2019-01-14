function im_align1 = imalign()
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
    
    min_ssd_r = 999999999999999;
    min_ssd_g = 999999999999999;

    g_best_i = 0;
    g_best_j = 0;
    r_best_i = 0;
    r_best_j = 0;
    
    %c_s =[ (w1b/2)-50 (h1b/2)-50 99 99]
    Ib1c = imcrop (Ib1,[ (w1b/2)-100 (h1b/2)-100 199 199]);
    %figure(1)
    %imshow(Ib1c)        
    for m =-15:15
        for n = -15:15

            Ig1c = imcrop (Ig1,[ (w1g/2)-100+m (h1g/2)-100+n 199 199]);
            diffsq_g = (int32(Ib1c) - int32(Ig1c)).^2;
            cur_ssd_g=0;

            temp_g = sum(diffsq_g,1);
            cur_ssd_g = sum(temp_g);

            
            if cur_ssd_g < min_ssd_g
                min_ssd_g = cur_ssd_g;
                g_best_i=m;
                g_best_j=n;
            end  

            %imshow(Ig1c)
        end
    end
    for m =-15:25
        for n = -15:25

            Ir1c = imcrop (Ir1,[ (w1r/2)-100+m (h1r/2)-100+n 199 199]);
            %imshow(Ir1c)
            diffsq_r = (int32(Ib1c) - int32(Ir1c)).^2;
            cur_ssd_r=0;

            temp_r = sum(diffsq_r,1);
            cur_ssd_r = sum(temp_r);

            if cur_ssd_r < min_ssd_r
                min_ssd_r = cur_ssd_r;
                r_best_i=m;
                r_best_j=n;
            end  

            %imshow(Ig1c)
        end
    end
    container = zeros(300,300,3,'uint8');

    Imb1c = imcrop (Ib1,[ (w1b/2)-160 (h1b/2)-160 369 319]);
    Img1c = imcrop (Ig1,[ (w1g/2)-160+g_best_i (h1g/2)-160+g_best_j 369 319]);
    Imr1c = imcrop (Ir1,[ (w1g/2)-160+r_best_i (h1g/2)-160+r_best_j 369 319]);

    container(1:size(Imr1c,1),1:size(Imr1c,2),1)=Imr1c;
    container(1:size(Img1c,1),1:size(Img1c,2),2)=Img1c;
    container(1:size(Imb1c,1),1:size(Imb1c,2),3)=Imb1c;
  
    
    %Im1=cat(3,Imr1c,Img1c,Imb1c)
    figure(t+6)
    imshow(container)
    imwrite (container,strcat(strcat('image',num2str(t)),'-ssd.jpg'));
    disp('SSD')
    x_g=g_best_i
    y_g=g_best_j
    
    x_r=r_best_i
    y_r=r_best_j
    
end
end

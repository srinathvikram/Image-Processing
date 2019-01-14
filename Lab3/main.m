for t = 1:6
    
    I1=imread(strcat(strcat("image",num2str(t)),".jpg"));
    Ib1 = imcrop(I1, [0 0 393 342]);
    Ig1 = imcrop(I1, [0 342 393 341]);
    Ir1 = imcrop(I1, [0 683 393 341]);
    %Ix1= cat(3, Ir1,Ig1,Ib1);
    container = zeros(300,300,3,'uint8');
    container(1:size(Ir1,1),1:size(Ir1,2),1)=Ir1;
    container(1:size(Ig1,1),1:size(Ig1,2),2)=Ig1;
    container(1:size(Ib1,1),1:size(Ib1,2),3)=Ib1;
    imwrite (container,strcat(strcat('image',num2str(t)),'-color.jpg'));
    figure(t)
    imshow(container)
%     [g_x g_y r_x r_y] = im_align2
%     g_x
%     g_y
%     r_x
%     r_y
    
end
im_align1();
im_align2();
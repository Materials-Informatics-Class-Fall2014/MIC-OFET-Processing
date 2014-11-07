function [SEGfile,ORIENT,MAXCONF] = Full_Seg2(filepath)

%% Full Seg

% Full segmentation takes a grayscale image IM, and eccentricity and area
% cutoffs ecc and area as inputs
% 
% It returns SEG, a segmented image with each pixel assigned an orientation
% and a degree of crystallinity.

IMG2 = imread(filepath);
IM = rgb2gray(IMG2);

maxarea = 20000;
[m,n] = size(IM);

BW = im2bw(IM,0);
level = 0;

RP = regionprops(BW,'Area','Eccentricity','Orientation','Solidity');

Conf = zeros(m,n,100);
Orient = zeros(m,n,100);
Label = zeros(m,n);
% Labels = bwlabel(BW,8);
% NewPix = zeros(size(IM));

for ii = 35:60
    disp(ii)
    level = ii/100;

    BW = im2bw(IM,level);
    RP = regionprops(BW,'Area','Eccentricity','Orientation','Solidity');
    Label = bwlabel(BW,8);
    NumComps = length(RP);
    
    for jj = 1:NumComps
        %tic
        [Confidence,Orientation] = fiber_conf(jj,RP);
        %toc
        if Confidence > 0
            Orient(:,:,ii) = Orient(:,:,ii) + (Label==jj) .* Orientation;
            Conf(:,:,ii) = Conf(:,:,ii) + (Label==jj) .* Confidence;
        end
        %length(find(Orient(:,:,ii)))
        
    end
    
%     filename = ['thresh' num2str(ii) '_2'];
%     save(filename,'Orient')
    
end

[MAXCONF, MaxThresh] = max(Conf,[],3);

ORIENT = zeros(m,n);

for i = 1:m
    for j = 1:n
        ORIENT(i,j) = Orient(i,j,MaxThresh(i,j));
    end
end

SEGfile = [filepath(1:end-4), '_Seg'];

save(SEGfile)

figure
imshow(IM)

orientplot(ORIENT,MAXCONF);

end
    
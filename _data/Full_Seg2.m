function [SEGfile,ORIENT,MAXCONF] = Full_Seg2(filepath)

%% Full Seg

% Full segmentation takes a grayscale image IM
% 
% It returns ORIENT, where each element of ORIENT is the expected
% orientation of the fiber that pixel is in
%
% And, it returns MAXCONF, which indicates how confident it was that each
% pixel was in a fiber of orientation found in the corresponding element of
% ORIENT
% 
% If an element of MAXCONF is 0, it means that pixel is amorphous.
% Amorphous pixels in ORIENT also show as 0 angle, so this needs to be
% addressed by the user after the code is run, typically with the following
% code:

% SEG = ORIENT + (MAXCONF==0).*(-180)

% This creates SEG, where fibrilar pixels have their orientation, and
% amorphous pixels are shown with an angle of -180. This makes pcolor plots
% look good. This is done in the final lines of the code.

%% Fiber Confidence parameters
% Change min area to exclude small regions from being considered "fibers"
% change max area to reflect how big you expect your largest fiber to be.
% This way gigantic, image-spanning connected components don't register as
% fibers.
% These values are in pixels.

minarea = 200;
maxarea = 20000;

%% Threshold Bounds
% You probably don't want to run from 0 to 100%, so use these bounds to
% contain the algorithm:

Minthresh = 40;
Maxthresh = 60;

%% Rest of algo

IMG2 = imread(filepath);
IM = rgb2gray(IMG2);

[m,n] = size(IM);

BW = im2bw(IM,0);
level = 0;

RP = regionprops(BW,'Area','Eccentricity','Orientation','Solidity');

Conf = zeros(m,n,100);
Orient = zeros(m,n,100);
Label = zeros(m,n);


%% Iterate over thresholds... 


parfor ii = Minthresh:Maxthresh
%     disp(ii)
    level = ii/100;

    BW = im2bw(IM,level);
    RP = regionprops(BW,'Area','Eccentricity','Orientation','Solidity');
    Label = bwlabel(BW,8);
    NumComps = length(RP);
    
    Comps = (1:NumComps)';
    Areas = [RP(:).Area]';
    Angles = [RP(:).Orientation]';
    Eccens = [RP(:).Eccentricity]';
    FiberConfs = zeros(NumComps,1);
    for nn = 1:NumComps
        if Areas(nn)>minarea && Areas(nn)<maxarea
            FiberConfs(nn) = Eccens(nn);
        end
    end
    
    Confii = zeros(m,n);
    Orientii = zeros(m,n);
    for jj = 1:m
        for kk = 1:n
            if Label(jj,kk)~=0
                Confii(jj,kk) = FiberConfs(Label(jj,kk));
                Orientii(jj,kk) = Angles(Label(jj,kk));
            end
        end
    end
    
    Conf(:,:,ii) = Confii;
    Orient(:,:,ii) = Orientii;
    
%     for jj = 1:NumComps
%         %tic
%         [Confidence,Orientation] = fiber_conf(jj,RP);
%         %toc
%         if Confidence > 0
%             Orient(:,:,ii) = Orient(:,:,ii) + (Label==jj) .* Orientation;
%             Conf(:,:,ii) = Conf(:,:,ii) + (Label==jj) .* Confidence;
% %         else
% %             Orient(:,:,ii) = Orient(:,:,ii) + (Label==jj) .* Orientation;
%         end
%         %length(find(Orient(:,:,ii)))
%         
%     end
    
%     filename = ['thresh' num2str(ii) '_2'];
%     save(filename,'Orient')
    
end

[MAXCONF, MaxThresh] = max(Conf,[],3);

ORIENT = zeros(m,n);

for nn = 1:m
    for j = 1:n
        ORIENT(nn,j) = Orient(nn,j,MaxThresh(nn,j));
    end
end

SEGfile = ['Dalsu data/', filepath(1:end-4), '_Seg'];

save(SEGfile,'-v7.3')

figure
imshow(IM)

figure
pcolor(ORIENT + (MAXCONF==0).*-180);
hc=colorbar; shading flat; axis equal; set(gca,'YDir','reverse');

end
    
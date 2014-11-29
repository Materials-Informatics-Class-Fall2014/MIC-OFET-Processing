% clear all
% close all
% clc
% 
% 
% %% Find Angles and Confidences
% 
% load('DEV.mat');
% 
% for i = 1:length(DEV)
%     [SEGi,ORIENTi,CONFi] = Full_Seg2(DEV(i).File);
%     DEV(i).Seg = SEGi;
% end
% 
% save('DEV.mat','DEV')

%% Bin the angles
% 
% for i = 1:length(DEV)
%     disp(i)
%     MS = Bin_Angles(DEV(i).Seg,4);
%     filepath = DEV(i).File;
%     Bin_File = ['Dalsu data/', filepath(1:end-4), '_Bin'];
%     DEV(i).Bin = Bin_File;
%     save(Bin_File,'MS','-v7.3')
% end

%% Compute the Spat Stats

for i = 1:length(DEV)
    disp(i)
    load(DEV(i).Bin);
    SS = zeros(1,2161^2*4);
    [T11,xx11] = SpatialStatsFFT(MS(:,:,1),[],'periodic',false);
    [T21,xx21] = SpatialStatsFFT(MS(:,:,1),MS(:,:,2),'periodic',false);
    [T31,xx31] = SpatialStatsFFT(MS(:,:,1),MS(:,:,3),'periodic',false);
    [T41,xx41] = SpatialStatsFFT(MS(:,:,1),MS(:,:,4),'periodic',false);
    SS = [T11(:)', T21(:)', T31(:)', T41(:)'];
    filepath = DEV(i).File;
    SS_File = ['Dalsu data/', filepath(1:end-4), '_SS'];
    DEV(i).SS = SS_File;
    save(SS_File,'SS','-v7.3')
end
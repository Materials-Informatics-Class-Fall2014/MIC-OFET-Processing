clear all
close all
clc

load('DEV.mat');

for i = 7:7
    [SEGi,ORIENTi,CONFi] = Full_Seg2(DEV(i).File);
    DEV(i).Seg = SEGi;
end


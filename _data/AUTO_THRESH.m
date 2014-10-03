function out = AUTO_THRESH(grayim)

points=10;
values = linspace(.1,.9,points);
AF = zeros(1,points);

for ii = 1:points
    bwim = im2bw(grayim,values(ii));
    AF(ii) = AFRAC(bwim);
    figure
    imshow(bwim)
end

plot(values,AF,'ob')

end
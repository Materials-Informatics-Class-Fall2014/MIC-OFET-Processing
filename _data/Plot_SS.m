function out = Plot_SS(SS_Vec,xx)

figure
pcolor(fftshift(xx{2}),fftshift(xx{1}),fftshift(reshape(SS_Vec(1:2161^2,1),2161,2161)));
hc = colorbar; shading flat; axis equal;

end


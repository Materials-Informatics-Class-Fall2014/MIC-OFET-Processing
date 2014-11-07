function out = orientplot(ORIENT,MAXCONF)

ORIENT1 = ORIENT + (MAXCONF==0).*(-180);
figure
pcolor(ORIENT1); hc=colorbar; shading flat; axis equal; set(gca,'YDir','reverse');

out = 0;

end
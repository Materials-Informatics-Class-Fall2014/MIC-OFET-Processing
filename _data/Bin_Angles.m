function MS = Bin_Angles(Segpath,bins)
%% Bin Angles
% will create an (image size) x # of microstates 3D binary matrix
% Each matrix will have 1's where that microstate exists

load(Segpath);

[m,n] = size(ORIENT);

bincuts = linspace(-90,90,bins*2+1);
cuts = bincuts(2:2:end);

MS = zeros(m,n,bins+1); % microstates for all angels plus amorphous

for i = 1:m
    for j = 1:n
        if ORIENT(i,j)<=cuts(1)
            MS(i,j,1) = 1;
        elseif ORIENT(i,j)<=cuts(2)
            MS(i,j,2) = 1;
        elseif ORIENT(i,j)<=cuts(3)
            MS(i,j,3) = 1;
        elseif ORIENT(i,j)<=cuts(4)
            MS(i,j,4) = 1;
        else
            MS(i,j,1) = 1;
        end
    end
end

MS = MS.*repmat(MAXCONF~=0,[1 1 bins+1]);
MS(:,:,bins+1) = MAXCONF==0;

end
    


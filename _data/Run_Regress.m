REG = struct();

ERR = zeros(4);

for i = 1:4
    for j = 1:4
        REG((i-1)*4+j).r = MultiPolyRegress(Score(1:18,1:i),MOB,j);
        ERR(i,j) = REG((i-1)*4+j).r.CVMAE;
    end
end


        
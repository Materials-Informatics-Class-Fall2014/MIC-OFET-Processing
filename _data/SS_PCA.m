SSMAT = zeros(length(DEV),2161^2*4);

for ii = 1:length(DEV)
    load(DEV(ii).SS);
    SSMAT(ii,:) = SS;
end


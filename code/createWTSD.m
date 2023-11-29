% calculate 1-Wasserstein distance within time series
load SEF_N.mat % 3D array (reactions, samples, time points)
sz=size(SEF_N);
for x=1:sz(1)
    for t1=1:sz(3)
        for t2=1:sz(3)
            WTSD(x,t1,t2)=ws_distance(SEF_N(t1,x,:),SEF_N(t2,x,:));
            WTSD(x,t2,t1)=WTSD(x,t1,t2);
        end
    end
end
% find dis-similarity matrix of the within time series distances
for i=1:sz(1)
    for j=1:sz(1)
        WTSDD(i,j)=norm(squeeze(WTSD(i,:,:))-squeeze(WTSD(j,:,:)));
        WTSDD(j,i)=WTSDD(i,j);
    end
end
save WTSDD WTSDD
            
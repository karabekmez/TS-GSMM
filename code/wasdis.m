% calculate 1-Wasserstein distance between time series
load SEF_N.mat % 3D array (reactions, samples, time points)
sz=size(SEF_N);
for x=1:sz(1)
    for y=x:sz(1)
        for t=1:sz(3)
            D(x,y,t)=ws_distance(SEF_N(x,:,t),SEF_N(y,:,t)); 
            D(y,x,t)=D(x,y,t);
        end
        DD(x,y)=(sum((D(x,y,:).^2).^(1/sz(3)))) ;
        DD(y,x)=DD(x,y);
    end
end
save DD DD

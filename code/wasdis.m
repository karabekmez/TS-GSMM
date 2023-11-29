tic
for x=1:1881
    for y=x:1881
        for t=1:12
            D(x,y,t)=ws_distance(SEF_N(x,1:2000,t),SEF_N(y,1:2000,t));
            D(y,x,t)=D(x,y,t);
        end
        DD(x,y)=(sum((D(x,y,:).^2).^(1/12))) ;
        DD(y,x)=DD(x,y);
    end
    x
end
save DD DD
toc
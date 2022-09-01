function x1 = twostatesimfit(params,dat)

if isempty(params),
    Af = 0.9; Bf=0.2; As=0.992; Bs=0.02;  % default params
else
    Af=params(1); Bf=params(2); As=params(3); Bs=params(4);
end

[xslow,xfast,xtot] = deal([]);

for k1 = 1 : length(dat),
    rot = dat{k1}.rot;
    EC = dat{k1}.EC;
    FF = dat{k1}.FF;
    
    N = length(rot);
    [xf,xs,e] = deal(zeros(N,1));
    
    for k = 1:N-1,
        if EC(k)
            e(k) = 0;
        else
            e(k) = FF(k)-xf(k)-xs(k);
        end
        xf(k+1) = Af*xf(k)+Bf*e(k);
        xs(k+1) = As*xs(k)+Bs*e(k);
    end
    
    e(N) = 1-xf(N)-xs(N);
    
    xtot = xs+xf;
    xslow = xs;
    xfast = xf;
    
    save('xf_error','xf')
end

x1 = [xtot];% xfast xslow];

return
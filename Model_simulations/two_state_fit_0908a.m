function x1 = two_state_fit_0908a(params,dat)
%evaluates the model at the specified parameters

Af=params(1); Bf=params(2); As=params(3); Bs=params(4);

[xslow,xfast,xtot] = deal([]);

for k1 = 1 : length(dat),
    EC = dat{k1}.EC;
    FF = dat{k1}.FF;
    
    N = length(FF);
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
    
    %save('xf_error','xf')
end

%depending on the nonlinear estimation function called, it will either need
%the current estimate of xtot, the residuals, or even xtot at the secific
%index being evaluated
x1 = [xtot(find(EC))]';% xfast xslow];

%keyboard;

return
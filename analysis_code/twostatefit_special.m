function x1 = twostatefit_special(params,ff_input)

%Smith 2006
% As=.992;
% Af=.59;
% Bf =.21;
% Bs=.02;

if isempty(params),
    Af = 0.6; Bf=0.2; As=0.992; Bs=0.02;  % default params
else
    Af=params(1); Bf=params(2); As=params(3); Bs=params(4);
end

N = length(ff_input.ff);
ec=isnan(ff_input.ff);
f = ff_input.ff(:);
%p = params;
[xf,xs,e]=deal(zeros(N+1,1));
for k=1:N,
    if ~ec(k), e(k) = f(k) - [ xf(k) + xs(k) ]; else e(k) = 0; end
    xf(k+1) = Af*xf(k) + Bf*e(k);
    xs(k+1) = As*xs(k) + Bs*e(k);
end
z.xf = xf(2:end);
z.xs = xs(2:end);
z.x = z.xf + z.xs;
z.e = e(1:end-1);
z.f = f;
z.all = [z.xf, z.xs, z.x, z.e, z.f];

x1 = [z.x];% xfast xslow];

return
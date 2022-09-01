function y =window_as(x)

[ns,nt] = size(x);
y = zeros(ns/3,nt);
c = 1;
for i=1:3:ns
    
    y(c,:) = nanmean(x(i:i+2,:),1);
    c=c+1;
end





return
close all;
hold_per = 15;

k=20;
num_trials = k;
ramp = num_trials - hold_per;

%first do log
%temp_log = [(1/hold_per)*(1:ramp).^(log((hold_per))/log(num_trials))];
%temp_log = temp_log(1:ramp);
 %temp_log = [(1/num_trials)*(1:num_trials).^(log(ramp)/log(num_trials))];
 %temp_log(end-hold_per:end) = 1;
 %if ramp==1, temp_log=1; end
%temp_log = ff_log(1:ramp);

temp_log = [(1/hold_per)*(1:num_trials).^(log((hold_per))/log(ramp))];
temp_log = [temp_log'; ones(hold_per,1)];

%now linear
temp_linear = [1:ramp]'/ramp;
temp_linear = [temp_linear; ones(hold_per,1)];

figure; hold on; plot(temp_linear); plot(temp_log);

close all;
for i=20
    
    ramp = i-15;
    k=i;
    
    ff_log=[1/ramp*(1:k).^(log(ramp)/log(k))];
    nff_log = ff_log(2:2:end);
    %ff_log=[1/15*(1:i).^(log(15)/log(i))];
    figure; hold on; plot(nff_log,'k'); plot([1:i]/i); plot(ones(i,1));
end
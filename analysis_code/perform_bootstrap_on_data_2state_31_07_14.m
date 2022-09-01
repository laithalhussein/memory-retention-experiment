function [As_boot,Af_boot,b_boot,c_boot,unlearning_est]=perform_bootstrap_on_data_2state_31_07_14(subject_data,iteration)
%NOTE: Add option for parametric bootstrap: shuffle residuals within each subject (for a better estimate of that subject's parameters) and then shuffle across subjects 
decay_trials=[1:30]';

unlearning_est=[];
boot_strap_data=[];             boot_strap_ndx=[];
t_boot=zeros(iteration,1);      a_boot=zeros(iteration,1);      b_boot=zeros(iteration,1);
warning('off','all');
for nn=1:iteration 
    boot_strap_sample=nan;
    while sum(isnan(boot_strap_sample))
        b=randsample(size(subject_data,1),size(subject_data,2),'true');
        boot_strap_sample=diag(subject_data(b,:));
    end
    boot_strap_data=[boot_strap_data,boot_strap_sample];
    boot_strap_ndx=[boot_strap_ndx,b];
    [fit_to_decay_boot,~,~]=calculate_2state_fit_for_data_31_07_14(decay_trials,boot_strap_sample);
    As_boot(nn,1)=fit_to_decay_boot.As;
    Af_boot(nn,1)=fit_to_decay_boot.Af;
    b_boot(nn,1)=fit_to_decay_boot.b;
    c_boot(nn,1)=fit_to_decay_boot.c;
    unlearning_est=[unlearning_est,fit_to_decay_boot(decay_trials)];
end
unlearning_est=mean(unlearning_est,2);
end
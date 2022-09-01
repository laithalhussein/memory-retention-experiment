function [tau_boot,const_boot]=perform_bootstrap_on_data_timeconst_5_30_16(subject_data,iteration)
%NOTE: Add option for parametric bootstrap: shuffle residuals within each subject (for a better estimate of that subject's parameters) and then shuffle across subjects 

% [~,num_trials]=size(subject_data);
% trials=[1:num_trials]';
trials = [1:2:60]';

boot_strap_data=[];             boot_strap_ndx=[];
tau_boot=zeros(iteration,1);      const_boot=zeros(iteration,1);        scale_boot=zeros(iteration,1);
warning('off','all');
for nn=1:iteration 
    boot_strap_sample=nan;
    while sum(isnan(boot_strap_sample))
        b=randsample(size(subject_data,1),size(subject_data,2),'true'); %randomly sampling, w/ replacement, the subjects that will determine the bootstrap sample
        boot_strap_sample=diag(subject_data(b,:)); %obtaining the bootsrap sample from the data. Diag works since we arranged it so that we want the first data point 
                                                   %from the 1st subject, the second point from the second subject, etc...
    end
    boot_strap_data=[boot_strap_data,boot_strap_sample];
    boot_strap_ndx=[boot_strap_ndx,b]; %the subject, not the data, indeces
    [tau,const]=calculate_exp_fit_for_data_5_30_16(trials,boot_strap_sample);
%     scale_boot(nn,1)=tau;
    tau_boot(nn,1)=tau;
    const_boot(nn,1)=const;
end
%mean(scale_boot)
% mean(tau_boot)
% mean(const_boot)
end

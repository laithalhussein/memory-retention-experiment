function [sample,idx] = shuffle_data(subject_data)
    boot_strap_sample=nan;
    while sum(isnan(boot_strap_sample))
        b=randsample(size(subject_data,1),size(subject_data,2),'true'); %the subjects that will determine the bootstrap sample
        boot_strap_sample=diag(subject_data(b,:)); %obtaining the bootsrap sample from the data. 
        %Diag works since we arranged it so that we want the first data point 
        %from the 1st subject, the second point from the second subject, etc...
    end

idx = b;
sample = boot_strap_sample;
end
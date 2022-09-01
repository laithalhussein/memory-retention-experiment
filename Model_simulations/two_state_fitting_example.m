%%%an example script for fitting the 2-state model
close all; 
clear all;
home;

%load in a generic learning curve (y) and the corresponding EC trial indices (x)
load('eg_data.mat');

%first make the training schedule. For illustration purposes, I will assume
%trials were either FF or EC trials
FF_idx = ones(x(end),1);
FF_idx(x) = 0;
EC_idx = ~FF_idx;

%save the indices into a struct to pass into the model function
ts{1}.FF = FF_idx;     ts{1}.EC = EC_idx; %holds the training schedule

%we'll use lsqcurvefit for a quick demonstration
initial_guess=[0.6 0.2 0.992 0.02];
options=statset('FunValCheck','off');
p = lsqcurvefit(@two_state_fit_0908a,initial_guess,ts,y,[],[],options); %the 5th and 6th arguments here set upper and lower bounds, but there's no need for that
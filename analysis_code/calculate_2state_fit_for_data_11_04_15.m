function [Af,Bf,As,Bs,delta]=calculate_2state_fit_for_data_11_04_15(input,data,initial_guess)
%input is a cell array. Each cell array index corresponds to one experiment and is a struct that contains EC and FF.
%EC and FF are the tgt files for the entire respective experiment (all
%epochs) -> put a 1 for EC's in EC and a 1 for FF's in FF (otherwise it's 0)
%Example: input{1}.EC = [learning_ec_ndx ; decay_ec_ndx];

%data should be a column vector

%NOTE: if you include multiple experiments, the output will be concatinated and will thus need to be cut as of 11/10/2015; 
%change this in future update

%NOTE: probably a good idea to include a baseline period or a 0,0 point in the beginning of the data

%NOTE: Since we're using nlinfit the boundary conditions need to be included in the model

%Smith 2006
% As=.992;
% Af=.59;
% Bf =.21;
% Bs=.02;

%e.g.
% learning_ndx=zeros(80,1);
% learning_ndx(NDX)=1;
% input{1}.EC=learning_ndx;
% % nff=ones(80,1);
% % nff(indc)=0;
% input{1}.FF = ~learning_ndx;


if isempty(initial_guess)
    initial_guess=[0.6 0.2 0.992 0.02]; %should be a reasonable place to start
end

%input.ff=input;

options=statset('FunValCheck','off');
[b,res,jac] = nlinfit(input,data,@twostatesimfit_V2,initial_guess,options); %Estimate the parameters and get the jacobian/residulas to get CI
delta=nlparci(b, res, jac);

Af=b(1); Bf=b(2);
As=b(3); Bs=b(4);
end


function [tau]=calculate_exp_fit_for_data_5_30_16(x_data,y_data)

%ignore nan's
idx = isnan(y_data);

y_data = y_data(~idx);
x_data = x_data(~idx);

%%%
fit_opt=fitoptions('method','nonlinearleastsquares','lower',[eps,0],'upper',[1,100],'display','off');
fit_type=fittype('(1-a)*exp(-(trial/t))+a','independent','trial','coefficients',{'a','t'},'options',fit_opt);
[fit_to_decay,gof_decay]=fit(x_data,y_data,fit_type);
scale_f=nan;
tau=fit_to_decay.t;
const=fit_to_decay.a;
end
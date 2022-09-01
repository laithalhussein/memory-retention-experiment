function [fit_to_decay,gof_decay,y_est]=calculate_exp_fit_for_data_30_07_14(x_data,y_data)
fit_opt=fitoptions('method','nonlinearleastsquares','lower',[-1.5,-1,eps],'upper',[1.5,1,200],'display','off');
fit_type=fittype('(a-b)*exp(-(trial/t))+b','independent','trial','coefficients',{'a','b','t'},'options',fit_opt);
[fit_to_decay,gof_decay]=fit(x_data,y_data,fit_type);
y_est=fit_to_decay(x_data);
end
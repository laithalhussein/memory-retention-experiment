function res = return_model_res(input,params,data)

x1 = twostatesimfit_V3(params,input);


res = x1 - data;


return
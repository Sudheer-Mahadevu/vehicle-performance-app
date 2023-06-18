function [P_FCPS_tot_req_kW,V_dcdc_out_V,I_dcdc_out_A] = get_P_FCPS_tot_req_kW( ...
    P_FCPS_net_req_kW,eta_FCPS_BOP_per,V_norm_battery_V)
%get_P_FCPS_tot_req_kW The power demand at dcdc converter and  its current,
%voltages Function Number - 3

%  This is the power demand by the power-train(or battery) and BOP at
% dcdc converter

P_BOP_Req_kW = (eta_FCPS_BOP_per/100)*P_FCPS_net_req_kW;
P_FCPS_tot_req_kW = P_FCPS_net_req_kW + P_BOP_Req_kW;

% dcdc converter outputs at battery voltage (= motor operating voltage as
% per the model)

V_dcdc_out_V(1:length(P_FCPS_tot_req_kW)) = V_norm_battery_V;
I_dcdc_out_A = P_FCPS_tot_req_kW/V_norm_battery_V;

end
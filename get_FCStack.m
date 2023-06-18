function [P_FCStack_ultm_kW,V_FCStack_V,I_FCStack_A] = get_FCStack( ...
    P_at_dcdc_kW,eta_dcdc_2_fc_per,fcStack)
%get_FC_stack The power demand at fc stack,current and voltages at fc stack
% Function Number 5

%   Detailed explanation goes here

P_FCStack_ultm_kW = P_at_dcdc_kW/(eta_dcdc_2_fc_per/100);

V_FCStack_V = interp1(fcStack.P_idx_kW,fcStack.V_idx_V,P_FCStack_ultm_kW, ...
    "linear","extrap");
I_FCStack_A = interp1(fcStack.P_idx_kW,fcStack.I_idx_A,P_FCStack_ultm_kW, ...
    "linear","extrap");

end
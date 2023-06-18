function [P_at_battery_kW,SOC_battery_per] = show_battery(battery,time, ...
    P_FCPS_net_req_kW,P_mot_req_kW,P_aux_veh_kW)
%show_battery The power demand to battery and its SOC Function Number 4

%   Detailed explanation goes here


P_ramping_kW = P_mot_req_kW-P_FCPS_net_req_kW;
P_at_battery_kW = P_aux_veh_kW+P_ramping_kW; % positive indicates discharge

SOC_battery_per = zeros(1,length(time));
SOC_battery_prev_per = battery.SOC_init_per;
dt = time(2)-time(1);
N_sim = length(time);

for i= 1:dt:N_sim
    SOC_battery_per(i) = (SOC_battery_prev_per ...
        - (100*P_at_battery_kW(i)*dt/3600)/battery.max_cap_kWh);
    
    SOC_battery_prev_per = SOC_battery_per(i);
end

end
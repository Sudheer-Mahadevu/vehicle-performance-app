function [FE_raw_kmpkg,FE_cor_kmpkg,range] = efficiency(WLTP_LR_kmph,M_h2_consumed, ...
    net_battery_usage_kWh,eta_FCPS_per,h2_usable_kg,h2_LHV_kJpkg)
%efficiency calulates the efficeincies goes here function Number - 7
%   Detailed explanation goes here

time = WLTP_LR_kmph(:,1);
distance = 0;
dt = time(2)-time(1);

for i = 1:dt:length(time)
    distance = distance + dt*(WLTP_LR_kmph(i,2))/3.6;
end
distance = distance/1000;

FE_raw_kmpkg = distance/M_h2_consumed;

h2_for_battery = (net_battery_usage_kWh*3600/eta_FCPS_per)/h2_LHV_kJpkg;

FE_cor_kmpkg = distance/(M_h2_consumed-h2_for_battery);

range = h2_usable_kg*FE_cor_kmpkg;

end
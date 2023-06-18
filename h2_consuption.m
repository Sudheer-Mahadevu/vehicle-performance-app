function [M_h2_tnk_kg] = h2_consuption(M_h2_tnk_init_kg,time, ...
    P_FCPS_net_req_kW,eta_FCPS_per,h2_LHV_kJpkg)
%h2_consuption Summary of this function goes here Function Number 6
%   Detailed explanation goes here

N_sim = length(time);
dt = time(2)-time(1);
M_h2_tnk_kg = zeros(1,N_sim);
M_h2_tnk_prev_kg = M_h2_tnk_init_kg;

for i = 1:dt:N_sim
    M_h2_tnk_kg(i) = M_h2_tnk_prev_kg+( ...
        (P_FCPS_net_req_kW(i)*dt/(eta_FCPS_per/100))/h2_LHV_kJpkg);

    M_h2_tnk_prev_kg = M_h2_tnk_kg(i);
end
end
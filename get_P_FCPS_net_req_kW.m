function [P_FCPS_net_req_kW,P_mot_req_kW] = get_P_FCPS_net_req_kW(vehicle,conditions, ...
    WLTP_LR_kmph,Eta_DT_Whl_2_Mot_per,Eta_Mot_M_2_E_per, ...
    FCPS_ramp_up_rt_kWps,FCPS_ramp_dwn_rt_kWps,v_veh_regen_min_kmph)
%get_P_FCPS_Net_Req_KW The power required by the motor+ramping from the
%battery. Funtion Number 2

%   It also returns the power demand by motor alone without ramping as
%   second output. This is useful for calculating the power demand at
%   battey

    t_sim_sec = max(WLTP_LR_kmph(:,1));
    dt = WLTP_LR_kmph(2,1)-WLTP_LR_kmph(1,1);
    N_sim = length(WLTP_LR_kmph(:,1));

    F_res_whl_N = zeros(1,N_sim);
    w_whl_rad = zeros(1,N_sim);
    w_mot_rad = zeros(1,N_sim);
    T_whl_Nm = zeros(1,N_sim);
    T_mot_Nm = zeros(1,N_sim);
    P_mot_req_kW = zeros(1,N_sim); % Power demand by motor (its 
                                                        % eta considered)
    P_FCPS_net_req_kW = zeros(1,N_sim); % Power demand to FCPS (ramping
                                              % action by battery included)
    
    P_mot_req_prev_kW = 0;
    WLTP_LR_prev_kmph = 0;
    P_FCPS_net_req_prev_kW = 0;
    g = 9.81;
    grad = atan(conditions.gradient/100);
    
    
    for i = 1:dt:t_sim_sec
        
        F_res_whl_N(i) = vehicle.mass*((WLTP_LR_kmph(i,2)- ...
                         WLTP_LR_prev_kmph)/(3.6*dt) + ...
                         g*sin(grad)+(conditions.mu*g*cos(grad)))+( ...
                         0.5*conditions.air_density*conditions.Cd* ...
                         vehicle.area*(WLTP_LR_kmph(i,2)/3.6)^2);

        w_whl_rad(i) = WLTP_LR_kmph(i,2)/(3.6*vehicle.wheel_radius);
        w_mot_rad(i) = w_whl_rad(i)*vehicle.gear_ratio;

        T_whl_Nm(i) = F_res_whl_N(i)*vehicle.wheel_radius;
        T_mot_Nm(i) = (T_whl_Nm(i)/vehicle.gear_ratio)/( ...
            Eta_DT_Whl_2_Mot_per/100);

        P_mot_req_kW(i) = (T_mot_Nm(i)*w_mot_rad(i)/1000)/( ...
            Eta_Mot_M_2_E_per/100);

        % Detremine the overall energy demand from FCPS taking power for 
%         ramping action by battery included

        if(P_mot_req_kW(i)>0)
            if(P_mot_req_kW(i) > P_mot_req_prev_kW)
                P_FCPS_net_req_kW(i) = min(P_mot_req_kW(i), ...
                    (P_FCPS_net_req_prev_kW+FCPS_ramp_up_rt_kWps*dt));
            else
                P_FCPS_net_req_kW(i) = max(P_mot_req_kW(i), ...
                    (P_FCPS_net_req_prev_kW-FCPS_ramp_dwn_rt_kWps*dt));
            end
        else
            % This negative power is used to charge battrey and not given
            % back to FCPS
            P_FCPS_net_req_kW(i) = max(0, ...
                P_FCPS_net_req_prev_kW-FCPS_ramp_dwn_rt_kWps*dt);

            if(WLTP_LR_kmph(i,2)<v_veh_regen_min_kmph)
                % No regeration below 5kmph
                P_mot_req_kW(i) = 0;
            end

        end
        
        WLTP_LR_prev_kmph = WLTP_LR_kmph(i,2);
        P_FCPS_net_req_prev_kW = P_FCPS_net_req_kW(i);
        P_mot_req_prev_kW = P_mot_req_kW(i);
    end

end
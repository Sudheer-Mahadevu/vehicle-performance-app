function [t_Prf_Idx_sec,v_Whl_Prf_mps,v_Whl_Top_Spd_kmph,t_20_2_50_kmph,F_Whl_Res_Prf_N,F_App_Whl_Prf_N] = get_Veh_Prf(T_Sim_Prf,M,A,r_Whl,GR,W_Mot_Idx_RPM,T_Mot_Max_Cnt_Idx_Nm, ...
        mu,Grd_prf,rho,Cd)
%Calculate vehicle speed/performance

%{
Calculate v(t) for a vehile of given motor charecteristics and load
charecteristics (like road grad, friction charecteristics and windspeed
etc), all assumed to be constant wrt time
%}

% Prf => performance
dt_Prf = 0.1;
t_Prf_Idx_sec = 0:dt_Prf:T_Sim_Prf;
N_Prf = length(t_Prf_Idx_sec);
g = 9.81;

% Initial assignments
v_Whl_Prf_Prev_mps = 0;
v_Whl_Prf_mps = zeros(1,N_Prf);
w_Whl_Prf_rad = zeros(1,N_Prf);
w_Mot_Prf_rad = zeros(1,N_Prf);
F_Whl_Res_Prf_N = zeros(1,N_Prf);
F_App_Whl_Prf_N = zeros(1,N_Prf);

% Gradient definition
Grd_prf = atan(Grd_prf/100);
F_fixed_res = M*g*sin(Grd_prf) + mu*M*g*cos(Grd_prf);

% When vehicle cannot start : 130Nm is the torque at 0 rpm
if 130*GR/r_Whl < F_fixed_res
    F_App_Whl_Prf_N(1:end) = 130*GR/r_Whl;
    F_Whl_Res_Prf_N(1:end) = 130*GR/r_Whl;
    v_Whl_Top_Spd_kmph = 0;
    t_20_2_50_kmph = -1;
    return
end

%{
At each time step,
Calculate the resistance force
Calculate the applied force by the engine based on the rpm from engine spec
Calculate the net force and add the incremet in velocity
%}


for i = 1:N_Prf
    F_Whl_Res_Prf_N(i) = F_fixed_res + 0.5*rho*Cd*A*(v_Whl_Prf_Prev_mps)^2;
    w_Whl_Prf_rad(i) = v_Whl_Prf_Prev_mps/r_Whl;
    w_Mot_Prf_rad(i) = w_Whl_Prf_rad(i)*GR;
    F_App_Whl_Prf_N(i) = GR*interp1(W_Mot_Idx_RPM,T_Mot_Max_Cnt_Idx_Nm, ...
        (w_Mot_Prf_rad(i)*60/(2*pi)),"linear","extrap")/r_Whl;
    v_Whl_Prf_mps(i) = v_Whl_Prf_Prev_mps+(dt_Prf/M)*(F_App_Whl_Prf_N(i)- ...
        F_Whl_Res_Prf_N(i));

    % When Applied force equals resistance force,maximum velocity is
    % reached and remains constant
    if v_Whl_Prf_Prev_mps == v_Whl_Prf_mps(i) || i == N_Prf
        v_Whl_Top_Spd_kmph = v_Whl_Prf_Prev_mps*3.6;
    end

    v_Whl_Prf_Prev_mps = v_Whl_Prf_mps(i);
end


%Get the speeds only till max speed as intrep1 accepts only unique values
unique_speeds = uniquetol(v_Whl_Prf_mps);

%Calculate time taken to increase speed form 20 kmph to 50 kmph
if(v_Whl_Top_Spd_kmph < 50)
    t_20_2_50_kmph = -1;
    % -1 indicates 50kmph cannot be attained
else
    t_0_2_20_kmph = interp1(unique_speeds*3.6, ...
        t_Prf_Idx_sec(1:length(unique_speeds)),20,"linear","extrap");
    t_0_2_50_kmph = interp1(unique_speeds*3.6, ...
        t_Prf_Idx_sec(1:length(unique_speeds)),50,"linear","extrap");
    t_20_2_50_kmph = t_0_2_50_kmph-t_0_2_20_kmph;
end

disp("Get_Veh_Prf function sucessfully run")

end

% The input and output arguments are many. Defining an objects for input and
% outputs can make code nice 
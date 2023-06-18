classdef FCStack
    %UNTITLED5 Summary of this class goes here
    %   Detailed explanation goes here

    properties
        V_idx_V,I_idx_A,P_idx_kW
    end

    methods
        function obj = FCStack(V_idx_V,I_idx_A)
            %UNTITLED5 Construct an instance of this class
            %   Detailed explanation goes here
            obj.V_idx_V = V_idx_V;
            obj.I_idx_A = I_idx_A;
            obj.P_idx_kW =10^-3*(V_idx_V.*I_idx_A);
        end

%         function outputArg = method1(obj,inputArg)
%             %METHOD1 Summary of this method goes here
%             %   Detailed explanation goes here
%             outputArg = obj.Property1 + inputArg;
%         end
    end
end
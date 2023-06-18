classdef Battery
    %UNTITLED Summary of this class goes here
    %   Detailed explanation goes here

    properties
        max_cap_kWh,SOC_init_per,V_norm_V
    end

    methods
        function obj = Battery(V_norm_V,max_cap_kWh,SOC_init_per)
            %UNTITLED Construct an instance of this class
            %   Detailed explanation goes here
            obj.max_cap_kWh = max_cap_kWh;
            obj.V_norm_V = V_norm_V;
            obj.SOC_init_per = SOC_init_per;
        end

%         function outputArg = method1(obj,inputArg)
%             %METHOD1 Summary of this method goes here
%             %   Detailed explanation goes here
%             outputArg = obj.max_cap_kWh + inputArg;
%         end
    end
end
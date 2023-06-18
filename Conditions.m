classdef Conditions
    %UNTITLED Summary of this class goes here
    %   Detailed explanation goes here

    properties
        gradient,Cd,mu,air_density
    end

    methods
        function obj = Conditions(gradient,Cd,mu,air_density)
            %UNTITLED Construct an instance of this class
            %   Detailed explanation goes here
            obj.gradient = gradient;
            obj.Cd = Cd;
            obj.mu = mu;
            obj.air_density = air_density;
        end

%         function outputArg = method1(obj,inputArg)
%             %METHOD1 Summary of this method goes here
%             %   Detailed explanation goes here
%             outputArg = obj.Property1 + inputArg;
%         end
    end
end
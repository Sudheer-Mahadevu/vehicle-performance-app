classdef Vehicle
    %UNTITLED2 Summary of this class goes here
    %   Detailed explanation goes here

    properties
        mass,area,wheel_radius,gear_ratio
    end

    methods
        function obj = Vehicle(mass,area,wheel_radius,gear_ratio)
            %UNTITLED2 Construct an instance of this class
            %   Detailed explanation goes here
            obj.mass = mass;
            obj.area = area;
            obj.wheel_radius = wheel_radius;
            obj.gear_ratio = gear_ratio;
        end

%         function outputArg = method1(obj,inputArg)
%             %METHOD1 Summary of this method goes here
%             %   Detailed explanation goes here
%             outputArg = obj.mass + inputArg;
%         end
    end
end
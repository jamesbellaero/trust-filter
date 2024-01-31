classdef Sensor
    %UNTITLED3 Summary of this class goes here
    %   Detailed explanation goes here

    properties
        pointingError
        % ny x ny
        covarianceMat 
    end

    methods
        % ny x 1
        function y = GetMeasurement(obj,aEntityState,aTargetState)
            % Combine sensor state with entity state to get absolute state

        end

        % ny x nx
        function H = GetMeasurementDerivative(obj,aEntityState,aTargetState)
            % Return the jacobian for the measurement w.r.t. state
        end
        function state = GetState(obj,aEntityState,aTargetState)
            % Use estimated states of both entity and target to determine
            % pointing direction, then append to true location and add an
            % estimated location and estimated pointing direction if error
            % is desired.
        end
    end
end
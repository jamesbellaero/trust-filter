classdef State
    %UNTITLED5 Summary of this class goes here
    %   Detailed explanation goes here

    properties
        truth
        estimate
        covariance
    end

    methods
        function obj = State(truth,estimate,covariance)
            obj.truth = zeros(6,1);
            obj.estimate=zeros(6,1);
            obj.covariance=eye(6,6);
            if(nargin > 0)
                obj.truth=truth;
                obj.estimate=truth;
            end
            if(nargin>1)
                obj.estimate = estimate;
            end
            if(nargin>2)
                obj.covariance=covariance;
            end
        end
    end
end
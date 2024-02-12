classdef Entity < handle
    %UNTITLED Summary of this class goes here
    %   Detailed explanation goes here

    properties
        % Trust list
        trustList
        % State
        state
        % Sensor list
        sensorList
        % Controllers
        controller
        % Previous update time
        prev_time
        % Measurements
        measurements_for_processing
        % Propagator
        dynamics_model
        % Filter
        filter
    end

    methods
        function obj = Entity()
            % Nargin check:
            % Superclass initialization:
            % obj = obj@BaseClass(args);
            obj.prev_time = 0;

            obj.state = State();

        end
        function measurements = make_measurements(obj,time,target,params)
            measurements = [];
            for model = measurement_models
                if(model.can_view(true_state,target))
                    meas = Measurement();
                    meas.time = time;
                    meas.entityState = obj.state;
                    meas.targetState = target.state;
                    meas.model = model;
                    measurements(end+1) = meas;
                end
            end
        end

        function [obj] = propagate(obj,time,entity_list,params)
            %METHOD1 Summary of this method goes here
            %   Detailed explanation goes here
            if(~isempty(obj.controller))
                control_force = obj.controller.GetControl(time,obj.state,entity_list,params);
            else
                control_force = zeros(3,1);
            end

            if(~isempty(obj.dynamics_model))
                [~,truth_t] = ode45(@(t,y) obj.dynamics_model(t,y,control_force,params),[obj.prev_time,time],obj.state.truth);
                obj.state.truth = truth_t(end,:)';
            end

            % Estimate propagation and trust propagation occur here
            
            obj.prev_time = time;
        end

        function [obj] = update(obj,params)
            % it should be possible to get the 
        end

        function [obj] = add_sensor(obj,model)
            obj.sensorList(end+1) = model;
        end

        function [obj] = add_measurements_for_processing(obj,measurements)
            obj.measurements_for_processing = [obj.measurements_for_processing,measurements];
        end
    end

end
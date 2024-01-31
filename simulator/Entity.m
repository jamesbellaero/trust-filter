classdef Entity
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
        measurements_for_processing
    end

    methods
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
            control_force = obj.controller.GetControl(time,obj.state,entity_list,params);
            
        end

        function [obj] = update(obj,params)
            % it should be possible to get the 
        end

        function [obj] = add_sensor(obj,model)
            obj.sensorList(end+1) = model;
        end

        function [obj] = add_measurements_for_processing(obj,measurements)
            obj.measurements_for_processing = [obj.measurements_to_process,measurements];
        end
    end

end
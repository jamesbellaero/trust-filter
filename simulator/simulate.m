function [state_hist,measurement_hist] = simulate(time_list,entity_list,params)
%simulate Summary of this function goes here
%   Detailed explanation goes here

nt = length(time_list);
ne = length(entity_list);

state_hist(nt,ne) = State;

% This will be massive if actually returned. May be unwise to log.
measurement_hist = [];

% Add starting state to history
for i = 1:ne
    state_hist(1,i) = entity_list(i).state;
end
    

% Create outputs
% Loops over time list
for i = 2:nt
    time = time_list(i);
    % Call propagate for all identities
    for j = 1:ne
        % If we're slow, ensure that entity_list is a reference and not a
        % value. Matlab doesn't give much control over it unfortunately.
        entity_list(j).propagate(time,entity_list,params);
    end
    % Call measurements for all entities. This can be parallelized.
    for sensing_entity = entity_list
        for j = 1:ne
            if(isequal(sensing_entity,entity_list(j)))
                continue
            end
            % make measurements
            measurements = sensing_entity.make_measurements(time,entity_list(j),params);
            entity_list(j).add_measurements_for_processing(measurements);
        end
    end
    
    % Call update for all entities
    for j = 1:ne
        entity_list(j).update();
        % Log states
        state_hist(i,j) = entity_list(j).state;
    end
    
    
    
end













end
% Environment

path = split(pwd,"\");
if(strcmp(path{end},'scenarios'))
    addpath("../simulator","../frames","../propagators","../3rd_party","../utility");
end
format longg

% Setup params
params.muE = 3.986004418e14;
params.muL = 4.9028001e12;
times = linspace(0,5000,10);

% Create entities
test_orb = Entity();
test_orb.state.truth = [6.778e6;0;0;0;7.778e3;0];
test_orb.dynamics_model = @twoBody;

% Add measurement models

% Run simulation
state_hist = simulate(times,[test_orb],params);

% Plot outputs
concat_truths_cell = arrayfun(@(s) s.truth', state_hist,'UniformOutput',false);
concat_truths = cell2mat(concat_truths_cell)';














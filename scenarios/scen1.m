% Environment

path = split(pwd,"\");
if(strcmp(path{end},'scenarios'))
    addpath("../simulator","../frames","../propagators","../3rd_party","../utility");
end 
format longg

% Setup params
params.muE = 3.986004418e5;
params.muL = 4.9048695e3;

params.mean_motion = 2*pi/27.321662/86400;
params.jd0 = 2460324.391192;
nDays = 1;
params.jd1 = params.jd0+nDays;

times = linspace(0,nDays*86400,145);

% Grab moon state
jd0 = params.jd0;
jd1 = params.jd1;
[ephemLuna,~] = getLunarEphem(jd0,jd1,times(2)-times(1),0);
ephemLuna = ephemLuna';
ephemLuna(2:7,:) = ephemLuna(2:7,:);
params.rL = ephemLuna(2:4,1);%3.84e8; % meters
params.ephemLuna = ephemLuna;
% Grab Themis state
% target = "-1176";
% center = "500@3";
% frame = "REF_PLANE";
% [ephemCap,~] = getTargetEphem(jd0,jd1,times(2)-times(1),target,center,frame,0);
% 
% target = "301";
% center = "500@3";
% frame = "REF_PLANE";
% [ephemLunaEmbfIcrf,~] = getTargetEphem(jd0,jd1,times(2)-times(1),target,center,frame,0);
% ephemLunaEmbf = zeros(size(ephemLuna));
% ephemCapEmbf = zeros(size(ephemCap));
% for i=1:length(ephemLuna)
%     [rCapEmbf,vCapEmbf] = convertIcrf2Crtbp(ephemCap(i,2:4)',...
%         ephemCap(i,5:7)',ephemLuna(2:4,i),ephemLuna(5:7,i),params);
%     ephemCapEmbf(2:7,i) = [rCapEmbf;vCapEmbf];
% 
%     [rLunaEmbf,vLunaEmbf] = convertIcrf2Crtbp(ephemLunaEmbfIcrf(i,2:4)',...
%         ephemLunaEmbfIcrf(i,5:7)',ephemLuna(2:4,i),ephemLuna(5:7,i),params);
%     ephemLunaEmbf(2:7,i) = [rLunaEmbf;vLunaEmbf];
% end


% Create entities
test_orb_grace = Entity();
test_orb_lro = Entity();
test_orb_themis = Entity();
test_orb_cap = Entity();
%test_orb.state.truth = [6.778e6;0;0;0;7.778e3;0];
%test_orb.dynamics_model = @twoBody;
test_orb_grace.state.truth = [-361.105837315872;-135.22404792727;6807.1148292717;...
                        7.61848139291155;0.38259225615281;0.413784286922971];
test_orb_lro.state.truth = [ephemLro(2:4,1);ephemLro(5:7,1)];
%test_orb_themis.state.truth = [ephemThemis(1,2:4)';ephemThemis(1,5:7)'];
%test_orb_cap.state.truth = [ephemCapEmbf(2:4,1);ephemCapEmbf(5:7,1)];
test_orb_grace.dynamics_model = @(t,y,control)twoBody(t,y,control,params.muE);
test_orb_lro.dynamics_model = @(t,y,control)twoBody(t,y,control,params.muL);
test_orb_themis.dynamics_model = @(t,y,control)threeBody(t,y,control,params);
test_orb_cap.dynamics_model = @(t,y,control)crtbp(t,y,control,params);

% Add measurement models

% % Run simulation
state_hist = simulate(times,[test_orb_grace,test_orb_lro],params);
%state_hist = simulate(times,[test_orb_cap],params);
% 
% % Plot outputsa
concat_truths_cell = arrayfun(@(s) s.truth', state_hist,'UniformOutput',false);
concat_truths = cell2mat(concat_truths_cell)';
truths_grace = concat_truths(1:6,:);
truths_lro = concat_truths(7:12,:);
% truths_themis = concat_truths(13:18,:);

% truths_cap = concat_truths(1:6,:);






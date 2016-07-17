clc;
clear all;

% Uncomment a certain block and keep all others commented



%-----------------------------------------------------------------------%

% Here multiple conditions are created, all conditions will be executed for
% all months.

m = [500 500 500 500 500 800 1000 500];
z = [0.3, 0.6, 0.6, 0.9 0.3 0.6 0.6 0.6];
s = [1 1 1 1 4 1 1 1];
isCloudy = [0 0 1 0 0 0 0 0];
isCloudFactor = [0 0 0 0 0 0 0 1];
for k=1:length(m)
    for j=1:12
        [Power, Ich, I, R, Vd, Vm, SOC, Ga] = solarCar(j,m(k),z(k),s(k),isCloudy(k),isCloudFactor(k));
        str = strcat('matfiles/mo', num2str(j),'_m',num2str(m(k)),'_sp',num2str(z(k)*10),'_st', num2str(s(k)), '_ic',num2str(isCloudy(k)),'_icf',num2str(isCloudFactor(k)),'.mat');
        save(str, 'Power', 'Ich', 'I', 'R', 'Vd', 'Vm', 'SOC', 'Ga');
        st1 = strcat('Condition = ',num2str(k),' Month = ', num2str(j));
        disp(st1);
    end
end

%-----------------------------------------------------------------------%






%-----------------------------------------------------------------------%

% Here multiple conditions are created, all conditions will be executed for
% three seasons.

% m = [500 500 500 500 500 800 1000 500];
% z = [0.3, 0.6, 0.6, 0.9 0.3 0.6 0.6 0.6];
% s = [1 1 1 1 4 1 1 1];
% isCloudy = [0 0 1 0 0 0 0 0];
% isCloudFactor = [0 0 0 0 0 0 0 1];
% for k=1:length(m)
%     for j=[3, 6, 12]
%         [Power, Ich, I, R, Vd, Vm, SOC, Ga] = solarCar(j,m(k),z(k),s(k),isCloudy(k),isCloudFactor(k));
%         str = strcat('mo', num2str(j),'_m',num2str(m(k)),'_sp',num2str(z(k)*10),'_st', num2str(s(k)), '_ic',num2str(isCloudy(k)),'_icf',num2str(isCloudFactor(k)),'.mat');
%         save(str, 'Power', 'Ich', 'I', 'R', 'Vd', 'Vm', 'SOC', 'Ga');
%         st1 = strcat('Condition = ',num2str(k),' Month = ', num2str(j));
%         disp(st1);
%     end
% end

%-----------------------------------------------------------------------%





%-----------------------------------------------------------------------%

% Here a single conditions is created, the condition will be executed for
% all months.

% m = 500;
% z = 0.3;
% s = 1;
% isCloudy = 0;
% isCloudFactor = 1;
% for k=1:length(m)
%     for j=1:12
%         [Power, Ich, I, R, Vd, Vm, SOC, Ga] = solarCar(j,m(k),z(k),s(k),isCloudy(k),isCloudFactor(k));
%         str = strcat('mo', num2str(j),'_m',num2str(m(k)),'_sp',num2str(z(k)*10),'_st', num2str(s(k)), '_ic',num2str(isCloudy(k)),'_icf',num2str(isCloudFactor(k)),'.mat');
%         save(str, 'Power', 'Ich', 'I', 'R', 'Vd', 'Vm', 'SOC', 'Ga');
%         st1 = strcat('Condition = ',num2str(k),' Month = ', num2str(j));
%         disp(st1);
%     end
% end

%-----------------------------------------------------------------------%







%-----------------------------------------------------------------------%

% Here a condition is created, the condition will be executed for
% all seasons.

% m = 500;
% z = 0.3;
% s = 1;
% isCloudy = 0;
% isCloudFactor = 1;
% for k=1:length(m)
%     for j=[3, 6, 12]
%         [Power, Ich, I, R, Vd, Vm, SOC, Ga] = solarCar(j,m(k),z(k),s(k),isCloudy(k),isCloudFactor(k));
%         str = strcat('mo', num2str(j),'_m',num2str(m(k)),'_sp',num2str(z(k)*10),'_st', num2str(s(k)), '_ic',num2str(isCloudy(k)),'_icf',num2str(isCloudFactor(k)),'.mat');
%         save(str, 'Power', 'Ich', 'I', 'R', 'Vd', 'Vm', 'SOC', 'Ga');
%         st1 = strcat('Condition = ',num2str(k),' Month = ', num2str(j));
%         disp(st1);
%     end
% end

%-----------------------------------------------------------------------%

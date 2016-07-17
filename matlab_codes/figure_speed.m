clc;
clear all;

%--------------------------------------------------------------------%
m = [500 500 500 500];
z = [0.9 0.6 0.3 0.3];
s = [1 1 1 4];
isCloudy = [0 0 0 0];
isCloudFactor = [0 0 0 0];
% Only for spring
month = [3 3 3 3];
for k=1:length(m)
    j = month(k);
    str = strcat('matfiles/speed/mo', num2str(j),'_m',num2str(m(k)),'_sp',num2str(z(k)*100),'_st', num2str(s(k)), '_ic',num2str(isCloudy(k)),'_icf',num2str(isCloudFactor(k)),'.mat');
    
    % Uncomment the follwoing two lines if mat file is not available,
    % or you want to change conditions
    % [Power, Ich, I, R, Vd, Vm, SOC, Ga] = solarCar(j,m(k),z(k),s(k),isCloudy(k),isCloudFactor(k));
    % save(str, 'Power', 'Ich', 'I', 'R', 'Vd', 'Vm', 'SOC', 'Ga');
    
    load(str);
    SOCarray(k, :) = SOC;
    
    % This output helps you to know at which point the simulation is
    st1 = strcat('Condition = ',num2str(k),' Month = ', num2str(j));
    disp(st1);
end

X1 = (1:86400)/3600;
YMatrix1 = SOCarray*100;

figure1 = figure('Position', [100, 100, 500, 250]);

axes1 = axes('Parent',figure1,'FontWeight','bold',...
    'FontName','Times New Roman');

xlim(axes1,[7 19]);
ylim(axes1,[60 102]);

box(axes1,'on');

hold(axes1,'all');

plot(X1,YMatrix1,'LineWidth',2,'Color',[0 0 0],'Parent',axes1);

xlabel('Hour','FontWeight','bold','FontName','Times New Roman');

ylabel('SOC(%)','FontWeight','bold','FontName','Times New Roman');

annotation(figure1,'textbox',[0.854 0.447000000000001 0.086 0.112],...
    'String',{'(b)'},...
    'FontName','Times New Roman',...
    'LineStyle','none');

annotation(figure1,'textbox',[0.854 0.519 0.086 0.112],'String',{'(c)'},...
    'FontName','Times New Roman',...
    'LineStyle','none');

annotation(figure1,'textbox',[0.854 0.583000000000001 0.086 0.112],...
    'String',{'(d)'},...
    'FontName','Times New Roman',...
    'LineStyle','none');

annotation(figure1,'textbox',[0.854 0.303 0.084 0.112],'String',{'(a)'},...
    'FontName','Times New Roman',...
    'LineStyle','none');

saveas(figure1, 'figures/figure_speed.fig');

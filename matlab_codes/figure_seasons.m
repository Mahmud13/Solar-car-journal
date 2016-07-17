clc;
clear all;

%--------------------------------------------------------------------%
m = [500 500 500 500];
z = [0.6 0.6 0.6 0.6];
s = [1 1 1 1];
isCloudy = [1 0 0 0];
isCloudFactor = [0 0 0 0];

%Cloudy summer, winter, spring, summer
month = [6 12 3 6];
for k=1:length(m)
    j = month(k);
    str = strcat('matfiles/seasons/mo', num2str(j),'_m',num2str(m(k)),'_sp',num2str(z(k)*100),'_st', num2str(s(k)), '_ic',num2str(isCloudy(k)),'_icf',num2str(isCloudFactor(k)),'.mat');
    
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

plot1 = plot(X1,YMatrix1,'LineWidth',2,'Color',[0 0 0],'Parent',axes1);
set(plot1(1),'LineStyle','--');

xlabel('Hour','FontWeight','bold','FontName','Times New Roman');

ylabel('SOC(%)','FontWeight','bold','FontName','Times New Roman');

annotation(figure1,'textbox',[0.854 0.347000000000001 0.086 0.112],...
    'String',{'(b)'},...
    'FontName','Times New Roman',...
    'FitBoxToText','off',...
    'LineStyle','none');

annotation(figure1,'textbox',[0.854 0.5 0.086 0.112],'String',{'(c)'},...
    'FontName','Times New Roman',...
    'FitBoxToText','off',...
    'LineStyle','none');

annotation(figure1,'textbox',[0.854 0.593000000000001 0.086 0.112],...
    'String',{'(d)'},...
    'FontName','Times New Roman',...
    'FitBoxToText','off',...
    'LineStyle','none');

annotation(figure1,'textbox',[0.854 0.203 0.084 0.112],'String',{'(a)'},...
    'FontName','Times New Roman',...
    'FitBoxToText','off',...
    'LineStyle','none');

saveas(figure1, 'figures/figure_seasons.fig');
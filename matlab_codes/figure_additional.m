clc;
clear all;

%--------------------------------------------------------------------%
m = [500 500 500 500 500 500 500 500 500 500 500 500];
z = [0.6 0.6 0.6 0.6 0.6 0.6 0.6 0.6 0.6 0.6 0.6 0.6];
s = [4 4 4 4 4 4 4 4 4 4 4 4];
isCloudy = [0 0 0 0 0 0 0 0 0 0 0 0];

%using the 2nd set of cloud factors
isCloudFactor = [2 2 2 2 2 2 2 2 2 2 2 2];
month = 1:12;

for k=1:length(m)
    j = month(k);
    str = strcat('matfiles/additional/mo', num2str(j),'_m',num2str(m(k)),'_sp',num2str(z(k)*100),'_st', num2str(s(k)), '_ic',num2str(isCloudy(k)),'_icf',num2str(isCloudFactor(k)),'.mat');
    
    % Uncomment the follwoing two lines if mat file is not available,
    % or you want to change conditions
    % [Power, Ich, I, R, Vd, Vm, SOC, Ga] = solarCar(j,m(k),z(k),s(k),isCloudy(k),isCloudFactor(k));
    % save(str, 'Power', 'Ich', 'I', 'R', 'Vd', 'Vm', 'SOC', 'Ga');
    
    load(str);
    Preq(k) = (sum(Power)+sum(I.^2.*R)+sum(Vd.*I))/3600;
    Psup(k) = sum(Ich.*Vm)/3600;
    
    % This output helps you to know at which point the simulation is
    st1 = strcat('Condition = ',num2str(k),' Month = ', num2str(j));
    disp(st1);
end

X1 = 1:12;
Y1 = Preq;
yvector1 = Psup;


figure1 = figure('Position', [100, 100, 350, 150]);

axes1 = axes('Parent',figure1,...
    'XTickLabel',{'Jan','Feb','Mar','Apr','May','Jun','Jul','Aug','Sep','Oct','Nov','Dec'},...
    'XTick',[1 2 3 4 5 6 7 8 9 10 11 12],...
    'FontWeight','bold',...
    'FontName','Times New Roman','FontSize',8);

xlim(axes1,[0.5 12.5]);
ylim(axes1,[0 1300]);

box(axes1,'on');
hold(axes1,'all');
Y5(1) = Y1(1);
Y5(2:13) = Y1;
Y5(14) = Y1(12);

plot(0:13,Y5,'LineWidth',2,'LineStyle','-.','Color',[0 0 0]);


bar(yvector1,...
    'FaceColor',[0.800000011920929 0.800000011920929 0.800000011920929],...
    'BarWidth',0.4);


xlabel({'Month'},'FontWeight','bold','FontName','Times New Roman','FontSize',8);


ylabel({'Average available energy';'(Wh/day)'},'FontWeight','bold',...
    'FontName','Times New Roman','FontSize',8);


annotation(figure1,'textbox',...
    [0.32696319018405 0.887474912307458 0.910889570552147 0.0698795180722892],...
    'String',{'Energy required for round trip (Wh/day)'},...
    'FontWeight','bold',...
    'FontName','Times New Roman',...
    'FitBoxToText','off',...
    'LineStyle','none','FontSize',8);
saveas(figure1, 'figures/figure_additional.fig');
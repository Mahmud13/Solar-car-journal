clc;
clear all;

%--------------------------------------------------------------------%
 stops = 1;
 vin = [10 30 60 30 10].*1000/3600;
 z = 0.6
 totalLen = 18*1000;
 sinput = [0.05 (0.9-z)/2 z (0.9-z)/2 0.05]*totalLen;
 m = 500;
 [~, vout, ~, Power] = powerRequired(stops,vin,sinput,m);
 save('matfiles/basiccurve.mat', 'Power');

 load('matfiles/basiccurve.mat');
 len = length(Power);
 time = 1:len;

X1 = time/60;
Y1 = vout;
Y2 = Power/1000;

figure1 = figure('Position', [100, 100, 500, 250]);

axes1 = axes('Parent',figure1,'XTickLabel','','XMinorTick','on',...
    'Position',[0.129999999999998 0.519444444444444 0.774999999999993 0.405555555555556],...
    'FontWeight','bold',...
    'FontName','Times New Roman');
%% Uncomment the following line to preserve the X-limits of the axes
 xlim(axes1,[0 40]);
%% Uncomment the following line to preserve the Y-limits of the axes
 ylim(axes1,[0 62]);
box(axes1,'on');
hold(axes1,'all');

% Create plot
plot(X1,Y1,'Parent',axes1,'LineWidth',2,'Color',[0 0 0]);

% Create xlabel
xlabel('Traveling Time (min)');

% Create ylabel
ylabel('^{ }{v(km/h)}_{ }','Units','normalized','FontWeight','bold',...
    'FontName','Times New Roman');

% Create text
text('Parent',axes1,'VerticalAlignment','top','Units','normalized',...
    'String',' a)',...
    'Position',[0.938593112917681 0.884039769754054 0],...
    'FontName','Times New Roman');

axes2 = axes('Parent',figure1,'XMinorTick','on',...
    'Position',[0.13 0.11 0.775 0.4075],...
    'FontWeight','bold',...
    'FontName','Times New Roman');

xlim(axes2,[0 40]);

ylim(axes2,[0 4.99998]);
box(axes2,'on');
hold(axes2,'all');


plot(X1,Y2,'Parent',axes2,'LineWidth',2,'Color',[0 0 0]);

xlabel('Traveling Time (min)','FontWeight','bold');

ylabel('^{ }{P(kW)}_{ }','Units','normalized','FontWeight','bold',...
    'FontName','Times New Roman');

text('Parent',axes2,'VerticalAlignment','top','Units','normalized',...
    'String',' b)',...
    'Position',[0.937751693304651 0.850340136054421 0],...
    'FontName','Times New Roman');

saveas(figure1, 'figures/figure_power.fig');
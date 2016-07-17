clc;
clear all;

%--------------------------------------------------------------------%
m = [500 800 1000];
z = [0.6 0.6 0.6];
s = [1 1 1];
isCloudy = [0 0 0];
isCloudFactor = [2 2 2];

for k=1:length(m)
    for j=1:12
        str = strcat('matfiles/carbonemission/mo', num2str(j),'_m',num2str(m(k)),'_sp',num2str(z(k)*100),'_st', num2str(s(k)), '_ic',num2str(isCloudy(k)),'_icf',num2str(isCloudFactor(k)),'.mat');
        
        % Uncomment the follwoing two lines if mat file is not available,
        % or you want to change conditions
        % [Power, Ich, I, R, Vd, Vm, SOC, Ga] = solarCar(j,m(k),z(k),s(k),isCloudy(k),isCloudFactor(k));
        % save(str, 'Power', 'Ich', 'I', 'R', 'Vd', 'Vm', 'SOC', 'Ga');
        
        load(str);
        Preq(k,j) = (sum(Power)+sum(I.^2.*R)+sum(Vd.*I))/3600;
        Psup(k,j) = sum(Ich.*Vm)/3600;
        
        % This output helps you to know at which point the simulation is
        st1 = strcat('Condition = ',num2str(k),' Month = ', num2str(j));
        disp(st1);
    end
end
Padd = Preq - Psup;
ymatrix1 = Padd'*0.637;


figure1 = figure('Position', [100, 100, 500, 250]);

colormap('gray');

axes1 = axes('Parent',figure1,...
    'XTickLabel',{'Jan','Feb','Mar','Apr','May','Jun','Jul','Aug','Sep','Oct','Nov','Dec'},...
    'XTick',[1 2 3 4 5 6 7 8 9 10 11 12],...
    'FontWeight','bold',...
    'FontName','Times New Roman');

xlim(axes1,[0.5 12.5]);
ylim(axes1,[0 1900]);
box(axes1,'on');
hold(axes1,'all');

bar1 = bar(1:12, ymatrix1,'Parent',axes1);
set(bar1(1),'FaceColor',[1 1 1],'DisplayName','500kg');
set(bar1(2),...
    'FaceColor',[0.831372559070587 0.815686285495758 0.7843137383461],...
    'DisplayName','800kg');
set(bar1(3),...
    'FaceColor',[0.501960813999176 0.501960813999176 0.501960813999176],...
    'DisplayName','1000kg');

xlabel({'Month'},'FontWeight','bold','FontName','Times New Roman');

ylabel({'gram CO_2 eq'},'FontWeight','bold','FontName','Times New Roman');

legend1 = legend(axes1,'show');
set(legend1, 'Visible','on',...
    'Position',[0.356855828220861 0.660181803162015 0.110429447852761 0.247389558232932]);

saveas(figure1, 'figures/figure_carbonemission.fig');

clc;
clear all;

%--------------------------------------------------------------------%
m = [500 800 1000];
z = [0.6 0.6 0.6];
s = [1 1 1 ];
isCloudy = [0 0 0];
isCloudFactor = [0 0 0];

for k=1:length(m)
    %for summer only, I kept the for loop to help to modify the code for
    %multiple months.
    for j=6  
        str = strcat('matfiles/mass/mo', num2str(j),'_m',num2str(m(k)),'_sp',num2str(z(k)*100),'_st', num2str(s(k)), '_ic',num2str(isCloudy(k)),'_icf',num2str(isCloudFactor(k)),'.mat');
        
        % Uncomment the follwoing two lines if mat file is not available,
        % or you want to change conditions
        %[Power, Ich, I, R, Vd, Vm, SOC, Ga] = solarCar(j,m(k),z(k),s(k),isCloudy(k),isCloudFactor(k));
        %save(str, 'Power', 'Ich', 'I', 'R', 'Vd', 'Vm', 'SOC', 'Ga');
        
        load(str);
        SOCarray(k, :) = SOC;
        % This output helps you to know at which point the simulation is
        st1 = strcat('Condition = ',num2str(k),' Month = ', num2str(j));
        disp(st1);
    end
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

annotation(figure1,'textbox',...
    [0.857925417075564 0.187791086350975 0.0839999999999997 0.112],...
    'String',{'(a)'},...
    'FontName','Times New Roman',...
    'FitBoxToText','off',...
    'LineStyle','none');

annotation(figure1,'textbox',...
    [0.856944062806672 0.378002785515321 0.0859999999999999 0.112],...
    'String',{'(b)'},...
    'FontName','Times New Roman',...
    'FitBoxToText','off',...
    'LineStyle','none');

annotation(figure1,'textbox',...
    [0.855962708537782 0.599637883008356 0.0859999999999999 0.112],...
    'String',{'(c)'},...
    'FontName','Times New Roman',...
    'FitBoxToText','off',...
    'LineStyle','none');

saveas(figure1, 'figures/figure_mass.fig');
%{
Theodore Bastian
tab111
SAGES final project
%}

%set initial rates
    emissionRate=input('What is the emission Rate? (% increase per year) ')/100;
    deforestationInit=input('What is the initial deforestation flux? (gT C per year)');
    
%set number of years to run
    years=input('How many years should I simulate? ');
    
%set initial values for each reservoir
atmosphere(1)=750;
terrestrialBiosphere(1)=600;
oceanSurface(1)=800;
deepOcean(1)=38000;
soil(1)=1500;

%human affected emissions
emissions(1)=5; %emissions rate changes from year to year based on the emissions rate

%set values for each flux
terrestrialPhotosynthesis=110/atmosphere(1);
marinePhotosynthesis=40/atmosphere(1);
terrestrialRespiration=55/terrestrialBiosphere(1);
marineRespiration=40/oceanSurface(1);
carbonDissolving=100/atmosphere(1);
evaporation=100/oceanSurface(1);
upwelling=27/deepOcean(1);
downwelling=23/oceanSurface(1);
plantDeath=55/terrestrialBiosphere(1);
plantDecay=55/soil(1);
deforestationRate=deforestationInit/terrestrialBiosphere(1);
marineDeath=4;

for t = 2:years
    %{
    resovoir(t)=resovoir(t-1)
    -sourced flux proportions*previous reservoir value
    +sink flux proportions * previous reservoir value
    %}
    
    atmosphere(t)=atmosphere(t-1)-terrestrialPhotosynthesis*atmosphere(t-1)-marinePhotosynthesis*atmosphere(t-1)-carbonDissolving*atmosphere(t-1)+terrestrialRespiration*terrestrialBiosphere(t-1)+marineRespiration*oceanSurface(t-1)+evaporation*oceanSurface(t-1)+plantDecay*soil(t-1)+deforestationRate*terrestrialBiosphere(t-1)+emissions(t-1);
    terrestrialBiosphere(t)=terrestrialBiosphere(t-1)-terrestrialRespiration*terrestrialBiosphere(t-1)-plantDeath*terrestrialBiosphere(t-1)-deforestationRate*terrestrialBiosphere(t-1)+terrestrialPhotosynthesis*atmosphere(t-1);
    oceanSurface(t)=oceanSurface(t-1)-marineRespiration*oceanSurface(t-1)-evaporation*oceanSurface(t-1)-downwelling*oceanSurface(t-1)-marineDeath+marinePhotosynthesis*atmosphere(t-1)+carbonDissolving*atmosphere(t-1)+upwelling*deepOcean(t-1);
    deepOcean(t)=deepOcean(t-1)-upwelling*deepOcean(t-1)+downwelling*oceanSurface(t-1)+marineDeath;
    soil(t)=soil(t-1)-plantDecay*soil(t-1)+plantDeath*terrestrialBiosphere(t-1);
    emissions(t)=emissions(t-1)+emissionRate*emissions(t-1)*(1-(emissions(t-1)/15));
    temp(t)=(atmosphere(t-1)-750)*.01*350/750;
end %for loop

%sets up figure for plotting
FigHandle = figure('Position', [0, 0, 1500, 900]);
t = 1:1:years; 
rows=3;
cols=3;

%plots each array
subplot(rows,cols,1)
plot(t,atmosphere(t))
title('Carbon in Atmosphere');
xlabel('Years from Now');
ylabel('Amount (Gt Carbon)');

subplot(rows,cols,2)
plot(t,terrestrialBiosphere(t),'g')
title('Terrestrial Biosphere');
xlabel('Years from Now');
ylabel('Amount (Gt Carbon)');

subplot(rows,cols,3)
plot(t,oceanSurface(t))
title('Ocean Surface');
xlabel('Years from Now');
ylabel('Amount (Gt Carbon)');

subplot(rows,cols,4)
plot(t,deepOcean(t))
title('Deep Ocean');
xlabel('Years from Now');
ylabel('Amount (Gt Carbon)');

subplot(rows,cols,5)
plot(t,soil(t),'g')
title('Soil');
xlabel('Years from Now');
ylabel('Amount (Gt Carbon)');

subplot(rows,cols,6)
plot(t,emissions(t))
title('Emissions');
xlabel('Years from Now');
ylabel('Amount (Gt Carbon)');

subplot(rows,cols,7)
plot(t,temp(t),'r')
title('Change in Temperature');
xlabel('Years from Now');
ylabel('Change in Temperature (deg C)');
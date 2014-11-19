%{
Theodore Bastian
tab111
SAGES final project
%}

year=2012;
print=0;
customNumbers=0;

if custonNumbers==0
    emissionRate=.03;
    deforestationRate=.15;
    years=100;
    
elseif customNumbers==1
    emissionRate=input('What is the emission Rate? (% from 0 to 100) ')/100;
    deforestationRate=input('What is the deforestation Rate? (% from 0 to 100) ')/100;
    years=input('How many years should I simulate? ');
end
    
%set initial values for each reservoir
atmosphere(1)=750;
terrestrialBiosphere(1)=600;
oceanSurface(1)=800;
deepOcean(1)=38000;
soil(1)=1500;

%human affected emissions
emissions(1)=5;
deforestation(1)=0;

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
deforestationRate=1.15/terrestrialBiosphere(1);
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
    deforestation(t)=deforestation(t-1);
    temp(t)=(atmosphere(t-1)-750)*.01*350/750;
end %for loop

if print == 1
atmosphere
terrestrialBiosphere
oceanSurface
deepOcean
soil
emissions
deforestation
temp
end


FigHandle = figure('Position', [0, 0, 1500, 900]);
t = 1:1:years;
rows=3;
cols=3;

subplot(rows,cols,1)
plot(t,atmosphere(t))
title('Carbon in Atmosphere');
xlabel('Years from Now');
ylabel('Amount (Gt Carbon)');

subplot(rows,cols,2)
plot(t,terrestrialBiosphere(t))
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
plot(t,soil(t))
title('Soil');
xlabel('Years from Now');
ylabel('Amount (Gt Carbon)');

subplot(rows,cols,6)
plot(t,emissions(t))
title('Emissions');
xlabel('Years from Now');
ylabel('Amount (Gt Carbon)');

subplot(rows,cols,7)
plot(t,temp(t))
title('Change in Temperature from Now');
xlabel('Years from Now');
ylabel('Degree Celcius');
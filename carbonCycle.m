%{
Theodore Bastian
tab111
%}

%set initial values for each reservoir
atmosphere(1)=750;
terrestrialBiosphere(1)=600;
oceanSurface(1)=800;
deepOcean(1)=38000;
soil(1)=1500;
emissions(1)=5; 

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

emissionRate=0.03; %we can change this
%emissionRate=input('What is the emission Rate? ')

years=10;
%years=input('How many years should I simulate? ')

for t = 2:years
    %resovoir(t)=resovoir(t-1)
    %-sourced flux proportions*previous reservoir value
    %+sink flux proportions * previous reservoir value
    
    atmosphere(t)=atmosphere(t-1)-terrestrialPhotosynthesis*atmosphere(t-1)-marinePhotosynthesis*atmosphere(t-1)-carbonDissolving*atmosphere(t-1)+terrestrialRespiration*terrestrialBiosphere(t-1)+marineRespiration*oceanSurface(t-1)+evaporation*oceanSurface(t-1)+plantDecay*soil(t-1)+deforestationRate*terrestrialBiosphere(t-1)+emissions(t-1);
    terrestrialBiosphere(t)=terrestrialBiosphere(t-1)-terrestrialRespiration*terrestrialBiosphere(t-1)-plantDeath*terrestrialBiosphere(t-1)-deforestationRate*terrestrialBiosphere(t-1)+terrestrialPhotosynthesis*atmosphere(t-1);
    oceanSurface(t)=oceanSurface(t-1)-marineRespiration*oceanSurface(t-1)-evaporation*oceanSurface(t-1)-downwelling*oceanSurface(t-1)-marineDeath+marinePhotosynthesis*atmosphere(t-1)+carbonDissolving*atmosphere(t-1)+upwelling*deepOcean(t-1);
    deepOcean(t)=deepOcean(t-1)-upwelling*deepOcean(t-1)+downwelling*oceanSurface(t-1)+marineDeath;
    soil(t)=soil(t-1)-plantDecay*soil(t-1)+plantDeath*terrestrialBiosphere(t-1);
    emissions(t)=emissionRate*emissions(t-1)*(1-(emissions(t-1)/15));
end %for loop

atmosphere
terrestrialBiosphere
oceanSurface
deepOcean
soil

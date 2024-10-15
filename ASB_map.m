clear;
clc;

%%
figure

% three glaciers
[lat1,lon1] = basin_data('imbie refined','Totten'); 
[lat2,lon2] = basin_data('imbie refined','Moscow'); 
[lat3,lon3] = basin_data('imbie refined','Vincennes Bay'); 

ASB_lat = [lat1;lat2;lat3];
ASB_lon = [lon1;lon2;lon3];



% Bedmachine coastline
[lat,lon] = bedmachine_data('coast','geo');



% Here's how to load just enough data
% to encompass your |lat,lon| dataset (the basin boundaries in this case) and
% add a 25 km buffer around it: 

[bed,x,y] = bedmachine_data('bed',[lat1;lat2;lat3],[lon1;lon2;lon3],'antarctica',...
   'buffer',50,'datum','ellipsoid'); 

imagesc(x,y,bed)
axis xy image % orients axis correctly & removes whitespace
hold on
plotps(ASB_lat,ASB_lon,'color', [0.9 0.5 0])
plotps(lat,lon,'r')
cb = colorbar; 
ylabel(cb,'bed elevation')
% Zoom into the ASB_lat, ASB_lon domain
lat_min = min(ASB_lat);
lat_max = max(ASB_lat);
lon_min = min(ASB_lon);
lon_max = max(ASB_lon);

mapzoomps([lat_max lat_min], [lon_max lon_min]) % Zoom with a 25 km buffer


%mapzoomps('sw') 
caxis([-2200 1000])
%shadem(2,[225 80]) 
cmocean('topo','pivot') 
scalebarps('location','se', 'color', 'white')


% process
%读取网格数据
clc;clear
filename='RTP15km_surf6.grd';%文件名
%打开并读取GRD文件
grid=CURIE_DEPTH(filename);

%% split grid
window=200e3;
spacing=50e3;
[xc_list,yc_list]=grid.create_centroid_list(200e3, 50e3);
%% calculate PSD
xc=xc_list(50);
yc=yc_list(50); 
sub=grid.subgrid(window, xc, yc);
%%
[K,ln_P]=grid.radial_log_PSD(sub);
%%
grid.plot_PSD(K,ln_P);
%%
[zt,zt_i,zo,zo_i]=grid.optimise_li(K,ln_P,0.05,0.1,0.001,0.03);
grid.plot_li_fit(K,ln_P,zt,zt_i,zo,zo_i);

%% plot and find suitable freq range


%% optimise


%% plot pcolor

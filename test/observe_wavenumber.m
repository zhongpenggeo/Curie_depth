% �۲������������ϵĲ�����Χ��

clc;clear
filename='RTP15km_surf6.grd';%�ļ���
%�򿪲���ȡGRD�ļ�

window=200e3;
spacing=50e3;

%%
grid=CURIE_DEPTH(filename);
xc=(grid.X_MAX+grid.X_MIN)/2;
yc=(grid.Y_MAX+grid.Y_MIN)/2;
sub=grid.subgrid(window, xc, yc);
[K,ln_P]=grid.radial_log_PSD(sub);
grid.plot_PSD(K,ln_P);
%%
zt_k0=0.05;
zt_k1=0.1;
zo_k0=0.001;
zo_k1=0.03;
[zt,zt_i,zo,zo_i]=grid.optimise_li(K,ln_P,zt_k0, zt_k1,zo_k0,zo_k1);
grid.plot_li_fit(K,ln_P,zt,zt_i,zo,zo_i);


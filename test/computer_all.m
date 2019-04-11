% 计算所有的居里面深度

%读取网格数据
clc;clear
%% all parameters
filename='RTP15km_surf6.grd';%文件名
%打开并读取GRD文件
window_size=200e3;
spacing=50e3;
zt_k0=0.05;
zt_k1=0.1;
zo_k0=0.01;
zo_k1=0.035;
out_filename='200km.txt';
%%
grid=CURIE_DEPTH(filename);
[xc_list,yc_list]=grid.create_centroid_list(window_size,spacing);
xc_len=length(xc_list);
Z=zeros(xc_len,5);
for id=1:xc_len
    xc=xc_list(id);
    yc=yc_list(id); 
    subdata=grid.subgrid(window_size, xc, yc);
    [K,ln_P]=grid.radial_log_PSD(subdata);
    [zt,zt_i,zo,zo_i]=grid.optimise_li(K,ln_P,zt_k0, zt_k1,zo_k0,zo_k1);
    zb=2*zo-zt;
    Z(id,:)=[xc,yc,zt,zo,zb];
end

%% plot
x_len=length(unique(xc_list));
y_len=length(unique(yc_list));
pcolor(reshape(Z(:,1),y_len,x_len),reshape(Z(:,2),y_len,x_len),reshape(Z(:,5),y_len,x_len));
colorbar

%% save result
%save(out_filename,'Z','-ascii');


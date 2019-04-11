function [K,ln_P]=radial_log_PSD(obj ,data)
% compute radial averaged log of power spectrum density
% rewrite from Dr.Liang, CUG.
%
% -------------input----------------
% data: 2D array
%-------------output----------------
% K : wave number km^-1;
% ln_P : radial averaged power spectrum density
    
    % if space unit is not meter, need a scale factor.
    scale=1000;
    n_w =80; %径向频率个数  可尝试着选择最佳数值，不是越大越好，也不是越小越好

    [line,list]=size(data);
    xx=obj.dx;
    yy=obj.dy;
    uu= 1 / (xx*(list-1)); %x方向频率分辨率
    vv= 1 / (yy*(line-1)); %x方向频率分辨率

    %x方向与y方向频率分布
    %x方向
    if mod(list,2) == 0  %点数为偶数情况
        for k=1:1:list/2+1
            u(k) = (k-1)*uu;
            if k~=1 && k~=list/2+1
                u(list-k+2) = -(k-1)*uu;
            end
        end
    else                %点数为奇数情况
        for k=1:1:(list+1)/2
            u(k) = (k-1)*uu;
            if k~=1 
                u(list-k+2) = -(k-1)*uu;
            end
        end
    end

    %y方向
    if mod(line,2) == 0  %点数为偶数情况
        for k=1:1:line/2+1
            v(k) = (k-1)*vv;
            if k~=1 && k~=line/2+1
                v(line-k+2) = -(k-1)*vv;
            end
        end
    else                %点数为奇数情况
        for k=1:1:(line+1)/2
            v(k) = (k-1)*vv;
            if k~=1 
                v(line-k+2) = -(k-1)*vv;
                %dd(k)=line-k+2;
            end
        end
    end

    %二维傅里叶变换
    %F2D_data = FFT2D(data,line,list);
    F2D_data = fft2(data,line,list);
    w = ((max(u))^2+(max(v))^2)^0.5 / n_w;  %径向频率间隔
    data_new(line*list,2) = 0;
    %or data_new = zeros(line*list,2);
    t=1;
    for k=1:line
        for j=1:list
            data_new(t,1) = (u(1,j)^2 + v(1,k)^2)^0.5; %径向频率
            %data_new(t,2) = (Re(data(k,j))^2+Im(data(k,j))^2)^0.5; %功率谱 
            data_new(t,2) = real(F2D_data(k,j))^2+imag(F2D_data(k,j))^2; %功率谱 
            %data_new(t,2) = log((real(data(k,j))^2+imag(data(k,j))^2)^0.5); %对数功率谱 
            t=t+1;
        end
    end

    %K = zeros(1,n_w); %径向谱横坐标
    %ln_P = zeros(1,n_w); %径向功率谱
    K = zeros(n_w,1); %径向谱横坐标
    ln_P = zeros(n_w,1); %径向功率谱

    %平均径向谱法
    for k = 1:n_w
        t=0;
        z=0;
        for j=1:line*list
            %if data_new(j,1) < (k+1)*w && data_new(j,1) >= k*w
             if data_new(j,1) <k*w && data_new(j,1) >= (k-1)*w
                 z = z+log(data_new(j,2));
                 t = t+1;
            end
        end
        ln_P(k) = z/t;
        K(k) = (k-1)*w;
    end
    index=find(K>(max(K)/sqrt(2)),1);
    K=K(2:index-1)*scale;
    ln_P=ln_P(2:index-1);
end
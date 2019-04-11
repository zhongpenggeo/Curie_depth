function [xc_list,yc_list]=create_centroid_list(obj,window_size, spacing)
% calculate middle point of each windows and split area into different 
% sub areas.
%
%----------------input------------------
% window_size: size of each window
% spacing: the interval of near windows
%----------------output-----------------
% xc_list, yc_list:center point of x and y. they are paired

    if obj.dx~=obj.dy
        warning('dx is not equal with dy')
    end

    nw=int32(round(window_size/obj.dx));
    n2w=int32(round(nw/2));
    xc=obj.X(n2w:end-n2w);
    yc=obj.Y(n2w:end-n2w);
    xc2=min(xc):spacing:max(xc);
    yc2=min(yc):spacing:max(yc);
    [xq,yq]=meshgrid(xc2,yc2);
    xc_list=xq(:);
    yc_list=yq(:);
end
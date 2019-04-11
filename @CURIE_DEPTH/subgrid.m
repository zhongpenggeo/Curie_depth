function subdata=subgrid(obj, window_size, xc, yc)
% extract sub grid from raw grd according windows size and center of x,y.
%
%------------------input----------------
% window_size: size of windows
% xc,yc: center of x and y
%------------------output-----------------
% subdata: sub grid

    [~,ix]=min(abs(obj.X-xc));
    [~,iy]=min(abs(obj.Y-yc));
    nw=int32(round(window_size/obj.dx));
    n2w=int32(round(nw/2));
    imin = ix - n2w;
    imax = ix + n2w + 1;
    jmin = iy - n2w;
    jmax = iy + n2w + 1;

    % safeguard
    imin = int32(max(imin, 1));
    imax = int32(min(imax, obj.XN));
    jmin = int32(max(jmin, 1));
    jmax = int32(min(jmax,obj.YN));

    subdata=obj.grddata(jmin:jmax,imin:imax);

end
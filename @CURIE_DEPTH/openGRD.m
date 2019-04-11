function obj = openGRD(str)
% open grdfile,must be gofmatted as golden soft ascii format(surfer 6 txt);
% in gdal, the code is GSAG
% it call function *open_grd*, therfore it should be in matlab path.
    if nargin < 1
        return
    end % if.
    if exist(str,'file')
        obj.filename = str;
        [obj.XN,obj.YN,X_MIN,X_MAX,Y_MIN,Y_MAX,~,~,obj.data]...
            =open_grd(obj.filename);
        obj.X=linspace(X_MIN,X_MAX,XN);
        obj.Y=linsapce(Y_MIN,Y_MAX,YN);
        obj.dx=(X_MAX-X_MIN)/(XN-1);
        obj.dy=(Y_MAX-Y_MIN)/(YN-1);

    else
        error(['File: ', str ,'does not existed!']);
    end % if.
end % clsEDI.
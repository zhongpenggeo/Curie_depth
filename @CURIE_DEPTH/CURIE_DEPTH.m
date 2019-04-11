classdef CURIE_DEPTH
% a class to computer curie depth
% rewrite based on pycurious: https://github.com/brmather/pycurious
% writen by PengZhong, ZJU, 2019/4/10
% ref:
% [1]Li,Lin and Wang(2013),Thermal evolution of the North Atlantic lithosphere
% [2]Tanaka,Okubo and Matsubayashi(1999),Curie point depth based on spectrum analysis
% of the magnetic anomaly data in East and Southeast Asia

	properties
        filename='';
        X=[];
        Y=[];
        XN=0;
        YN=0;
        X_MIN=0;
        X_MAX=0;
        Y_MIN=0;
        Y_MAX=0;
        dx=0;
        dy=0;
        grddata=[];      
	end % properties
	
%----------------------------------------------------------------------%
	methods
%----------------------------------------------------------------------%

        function obj = CURIE_DEPTH(str)
            if nargin < 1
                return
            end % if.
            if exist(str,'file')
                obj.filename = str;
                [obj.XN,obj.YN,obj.X_MIN,obj.X_MAX,obj.Y_MIN,obj.Y_MAX,~,~,obj.grddata]...
                    =open_grd(obj.filename);
                obj.X=linspace(obj.X_MIN,obj.X_MAX,obj.XN);
                obj.Y=linspace(obj.Y_MIN,obj.Y_MAX,obj.YN);
                obj.dx=(obj.X_MAX-obj.X_MIN)/(obj.XN-1);
                obj.dy=(obj.Y_MAX-obj.Y_MIN)/(obj.YN-1);

            else
                error(['File: ', str ,'does not existed!']);
            end % if.
        end % clsEDI.
%----------------------------------------------------------------------%  
% calculation
        [xc_list,yc_list]=create_centroid_list(obj,window, spacing);
        sub=subgrid(obj, window, xc, yc);
        [K,ln_P]=radial_log_PSD(obj,sub);
        [zt,zt_i,zo,zo_i]=optimise_li(obj,K,ln_P,zt_k0, zt_k1,zo_k0,zo_k1);
        [zt,zt_i,zo,zo_i]=optimise_tanaka(obj,K,ln_P,zt_k0, zt_k1,zo_k0,zo_k1);

%----------------------------------------------------------------------%
% plot
        plot_PSD(obj,K,ln_P);
        plot_li_fit(obj,K,ln_P,zt,zt_i,zo,zo_i);
        plot_tanaka_fit(obj,K,ln_P,zt,zt_i,zo,zo_i);
		
%----------------------------------------------------------------------%
	end % methos.
%----------------------------------------------------------------------%
end % classdef.
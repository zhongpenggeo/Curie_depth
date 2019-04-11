function [zt,zt_i,zo,zo_i]=optimise_li(obj,K,ln_P,zt_k0, zt_k1,zo_k0,zo_k1)
% computer curie depth according to Li et,al(2013);
%
% -----------------input--------------------
% K : wave number km^-1;
% ln_P : radial averaged power spectrum density
% zt_k0, zt_k1 : freq range used to fit the slope, which is Zt;
% zo_k0, zo_k1 : freq range used to fit the slope, which is Zo;
%-------------------output--------------------
% zt: top of magnetic layer, or slope of PSD
% zt_i: intercept of zt
% zo: bottom depth of magnetic layer,
% zo_i: intercept of zo

    % sqrt root of power ;
    ln_P=ln_P/2;
    
    zt_min=find(K>zt_k0,1);
    zt_max=find(K>zt_k1,1);
    zo_min=find(K>zo_k0,1);
    zo_max=find(K>zo_k1,1);
    
    
    K_zt=K(zt_min:zt_max-1);
    lnP_zt=ln_P(zt_min:zt_max-1);
    fit_lnP_zt=(lnP_zt+log(2*pi*K_zt))/2/pi;
    p_zt=polyfit(K_zt,fit_lnP_zt,1);
    zt=-p_zt(1);
    zt_i=p_zt(2);

    K_zo=K(zo_min:zo_max);
    lnP_zo=ln_P(zo_min:zo_max);
    fit_lnP_zo=(log(exp(lnP_zo)./(2*pi*K_zo))+log(2*pi*K_zo))/2/pi;
    p_zo=polyfit(K_zo,fit_lnP_zo,1);
    zo=-p_zo(1);
    zo_i=p_zo(2);
end
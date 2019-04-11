function plot_li_fit(obj,K,ln_P,zt,zt_i,zo,zo_i)
% plot fit
    ln_P=ln_P/2;
    figure;
    subplot(211)
    ln_P_zt=(ln_P)/2/pi;
    plot(K,ln_P_zt,'bs');
    hold on
    plot(K,-zt*K+zt_i-log(2*pi*K)/2/pi,'r','LineWidth',2)
    hold off
    set(gca,'ylim',[min(ln_P_zt) max(ln_P_zt)]);
    xlabel('k/km^{-1}');
    ylabel('log(P^{1/2})/2\pi');
%    legend(hr,'XY','YX')
    
    subplot(212)
    ln_P_zo=(log(exp(ln_P)./(2*pi*K)))/2/pi;
    plot(K,ln_P_zo,'bs');
    hold on
    plot(K,-zo*K+zo_i-log(2*pi*K)/2/pi,'r','LineWidth',2)
    hold off
    set(gca,'ylim',[min(ln_P_zo) max(ln_P_zo)]);
    xlabel('k/km^{-1}');
    ylabel('log(P^{1/2}/(2\pik))/2\pi');
end % plot.
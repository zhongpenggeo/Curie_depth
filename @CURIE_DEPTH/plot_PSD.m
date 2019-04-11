function plot_PSD(obj,K,ln_P)
% plot PSD
    
%     K=obj.K;
%     ln_P=obj.ln_P;
    figure(1)
    subplot(211)
    ln_P_zt=(ln_P)/2/pi;
    plot(K,ln_P_zt,'b','LineWidth',2);
    xlabel('k(km^{-1})');
    ylabel('log(P)/2\pi');
%    legend(hr,'XY','YX')
    
    subplot(212)
    ln_P_zo=(log(exp(ln_P)./(2*pi*K)))/2/pi;
    plot(K,ln_P_zo,'b','LineWidth',2);
    xlabel('k(km^{-1})');
    ylabel('log(P/(2\pik))/2\pi');
end % plot.
function [alert, alert_idx, border] = checkSingularity(q, t)
    alert = 0;
    alert_idx = []; border = []; prev = 0;
    e = 0.001;
    
    [R,P,R_e,p_e] = forwardKine(q);
    
%     size(R)
%     size(P)
%     size(R_e)
%     size(p_e)
    
    sizeR = size(R);
    for i = 1:sizeR(4)
        J_e = [
            %J_w
            R(:,:,1,i)*[0;0;1]                              R(:,:,2,i)*[0;0;1]                              R(:,:,3,i)*[0;0;1]
            %J_v
            cross(R(:,:,1,i)*[0;0;1],(P(:,4,i)-P(:,1,i)))   cross(R(:,:,2,i)*[0;0;1],(P(:,4,i)-P(:,2,i)))   cross(R(:,:,3,i)*[0;0;1],(P(:,4,i)-P(:,3,i)));
        ];

        J_v = J_e(4:6,:);

        if det(J_v) < e
            alert = 1;
            if (prev==0) 
                border = [border t(i)];
            end
            alert_idx = [alert_idx 1];
        else
            if (prev==1) 
                border = [border t(i-1)];
            end
            alert_idx = [alert_idx 0];
        end
        prev = alert;
    end
    if (mod(length(border),2)~=2)
        border = [border t(sizeR(4))];
    end
    
    if (alert)
        figure()
        fill([border(1) border(1) border(2) border(2)],[-pi pi pi -pi],...
            'r','LineStyle','none')
        alpha(0.1)
        hold on
        plot(t, q)
        title('position-time (config. space)')
        legend({'Singularity Alert'})
        ylabel('rad')
        ylim([-pi pi])
        xlim([0 t(sizeR(4))])
    end
end
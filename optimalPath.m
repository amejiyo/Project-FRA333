function [selected_via_point_joint, all_via_point_joint, cost] = optimalPath(via_point_joint_all, mode)

%INPUT : [via_point_joint_all] dimension        = 3 * 4 * N
%OUTPUT: [selected_via_point_joint] dimension   = 3 * N

[row,col,dep] = size(via_point_joint_all);
via_point_joint_all(:,:,1) = zeros(3,4);
switch mode
    case "shortest_path"
        all_via_point_joint = permute(via_point_joint_all(:,:,1), [1 3 2]);
        %dimension = 3 * N * K
        cost = zeros(col, 1);
        %dimension = K * 1      which K is all possibility
              

        for depth = 1:dep-1
%         for depth = 1:2
            [r,c,d] = size(all_via_point_joint);
            
            via_point_joint_temp = [];
            cost_temp = [];
            
            %For each next via-point's pose
            for next = 1:col
                %For each current record
                for current = 1:d
                    %Append next via-point
                    via_point_joint_temp = cat(3, via_point_joint_temp,...
                    cat(2, all_via_point_joint(:,:,current), via_point_joint_all(:,next,depth+1))...
                    );
                    %Append current to next via-point path cost
                    cost_temp = cat(1, cost_temp,...
                    cost(current,:) + max(abs(via_point_joint_all(:,next,depth+1) - all_via_point_joint(:,depth,current)))...
                    );
                end
            end
            all_via_point_joint = via_point_joint_temp;
            cost = cost_temp;
        end
end
%Find minimum path cost
[min_cost, min_idx] = min(cost)

selected_via_point_joint = all_via_point_joint(:,:,min_idx);


end


function [p,v,a] = polyTrajEval(t,C,t_i)

p = zeros(3,1);
v = zeros(3,1);
a = zeros(3,1);

for c = 0:length(C)-1
    p = p + C(:,c+1)*(t-t_i).^c;
    if (c>0); v = v + c*C(:,c+1)*(t-t_i).^(c-1); end
    if (c>1); a = a + (c*(c-1))*C(:,c+1)*(t-t_i).^(c-2); end
end

end
function [R,P,R_e,p_e] = forwardKine(q)
% forward kinematic
q = q*(180/pi);      %Range of q = [-pi,pi]
L1 = 0.05;           %parameter Length 1
L2 = 0.25;           %parameter Length 2
L3 = 0.30;           %parameter Length 3
h1 = 0.10;           %parameter Height 1
DH = [0 0 h1 0; L1 90 0 90; L2 0 0 -90];   %calculated DH parameters
He = [1,0,0,L3; 0,0,1,0; 0,-1,0,0; 0,0,0,1];   %calculated transformation matrix of end (n) respect to end-effector (e)
n = 3;              % 3 DOF
size_q = size(q);
R = []; P = [];
for j = 1:size_q(2)
    H = eye(4);         %Identity matrix 4x4
    Hj = zeros(4);      %Zero matrix 4x4
    Tx = zeros(4);      %Zero matrix 4x4
    Rx = zeros(4);      %Zero matrix 4x4
    Tz = zeros(4);      %Zero matrix 4x4
    Rz = zeros(4);      %Zero matrix 4x4
    for i = 1:n
        Tx = [eye(3),[DH(i,1);0;0];0,0,0,1];          %Translation about X axis
        Rx = [rotx(DH(i,2)),[0;0;0];0,0,0,1];         %Rotation about X axis
        Tz = [eye(3),[0;0;DH(i,3)];0,0,0,1];          %Translation about Z axis
        Rz = [rotz(DH(i,4)),[0;0;0];0,0,0,1];         %Rotation about Z axis
        Hj = [rotz(q(i,j)),[0;0;0];0,0,0,1];          %All revolute joint so use rotation
        H = H*Tx*Rx*Tz*Rz*Hj;                         %Homegeneous multiplication Hi -> Hj
        
        R(:,:,i,j) = H(1:3,1:3);
        P(:,i,j) = H(1:3,4);
    end
    Ha = H*He;                  %Orientation of pose     Output = H * Config.
    R(:,:,n+1,j) = Ha(1:3,1:3);
    P(:,n+1,j) = Ha(1:3,4);
    R_e(:,:,j) = Ha(1:3,1:3);   %Rotation of pose
    p_e(:,j) = Ha(1:3,4);       %Position of pose
end
end

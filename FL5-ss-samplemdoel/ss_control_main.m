% State-space equation forming
% editor: zijun
% date: 24th jan

%------------------------------------------------------------------------%
%
%                        Kx_dot = Ax + Bu + Bwg
%                        x_dot = K^-1(Ax + Bu + Bwg)
%
%
%
%------------------------------------------------------------------------%

clc
clear



%% Loading matrices
load('./A.mat', 'A');
load('./B.mat', 'B');
load('./C.mat', 'C');
load('./D.mat', 'D');
load('./Bw.mat', 'Bw');
load('M.mat','M');

%% State-space system forming
Af = M^-1 * A;
Bf = M^-1 * B;
Bwf = M^-1 * Bw;




%% Observable and Controllable state-space
% Free system
t = 0:0.01:100;
u = zeros(size(t));
x0 = [1 0 0 0];

sys = ss(Af, Bf, C, D);

figure(1)
[y,t,x] = lsim(sys,u,t,x0);
plot(t,y)
title('Open-Loop Response to Flight Conditions');
xlabel('Time (sec)');
ylabel('Outputs');


% Controllable Closed Loop
p1 = 0;
p2 = -0.46;
p3 = 0.66;
p4 = 1.00;


K = place(Af, Bf, [p1 p2 p3 p4]);
sys_cl = ss(Af-Bf*K, Bf, C,0);

figure(2)
lsim(sys_cl,u,t,x0);
xlabel('Time (sec)')
ylabel('Ball Position (m)')

% Observable Closed Loop













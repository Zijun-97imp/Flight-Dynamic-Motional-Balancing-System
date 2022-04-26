% Loading Data of Aerodynamic Coefficient
% editor: zijun
% date: 24th jan

clc
clear

fprintf('Standard Units: kg, m, s.\n');

%% Model Variables
m = 8.72;                            % Model Mass (kg)
q = 980.00;                          % Dynamic Pressure (Pa)
s = 0.2940;                          % Wing Area (m^2)
c = 0.2450;                          % Average Chord Length (m)
Io = 0.5935;                         % Central Inertia (kgm^2)
U = 40.00;                           % Income Flow Velocity (m/s)
g = 9.81;                            % Local Gravity (m/s^2)


%% Model Aerodynamic Coefficient
% all coefficient with dimension
kw = c / (2*U);
clad = 0.008081279;             % dimensional transfer
cla = 5.5497917;
clq = 0.030235803;
clt = 0.368821148;
cl0 = 0.26318895;

cmad = -0.018147167;
cma = -0.26464918;
cmq = -0.049574962;
cmt = -0.916993167;
cm0 = 0.08960583;


%% State-Space Matrices Forming
A = zeros(4,4);
B = zeros(4,1);
Bw = zeros(4,1);
M = zeros(4,4);
C = zeros(2,4);
D = zeros(2,1);


% For A
A(1,1) = -(cla)/U;
A(1,3) = (clad + clq);
A(1,4) = (cla);
A(3,1) = (cma)/U;
A(3,3) = (cmad + cmq);
A(3,4) = (cma);
A(2,1) = 1;
A(4,3) = 1;

% For B
B(1,1) = clt;
B(3,1) = -cmt;

% For C
C(1,2) = 1;
C(2,3) = 1;

% For Bw
Bw(1,1) = (cl0)-((m*g)/(q*s));
Bw(3,1) = -(cm0);

% For M
M(1,1) = (m/(q*s))+(clad/U);
M(3,1) = (cmad/U);
M(3,3) = -(Io/(q*s*c));
M(2,2) = 1; 
M(4,4) = M(2,2);




%% Saving Matrices
save('A.mat','A');
save('B.mat','B');
save('Bw.mat','Bw');
save('C.mat','C');
save('D.mat','D');
save('M.mat','M');



clc; clear;

%% ========== Constants ===========

FB = 6;
S_BASE = 100;
V_BASE = 13.8;
I_BASE = S_BASE / V_BASE;

%% ========== Base Ybus ===========

base_line_data = [
%  Fr   To          r          x         b/2   a
    2   5   0.0541025  0.1651860   0.03230/2   1;
    6   12  0.1401174  0.2916234   0.00000/2   1;
    12  13  0.2518488  0.2278632   0.00000/2   1;
    6   13  0.0754110  0.1485078   0.00000/2   1;
    6   11  0.0721848  0.1511640   0.00000/2   1;
    11  6   0.0623580  0.1459732   0.00000/2   1;
    11  10  0.0241756  0.0642200   0.00000/2   1;
    9   10  0.0966036  0.2054888   0.00000/2   1;
    9   14  0.0966036  0.2054888   0.00000/2   1;
    14  13  0.1299068  0.2644952   0.00000/2   1;
    1   2   0.0636595  0.1624785   0.03287/2   1;
    3   2   0.0446405  0.1880715   0.04161/2   1;
    3   4   0.0636595  0.1624785   0.03287/2   1;
    1   5   0.0513285  0.2118880   0.04674/2   1;
    5   4   0.0126825  0.0400045   0.01216/2   1;
    2   4   0.0552045  0.1675040   0.03553/2   1;
    5   6   0.0000000  0.2394190   0.00000/2   0.932;
    4   9   0.0000000  0.5283710   0.00000/2   0.969;
    4   7   0.0000000  0.2091200   0.00000/2   0.978;
    8   7   0.0000000  0.1761500   0.00000/2   1;
    7   9   0.0000000  0.1100100   0.00000/2   1;    
];

base_y_bus = ybus(base_line_data);

%% ============ Zero Seq. Ybus ================

zero_seq_line_data = [
    2   5   0.1623075   0.495558    0.09690/2  1;
    6   12  0.4203522   0.8748702   0.00000/2  1;
    12  13  0.7555464   0.6835896   0.00000/2  1;
    6   13  0.226233    0.4455234   0.00000/2  1;
    6   11  0.2165544   0.453492    0.00000/2  1;
    11  6   0.187074    0.4379196   0.00000/2  1;
    11  10  0.0725268   0.19266     0.00000/2  1;
    9   10  0.2898108   0.6164664   0.00000/2  1;
    9   14  0.2898108   0.6164664   0.00000/2  1;
    14  13  0.3897204   0.7934856   0.00000/2  1;
    1   2   0.1909785   0.4874355   0.09861/2  1;
    3   2   0.1339215   0.5642145   0.12483/2  1;
    3   4   0.1909785   0.4874355   0.09861/2  1;
    1   5   0.1539855   0.635664    0.14022/2  1;
    5   4   0.0380475   0.1200135   0.03648/2  1;
    2   4   0.1656135   0.502512    0.10659/2  1; 
    5   6   999999999   0.0000000   0.00000/2  1;
    4   9   999999999   0.0000000   0.00000/2  1;
    4   7   0.0000000   0.2091200   0.00000/2  1;
    8   7   0.0000000   0.1761500   0.00000/2  1;
    7   9   999999999   0.0000000   0.00000/2  1;   
];

base_y_bus_zero_seq = ybus(zero_seq_line_data);

%% ============ Load Impedance Calculation ===============

Vpf = [
    1.06   * cos( 0      ) + 1j * 1.06   * sin( 0      );    
    1.0324 * cos(-0.18264) + 1j * 1.0324 * sin(-0.18264);    
    1.01   * cos(-0.29708) + 1j * 1.01   * sin(-0.29708);    
    1.0092 * cos(-0.24536) + 1j * 1.0092 * sin(-0.24536);    
    1.0114 * cos(-0.2147 ) + 1j * 1.0114 * sin(-0.2147 );    
    1.0658 * cos(-0.31052) + 1j * 1.0658 * sin(-0.31052);  
    1.0509 * cos(-0.29077) + 1j * 1.0509 * sin(-0.29077);    
    1.0897 * cos(-0.29077) + 1j * 1.0897 * sin(-0.29077);    
    1.0375 * cos(-0.31453) + 1j * 1.0375 * sin(-0.31453);    
    1.0458 * cos(-0.31799) + 1j * 1.0458 * sin(-0.31799);    
    1.0538 * cos(-0.31505) + 1j * 1.0538 * sin(-0.31505);    
    1.0484 * cos(-0.32596) + 1j * 1.0484 * sin(-0.32596);    
    1.0423 * cos(-0.32615) + 1j * 1.0423 * sin(-0.32615);    
    1.0265 * cos(-0.33245) + 1j * 1.0265 * sin(-0.33245);    
];

S = [
    0.00000 + 0.00000j;
    0.20615 + 0.12065j;
    0.89490 + 0.18050j;
    0.45410 + 0.03800j;
    0.07220 + 0.01520j;
    0.10640 + 0.07125j;
    0.00000 + 0.00000j;
    0.00000 + 0.00000j;
    0.28025 + 0.15770j;
    0.08550 + 0.05510j;
    0.03325 + 0.01710j;
    0.05795 + 0.01520j;
    0.12825 + 0.05510j;
    0.14155 + 0.04750j;    
];

load_admittance = conj(S) ./ (abs(Vpf).^2);
load_contribution = repmat(load_admittance', 14, 1) .* eye(14);

disp(load_contribution(5, 5));

%% =========== Generator Contribution ===============
gen_line_data_pos_seq = [
%  Fr   To   r     x   b/2   a
    1   15   0  0.33   0.0   1;
    2   15   0  0.23   0.0   1;
    3   15   0  0.23   0.0   1;
    6   15   0  0.22   0.0   1;
    8   15   0  0.12   0.0   1;    
];

gen_contribution_pos_seq = ybus(gen_line_data_pos_seq);
gen_contribution_pos_seq = gen_contribution_pos_seq(1:end-1, 1:end-1);

disp(gen_contribution_pos_seq(8, 8));

%% =========== Grounding Reactance Contribution Zero Seq. ================

ground_con_line_data = [
    5   15  0.0 0.239419+0.1    0.0/2   1;
    8   15  0.0 0.0001          0.0/2   1;
];

gnd_contribution_zero_seq = ybus(ground_con_line_data);
gnd_contribution_zero_seq = gnd_contribution_zero_seq(1:end-1, 1:end-1);

disp(gnd_contribution_zero_seq(8, 8));

%% =========== Positive Seq. Network ===============
y_bus_pos = base_y_bus + load_contribution + gen_contribution_pos_seq;
disp("Positive Sequence Netwrok");
disp(y_bus_pos);

%% ============ Zero Seq. Network ===============
y_bus_zero = base_y_bus_zero_seq + load_contribution + ...
    gnd_contribution_zero_seq;
disp("Zero Seq Network");
disp(y_bus_zero(1, 5));

%% ============== Z-bus Calculation ==============
[L1, U1] = lu(y_bus_pos);
[L0, U0] = lu(y_bus_zero);

I14 = eye(14);
X1 = L1\I14(:, FB);
X0 = L0\I14(:, FB);

Z1 = U1\X1; % POS
Z0 = U0\X0; % ZER
Z2 = Z1;    % NEG

Z012 = [
   Z0(FB)        0        0;
        0   Z1(FB)        0;
        0        0   Z2(FB);
];

%% ============ 3Phase Fault Current Calculation ============

a = 1*exp(1j*120/180*pi);
A = [
   1      1     1;
   1    a*a     a;
   1      a   a*a;
];

Yfabc = [
    999999999           0           0;
    0           999999999           0;
    0                   0   999999999;
];

Yf012 = (A^-1) * Yfabc * A;

If012 = ((Yf012 * Z012 + eye(3))^-1) * Yf012 * [0; Vpf(FB); 0];
Ifabc = A * If012; 

three_phase_fault_current = [ abs(Ifabc) * I_BASE, angle(Ifabc) * 180/pi ];

disp("3P Fault Current (kA)")
disp(three_phase_fault_current);

%% ========== Fault Voltage ===============

Vf0 = zeros(14, 1) - If012(1) * Z0;
Vf1 = Vpf - If012(2) * Z1;
Vf2 = zeros(14, 1) - If012(3) * Z2;

Vabc = A * ([ Vf0'; Vf1'; Vf2' ]);

fault_voltages = [ abs(Vabc(1, :)') * V_BASE, angle(Vabc(1, :)'), ...
    abs(Vabc(2, :)') * V_BASE, angle(Vabc(2, :)'), ...
    abs(Vabc(3, :)') * V_BASE, angle(Vabc(3, :)')
];

disp("3P Fault Bus Voltages");
disp(fault_voltages);

%% ============ 1Phase Fault Current Calculation ============

Yfabc = [
    999999999           0           0;
    0                   0           0;
    0                   0           0;
];

Yf012 = (A^-1) * Yfabc * A;

If012 = ((Yf012 * Z012 + eye(3))^-1) * Yf012 * [0; Vpf(FB); 0];
Ifabc = A * If012; 

single_phase_fault_current = [ abs(Ifabc) * I_BASE, angle(Ifabc) * 180/pi ];

disp("1P Fault Current (kA)")
disp(single_phase_fault_current);

%% ========== Fault Voltage ===============

Vf0 = zeros(14, 1) - If012(1) * Z0;
Vf1 = Vpf - If012(2) * Z1;
Vf2 = zeros(14, 1) - If012(3) * Z2;

Vabc = A * ([ Vf0'; Vf1'; Vf2' ]);

fault_voltages = [ abs(Vabc(1, :)') * V_BASE, angle(Vabc(1, :)'), ...
    abs(Vabc(2, :)') * V_BASE, angle(Vabc(2, :)'), ...
    abs(Vabc(3, :)') * V_BASE, angle(Vabc(3, :)')
];

disp("1P Fault Bus Voltages");
disp(fault_voltages);











clear all 
close all
clc
s = tf('s')
Ts = 0.016
G = 10 / (s * (1 + s/ 0.8) * (1 + s / 15))
G_ZOH = 1 / (1 + s*Ts/2)

Kc = 1
C_SS = Kc
L = C_SS * G
L11 = L * G_ZOH
%zeta = 0.49
Tp =mag2db(1.17)
Sp = mag2db(1.49)
M_T_LF = mag2db(0.8 *10^-2)
figure
nichols(L11 , 'b')
hold on 
T_grid(M_T_LF)
S_grid(Sp)
T_grid(Tp)

w_norm = 6
wc_des = 1.90/0.25
wz = wc_des/ w_norm 
C_Z = 1 + s/wz
L2 = L11 * C_Z
nichols(L2 , 'r')
wp = 60
C_P = 1 /(1 + s/wp)
L3 = L2 *C_P
nichols(L3 , 'g')

 K = 10 ^ (1.7/ 20)
L4 = L3 * K

nichols(L3 , 'k')

C0 = C_SS * C_P* C_Z *K
Cd = c2d(C0, Ts, 'Tustin')
%%

rho = 1
wt = 0
delta_a = 0
delta_t = 0
delta_y = 0 
out  = sim("my3sim.slx")

stepinfo(out.y.data, out.y.time, 1, 0, 'RiseTiemLimits', [0 1], 'SettlingTimeTreshold', 0.05)
figure
plot(out.e.time, out.e.data, LineWidth=0.5)

%%

rho = 0
wt = 0
delta_a = 0.4
delta_t = 0
delta_y = 0 
out  = sim("my3sim.slx")

figure
plot(out.y.time, out.y.data, LineWidth=0.5)

%%

rho = 0
wt = 100
delta_a = 0
delta_t = 1
delta_y = 0 
out  = sim("my3sim.slx")

figure
plot(out.y.time, out.y.data, LineWidth=0.5)

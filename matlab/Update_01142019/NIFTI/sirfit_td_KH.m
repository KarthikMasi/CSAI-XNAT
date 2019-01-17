function Er = sirfit_td(X,t,Mza,Td,R1b)
% function Er = sirfit(X,t,Mza,Td,R1b);
% by Mark D Does

Moa = X(1); % guess for free water pool
Mob = X(2); % guess for macro pool 
kba = X(3); % exchange macro to water
R1a = X(4); % R1 of free water (measured R1)
alpha_a = X(5); % inv efficiency 
alpha_b = 0.83;

TD = Td;
Mo = [Moa;Mob];
kab = kba*Mob/Moa;
L1 = [-(R1a+kab) kba; kab -(R1b+kba)];

N = length(t);
Mzap = zeros(N,1);
R = [alpha_a 0; 0 alpha_b];

% pre-compute
% in our application, expmdemo3 is (much) faster than expm
M1 = Mo-R*(Mo-expmdemo3(L1*TD)*Mo);

for kt = 1:N
   Z = Mo-expmdemo3(L1*t(kt))*M1;
   Mzap(kt) = abs(Z(1));
end

Er = (Mza-Mzap);
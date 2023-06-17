N = 2.24e3;
[x,k] = mk1Dgrids(N,'DBC');
ftfun = @sinft;
iftfun = @sinft;

a = 0.01; x = a*x;
k = k/a; 
kinE = k.^2/2;
%% choose parameters!
w = 0.2;        %Define frequency, m=hbar=1
dw = 0.0002;    %Define the step frequency changes at each discrete time
tau = 0.01;     %time step
nt = 1e3;       %number of time steps

s = 100;        %Scaling factor for plotting the wave function
                %on the same canvas of the potential
%% prepare canvas
f2 = figure(2);  %Prepare canvas for phase plot
shg; clf
close(f2);
figure(1);  %Prepare canvas for |psi|^2 plot
shg; clf
%% plot the potential and fix axis
V = @(x) 0.5*w^2*(x).^2;  %Harmonic oscillator potential
hV = plot(x,V(x),'linewidth',2,'color','cyan');
hold on
xlim([x(1) x(end)]);
ylim([0,5]);
axis(axis)

%% setup initial wavefunction
psi = exp(-w*x.^2*0.5);  %GS of Harm oscillator, hbar = 1
psi = psi/norm(psi);  
% phase difference w/ GS
phi = zeros(1,nt);
special_t = [];     % Save phase difference at times when |psi|^2-|psi_gs|^2
special_phi = [];   % is small into 'special arrays'
% phase difference as a function of x for a specific time tau*phi_x_j
%phi_x_j = round(nt/2);
%phi_x = zeros(1,length(psi));
%% plot instantaneous GS
psi_gs = exp(-w*x.^2*0.5);  %GS of Harm oscillator, hbar = 1
hpsi_gs = plot(x,s*abs(psi_gs).^2,'linewidth',2,'color','green'); % Plot GS
%% plot instantaneous system state
if exist('hf','var') && isgraphics(hf)
    hf.YData = s*abs(psi).^2; 
else
    hf = plot(x,s*abs(psi).^2,'linewidth',2);
end
ht = title(sprintf('t = %-5.2f',0));
ylabel("|\Psi|^2 (scaled)")
xlabel("position (x)")
%% evolve
shg
%disp('press any key to start evolution'); pause

alpha = dw/tau;             %Speed with which the frequency changes in time
for j=1:nt
    psi = exp(-1i*V(x)*tau/2).*psi;
    psi = iftfun(exp(-1i*kinE*tau).*ftfun(psi));
    psi = exp(-1i*V(x)*tau/2).*psi;
    if mod(j,10) == 0
        %Plot current system state
        hf.YData = s*abs(psi).^2;
        ht.String = sprintf('t = %-5.2f\n Istantaneous freq w = %-5.2f',j*tau,w);
        drawnow;
    end
    w = w + dw;                 %Update frequency
    V = @(x) 0.5*w^2*(x).^2;    %Update potential shape (with the new frequeny)
    
    %Plot new potential and GS
    delete(hV);
    delete(hpsi_gs);
    hV = plot(x,V(x),'linewidth',2,'color','cyan');
    psi_gs = exp(-w*x.^2*0.5);  %New GS wave function (w is changed!)
    psi_gs = psi_gs/norm(psi_gs);
    hpsi_gs = plot(x,s*abs(psi_gs).^2,'linewidth',2,'color','green');
    legend("|\Psi|^2 system's state",'V(x) potential','|\Psi|^2 ground state');
    ylim([0,1]);
    
    %connection!
    phi(j) = angle(sum(psi'*psi_gs));       %Not necessarly to divide for the integral of |psi_gs|^2 cause its 1
    if norm(abs(psi)-abs(psi_gs)) < 1e-2    % means the two probabilities are equal at any x
        special_t = [special_t, j];
        special_phi = [special_phi, phi(j)];
    end
%     if j == phi_x_j
%         phi_x = angle(conj(psi).*psi_gs./abs(psi_gs).^2);
%         %phi_x = angle(psi./abs(psi));
%     end
end
%plot phi
figure(2);
hold on;
title(sprintf("Relative Phase between system's state\n and istantaneous ground state"))
xlabel("t");
ylabel("phase [rad]");
hphi = plot(tau*[1:nt],phi);
hspecialphi = plot(tau*special_t,special_phi,'.');
hspecialphi.Color = "red";
legend("at any time","when the curves |\Psi(t)|^2 and |\Psi_{GS}|^2 are close")
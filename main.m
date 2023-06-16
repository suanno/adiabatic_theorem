N = 2.24e3;
[x,k] = mk1Dgrids(N,'DBC');
ftfun = @sinft;
iftfun = @sinft;

a = 0.01; x = a*x;
k = k/a; 
kinE = k.^2/2;

tau = 0.01;
nt = 1e4;
%% choose parameters!
w = 0.2;      %Define frequency, m=hbar=1
dw = 0.0002;  %Define the step frequency changes at each discrete time
s = 100;     %Scaling factor for plotting the wave function
            %on the same canvas of the potential
%% plot the potential and fix axis
shg; clf
V = @(x) 0.5*w^2*(x).^2;  %Harmonic oscillator potential
hV = plot(x,V(x),'linewidth',2,'color','cyan');
hold on
xlim([x(1) x(end)]);
ylim([0,5]);
axis(axis)

%% setup initial wavefunction
psi = exp(-w*x.^2*0.5);  %GS of Harm oscillator, hbar = 1
psi = psi/norm(psi);  
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
    ylim([0,1]);
    legend("|\Psi|^2 system's state",'V(x) potential','|\Psi|^2 ground state')
end
    
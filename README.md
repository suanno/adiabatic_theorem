# Adiabatic Theorem visual proof
## Introduction
Here is presented an animation that shows the validity of the adiabatic approximation for an harmonic oscillator with a slow varying frequency.

The theorem states that the wave function where the system is _**follows**_ the _instantaneous ground state_ of the system, in this sense:

If you slowly vary the frequency of the oscillator, then the potential (and so the ground state) shape changes in time (so it makes sense talking of the _instantaneous ground state_). During the evolution of the system's state, its **absolute value $|\Psi|^2$** is well approximated by the one of the _instantaneous ground state_, as soon as you change the frequency slowly in time.
## How the code works
The code plots, as time passes, all those three objects (the potential, the system's state and the  _instantaneous ground state_) in the same canvas.

The evolution of the system's state is achieved _numerically_ with the "Operator splitting method":
$$\Psi(t+\tau) = e^{-i(V*\frac{\tau}{2})}\mathcal{F^{-1}}[e^{-i(k^2*\frac{\tau}{2})}\mathcal{F}[e^{-i(V*\frac{\tau}{2})}\Psi(t)]]$$
where $\mathcal{F}$ is the Fourier transform, $k$ is the dual variable of $x$, $\tau$ is the discrete time step and $V(x)$ is the harmonic oscillator potential.
The harmonic oscillator potential is $V(x)=\frac12\omega^2x^2$, where $\omega$ is the _instantaneous frequency_ ($\omega = \omega(t) $) that its changed linearly in time($\omega = \omega_0 + \alpha*t$).

**Note that:** the method adopted for the system's state evolution, for a time independent potential, commits an error of order $\tau^3$ in the single step $t\rightarrow t+\tau$ and so a global error, during the whole simulation, which is $\mathcal{O}(t^2)$. While it makes an error of order $\tau^2$ in the single step if the potential depends on time (and this is the case) and so the error is $\mathcal{O}(t)$ for the whole simulation.
It is possible to work on the precision of the evolution algorithm for a time-dependent potential, but its not the purpose of this repository.

## Relative phase
The adiabatic theorem states that _the modulus square_ of system's state at time t $|\Psi(t)^2|$ is well approximated by _the modulus square_ of the instantaneous ground state $|\Psi_{GS}(t)|$ if the frequency is slowly varying in time. But the approximation is not good for the wavefunction (that is a complex value!).

Here we calculate, at each time step, the **relative phase** between the two wave-functions $\varphi(t)$, defined as:
$$e^{i\varphi(t)} = \frac{\int_{-\infty}^{+\infty}dx\Phi^*(t)\Phi_{GS}(t)}{\int_{-\infty}^{+\infty}dx|\Phi_{GS}(t)|^2}$$
**Note that:** $\varphi(t)$ can be interpreted as the relative phase only if the modulus square of the two wave-functions are very close, otherwise they do not differ just by a phase!

Additionally two wave-function with the same modulus square could have a relative phase which is a function of $x$!
The adopted definition for $\varphi(t)$ is independent on $x$, so it is an 'average over x' of the relative phase; it would be nice to show that, at least for times $t$ when the modulus square of the two functions look the same, $\varphi(t)$ does not depend on $x$.

# How to use the code
Download all the .m files in the repository and add the directory hosting them to the "Matlab's path". Then execute the file "main.m".

In the "main.m" file there is a section where you can choose the parameters for the _adiabatic evolution_ (so just the velocity of the frequency change in this simple system) and the parameters for the system's state evolution (so the discrete time step $\tau$ and the simulation length).


![](https://github.com/suanno/adiabatic_theorem/blob/main/adiabatic_abs_harm.gif)

**Note that:** the relative phase plot shows up _only after the end_ of the simulation!
![](https://github.com/suanno/adiabatic_theorem/blob/main/relative_phase.png)

# Adiabatic Theorem visual proof
Here is presented an animation that shows the validity of the adiabatic approximation for an harmonic oscillator with a slow varying frequency.

The theorem states that the wave function where the system is "follows" the _instantaneous ground state_ of the system, in this sense:

If you slowly vary the frequency of the oscillator, then the potential (and so the ground state) shape changes in time (so it makes sense talking of the _instantaneous ground state_). During the evolution of the system's state, its _absolute value_ is well approximated by the one of the _instantaneous ground state_, as soon as you change the frequency slowly in time.

The code plots, as time passes, all those three objects (the potential, the system's state and the  _instantaneous ground state_) in the same canvas.

The evolution of the system's state is achieved _numerically_ with the "Operator splitting method":
$$\Psi(t+\tau) = e^{-i(V*\frac{\tau}{2})}\mathcal{F^{-1}}[e^{-i(k^2*\frac{\tau}{2})}\mathcal{F}[e^{-i(V*\frac{\tau}{2})}\Psi(t)]]$$

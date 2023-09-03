% Author: Claudio Destri

function [x,k] = mk1Dgrids(N,BC)
% [x,k] = mk1Dgrids(N,BC) return the x-space and k-space 1D grids
% corresponding to a unit lattice spacing and (for k-space) the boundary
% conditions BC, which can be
%   'PBC'   Periodic boundary conditions, the default;
%   'DBC'   Dirichlet boundary conditions;
%   'NBC'   Neumann boundary conditions.

narginchk(1,2)
if nargin < 2, BC = 'PBC'; end

% direct space 1D grid
x = (-(N-1)/2:(N-1)/2)';

if nargout == 2
    % Fourier space 1D grid
    switch BC
        case 'DBC'
            k = (pi/(N+1))*(1:N)';
        case 'NBC'
            k = (pi/N)*(0:N-1)';
        case 'PBC'
            n = floor(N/2);
            nn = floor((N-1)/2);
            k = (2*pi/N)*(-n:nn)';
        otherwise
            error('unknown type of boundary conditions')
    end
end

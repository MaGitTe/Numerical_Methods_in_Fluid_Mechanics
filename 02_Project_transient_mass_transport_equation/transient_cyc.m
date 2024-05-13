function [c, tend] = transient_cyc(c0, x, dt, CFL, Ne, Nt, alpha, theta, Nplot)
%TRANSIENT_CYC Calculate numerical solution of advection-dispersion equation with periodical Boundary conditions 
%   Detailed explanation goes here
nx = length(c0); %number of nodes
K = tridiagcyc(nx,1,-2,1);
Pb = tridiagcyc(nx,-1,1,0);
Pf = tridiagcyc(nx,0,-1,1);
I = eye(nx);
Al = I - theta*(Ne*K - CFL*(alpha*Pb + (1-alpha)*Pf));
Ar = (1-theta)*(Ne*K - CFL*(alpha*Pb + (1-alpha)*Pf)) - I;

if theta > 0 %only inverse Al if needed (implicit and Cranck-Nicolson scheme)
    Al_inv = 1/Al;
end

n = 0; %timestep
c = c0;
fig = figure;


while n < Nt % break condition
    % calculate c for n'th timestep
    if theta > 0 %implicit and Cranck-Nicolson scheme
        c = Al_inv * Ar * c;
    else %explicit
        c = Ar * c;
    end
   
    
    %Show c_n at every Nplot'th timestep
    if mod(Nplot+n,Nplot)
        t = n*dt;
        plot(x,c, 'x', 'DisplayName', ['t = ' num2str(t)], 'LineWidth', 1.5);
        hold on;
    end

    n = n + 1; %next timestep
    
end
tend = Nt*dt;

xlabel('$x$');
ylabel('$c$');
legend('Location', 'bestoutside');
grid;

end
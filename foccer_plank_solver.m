clc; clear; close all;

%% PARAMETERS
Smin = 0; 
Smax = 10000;
Ns = 400;
tf = 4;

dS = (Smax - Smin)/Ns;
S = linspace(Smin, Smax, Ns);

mu = 0.1;
sigma = 0.01;

% --- STABLE TIME STEP ---
dt_conv = dS / max(abs(mu*S) + 1e-6);
dt_diff = dS^2 / max(sigma^2 * S.^2 + 1e-6);
dt = 0.2 * min(dt_conv, dt_diff);

% Number of time steps
Nt = ceil(tf/dt);

% Artificial diffusion
epsilon = 0.01;

%% INITIAL CONDITION
p = exp(-(S-3000).^2/(2*(500)^2));   % adjusted to domain
p = p / sum(p);

P_store = zeros(Ns, Nt);

%% TIME INITIALIZATION
t = 0;
n = 1;
P_store(:,n) = p';

%% TIME EVOLUTION + ANIMATION
figure;

%% TIME INITIALIZATION
t = 0;
n = 1;

P_store = zeros(Ns, Nt);
P_store(:,n) = p';

figure;

while (t < tf) && (n < Nt)
    
    p_new = p;
    
    for i = 2:Ns-1
        
        % ----- CONSERVATIVE UPWIND FLUX -----
        S_ip = 0.5*(S(i) + S(i+1));
        S_im = 0.5*(S(i) + S(i-1));
        
        if mu*S_ip > 0
            F_ip = mu * S_ip * p(i);
        else
            F_ip = mu * S_ip * p(i+1);
        end
        
        if mu*S_im > 0
            F_im = mu * S_im * p(i-1);
        else
            F_im = mu * S_im * p(i);
        end
        
        drift = - (F_ip - F_im) / dS;
        
        % ----- DIFFUSION -----
        diffusion = 0.5 * (sigma^2 * S(i)^2) * ...
            (p(i+1) - 2*p(i) + p(i-1))/(dS^2);
        
        % ----- VISCOSITY -----
        viscosity = epsilon * ...
            (p(i+1) - 2*p(i) + p(i-1))/(dS^2);
        
        % Update
        p_new(i) = p(i) + dt * (drift + diffusion + viscosity);
    end
    
    % Boundary conditions
    p_new(1) = 0;
    p_new(end) = 0;
    
    % Positivity fix
    p_new = max(p_new, 0);
    
    % Normalization
    total_mass = sum(p_new);
    if total_mass > 1e-12
        p_new = p_new / total_mass;
    else
        warning('Mass collapsed, resetting');
        p_new = p;
    end
    
    % Update solution
    p = p_new;
    
    % ---- SAFE INDEX UPDATE ----
    n = n + 1;
    P_store(:,n) = p';
    
    % ---- ANIMATION ----
    if mod(n,10) == 0
        plot(S, p, 'b', 'LineWidth', 2);
        xlabel('Bitcoin Price');
        ylabel('Density');
        title(['Time = ', num2str(t)]);
        axis([Smin Smax 0 max(P_store(:))]);
        grid on;
        drawnow;
    end
    
    % ---- TIME UPDATE ----
    t = t + dt;
end

%% SAFE TRIM
P_store = P_store(:,1:n);

t_vec = linspace(0, t, n);

%% FINAL SURFACE PLOT
t_vec = linspace(0, t, size(P_store,2));
[S_grid, T_grid] = meshgrid(S, t_vec);

figure;
surf(S_grid, T_grid, P_store');
shading interp;
xlabel('Bitcoin Price');
ylabel('Time');
zlabel('Density');
title('Time Evolution Surface');
view(135,30);

% %% CONTOUR
% figure;
% contourf(S_grid, T_grid, P_store', 20);
% colorbar;
% xlabel('Bitcoin Price');
% ylabel('Time');
% title('Density Contours');
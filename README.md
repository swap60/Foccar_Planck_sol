```markdown
## 📖 Theory

This solver solves the **Fokker-Planck equation** for Geometric Brownian Motion:

$$\frac{\partial p}{\partial t} = -\frac{\partial}{\partial S}[\mu S \cdot p] + \frac{1}{2}\frac{\partial^2}{\partial S^2}[\sigma^2 S^2 \cdot p]$$

Where:
- `μ = 0.1` — drift (expected return)
- `σ = 0.01` — volatility
- `S` — Bitcoin price
- `p(S,t)` — probability density
| Feature                    | Implementation                                    |
| -------------------------- | ------------------------------------------------- |
| **Spatial Discretization** | Finite Volume (conservative form)                 |
| **Drift Flux**             | Upwind scheme with cell-face interpolation        |
| **Diffusion**              | Central differencing                              |
| **Stability**              | CFL condition: `dt ≤ 0.2 · min(dt_conv, dt_diff)` |
| **Artificial Viscosity**   | `ε = 0.01` for shock capturing                    |


**Numerical method:** Conservative finite-volume with upwind flux, central diffusion, and CFL-stable adaptive timestep.

## ⚡ Quick Start
```matlab
% Clone and run
git clone https://github.com/swap60/Foccar_Planck_sol.git
cd Foccar_Planck_sol
foccer_plank_solver
## ✨ Features

- Mass conservation (normalization enforced every timestep)
- Positivity preservation (`p ≥ 0`)
- Adaptive CFL-stable timestep
- Real-time animation during computation
- Pure base MATLAB (no toolboxes required)

```matlab
% Clone and run in MATLAB
git clone https://github.com/swap60/Foccar_Planck_sol.git
cd Foccar_Planck_sol
foccer_plank_solver   % Launches animated density evolution

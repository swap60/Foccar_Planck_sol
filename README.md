
### **2. Theory Section**

```markdown
## 📖 Theory

This solver solves the **Fokker-Planck equation** for Geometric Brownian Motion:

$$\frac{\partial p}{\partial t} = -\frac{\partial}{\partial S}[\mu S \cdot p] + \frac{1}{2}\frac{\partial^2}{\partial S^2}[\sigma^2 S^2 \cdot p]$$

Where:
- `μ = 0.1` — drift (expected return)
- `σ = 0.01` — volatility
- `S` — Bitcoin price
- `p(S,t)` — probability density

**Numerical method:** Conservative finite-volume with upwind flux, central diffusion, and CFL-stable adaptive timestep.

&lt;p align="center"&gt;
  &lt;a href="#-quick-start"&gt;&lt;img src="https://img.shields.io/badge/⚡_Quick_Start-ff6b6b?style=for-the-badge" alt="Quick Start"&gt;&lt
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

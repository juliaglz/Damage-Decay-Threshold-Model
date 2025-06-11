# Damage-Decay-Threshold-Model

## Introduction

This project simulates a system that experiences **shocks**, each associated with a certain amount of **damage**. The shocks follow a **Poisson Process**, occurring on average once every hour (with a rate $\lambda = 1$). The initial damage from each shock, denoted by $x$, is a random variable whose probability density function (PDF) is given by:

$$f(x) = \frac{9}{4}xe^{-\frac{3x}{2}} \quad \text{for } x > 0$$

Over time, the impact of each individual shock **decreases gradually** at an exponential rate $\alpha$, following the formula $xe^{-\alpha s}$, where $s$ is the time elapsed since the shock. The total damage to the system is calculated as the sum of the current (decayed) damages from all past shocks.

## The Project: Homogeneous Poisson Process Simulation

Our simulation models a **counting Poisson process**, which represents a series of discrete events (shocks) over a continuous time interval. Key characteristics of such a process include:

* **Non-negativity**: The number of shocks $N(t) \ge 0$.
* **Integer Values**: $N(t)$ is an integer, representing the total events by time $t$.
* **Monotonic Increase**: If $t_2 \ge t_1$, then $N(t_2) \ge N(t_1)$, meaning the event count does not decrease.
* **Independent Increments**: The number of events in non-overlapping time intervals are independent.

Given that our shock rate $\lambda$ is constant at $1$ and does not depend on time, this is a **homogeneous Poisson process**.

## Purpose

The primary goal of this project is to simulate and determine:

1.  **Time to Failure**: At what time the total damage suffered by the system exceeds a predefined **threshold capacity** ($C$).
2.  **Shocks to Failure**: How many shocks are necessary for this damage threshold to be met.

We investigate how two main factors influence these outcomes: the **damage fading speed** ($\alpha$) and the **system's damage limit** ($C$). Our analysis focuses on scenarios where $0.1 < \alpha$ and $C < 10$.
![image](https://github.com/user-attachments/assets/f1a9862e-521c-4653-80a3-01e7b8e74a70)

## Installation and Setup

This project requires **R** to be installed on your system. No specific external R packages beyond base R are needed.

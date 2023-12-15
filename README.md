Distributed-CNS-Scheduling-MATLAB
==============

An interactive app based on MATLAB App Designer to demonstrate distributed cooperative navigation strategy scheduling.

# Getting Started

1. Clone the repository
2. Open the file named App_CNS.mlapp in MATLAB
3. Run the app and interact with its components

# Modules

The app has eight modules:

1. Parameter Setting
2. Geometric Distributions Generator
3. Offline Design
4. Online Selection
5. Display Area
6. Properties of the Optimal CNS
7. Suggestion Area
8. Clear

![Figure1](https://github.com/Why918/Figures/blob/main/APP-Components.png)

## Parameter Setting

First, set the appropriate parameters or keep the default parameters.

![Figure2](https://github.com/Why918/Figures/blob/main/Parametersetting.png)

## Geometric Distributions Generator

Specify "Number of agents", then push the button "Generate geometric distributions" to randomly generate geometric distributions of the multi-agent system.

![Figure3](https://github.com/Why918/Figures/blob/main/Geometric.png)

If Suggestion Area is as shown below, it indicates that geometric distributions are successfully generated.

![Figure4](https://github.com/Why918/Figures/blob/main/Geo-sugg.png)

Geometric distributions are displayed in Display Area.

![Figure5](https://github.com/Why918/Figures/blob/main/Geometric-succ.png)

## Offline Design

Click on one agent in Geometric distributions, enter its coordinates, then push the button "Select this agent".

![Figure6](https://github.com/Why918/Figures/blob/main/Coordinate.png)

If Suggestion Area is as shown below, it indicates that selection is complete.

![Figure7](https://github.com/Why918/Figures/blob/main/Select-sugg.png)

The selected agent and its neighbors are displayed in Display Area.

![Figure7](https://github.com/Why918/Figures/blob/main/Selectneigh.png)

Push the button "Perform dynamic programming", then the design CNSs of the selected agent is displayed in Display Area, and running time is showed.


## Online Selection


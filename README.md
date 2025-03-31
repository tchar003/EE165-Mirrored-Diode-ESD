# Mirrored Diode ESD Protection Design – EE165 Project

This project explores a mirrored nplus-pwell diode layout for improving ESD (Electrostatic Discharge) robustness using TCAD simulations. The design was evaluated under 2kV Human Body Model (HBM) stress, comparing thermal and electrical behavior against a standard nplus-pwell diode.

## Project Overview
- Developed a mirrored diode layout by doubling and flipping p/n active regions to distribute current and heat more effectively
- Simulated electrical (I-V characteristics) and thermal (lattice temperature) responses using Synopsys Sentaurus TCAD tools
- Compared against a standard p+ to n-well diode under identical stress conditions

## Tools and Environment
- Sentaurus TCAD (run on UCR Engineering remote server)
- HBM Simulation (2kV, 10 ns pulse)
- Device and mesh files written in `.cmd` and `.jrl` formats

## Key Results
- Mirrored diode reduced peak current per contact while maintaining identical trigger voltage
- At minimum width, the mirrored diode showed a 17K lower peak temperature
- Heat was more evenly distributed, indicating improved thermal handling
- Some edge hotspots appeared due to layout asymmetry, with further refinement possible

## Report 

[View Project Report (PDF)](Report/EE165%20-%20Project%20Report%20Tyler%20Chargualaf%20%26%20Neha%20Agrawal.pdf)

## Notes
- This repository serves as a record of simulation setup, project documentation, and analysis.
- The simulation files are provided for reference only and require a licensed TCAD environment to execute.
- Output files (.tdr, .plt) require post-processing tools such as Sentaurus Inspect and may not be viewable without appropriate software.

## Authors
- Tyler Chargualaf  
- Neha Agrawal

This project was completed for EE165 – Design for Reliability of Integrated Circuits and Systems at the University of California, Riverside.

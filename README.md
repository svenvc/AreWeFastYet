# AreWeFastYet

This is a port of Stefan Marr's Are We Fast Yet? 's benchmarking suite.

These benchmarks were originally written in SOM, a minimal Smalltalk dialect, and loaded into Pharo using the original tools.

Loading

- only the package Scripting and AWFY-Benchmarks are necessary to run the benchmarks themselves
- the packages SomLoader-Compiler and SomLoader-Tests are optional and are needed for transcompilation

Usage

    AreWeFastYet run.
    
References

- https://github.com/smarr/are-we-fast-yet/tree/master
- http://som-st.github.io
- https://stefan-marr.de/papers/dls-marr-et-al-cross-language-compiler-benchmarking-are-we-fast-yet/
- https://rebench.stefan-marr.de

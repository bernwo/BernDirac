# BernDirac
A [Wolfram Mathematica](https://www.wolfram.com/mathematica/) package for performing calculations involving matrices/vectors in the [Dirac notation](https://en.wikipedia.org/wiki/Bra%E2%80%93ket_notation) which is usually used in [quantum mechanics](https://en.wikipedia.org/wiki/Quantum_mechanics)/[quantum computing](https://en.wikipedia.org/wiki/Quantum_computing). It utilises the built-in functions *without predefined meanings*: `Ket[]`, `Bra[]`, and `CircleTimes[]`, along with their respective alias, namely `"| ⟩" - [esc]ket[esc]`, `"⟨ |" - [esc]bra[esc]` and `"⊗" - [esc]c*[esc]`.

The package was written in Wolfram Mathematica version 12.2 in Windows 10.

# How to use?
Download [BernDirac.wl](https://github.com/bernie-wu/BernDirac/blob/main/BernDirac.wl) and place it wherever you like. Then, in your Mathematica notebook, run `Get[<path-to-BernDirac.wl>]`.

# Functions that this package provides.
Importing [BernDirac.wl](https://github.com/bernie-wu/BernDirac/blob/main/BernDirac.wl) into your Mathematica notebook session yields the following additional functions:
 * **Ket[]**

> ![|0⟩](Image/Ket_ket0_in.svg "|0⟩")<br />
> ![|0⟩](Image/Ket_ket0_outv2.svg "|0⟩")

> ![|1⟩](Image/Ket_ket1_in.svg "|1⟩")<br />
> ![|1⟩](Image/Ket_ket1_outv2.svg "|1⟩")

 * **Bra[]**
 * **CircleTimes[]**
 * **DiracForm[]**
 * **PartialTr[]**

# Example
The only file you need is [BernDirac.wl](https://github.com/bernie-wu/BernDirac/blob/main/BernDirac.wl). A Mathematica notebook .nb file showing examples of how to use this package can be found in the [Example](https://github.com/bernie-wu/BernDirac/tree/main/Example) folder.

# Who am I and why did I create this package?
At the time of writing this I am a graduate student with homework assignments involved in heavy and tedious quantum mechanics calculations. I created this Mathematica package to ease my life and since it helped me a tonne, I figured I should share this with the public too in case someone is also in the same boat as me.

# TO-DO
 * Write a full fledged example usage within the [readme.md](https://github.com/bernie-wu/BernDirac/blob/main/README.md) itself.
 * Write better *usage* descriptions in [BernDirac.wl](https://github.com/bernie-wu/BernDirac/blob/main/BernDirac.wl).
 * Add more functions to [BernDirac.wl](https://github.com/bernie-wu/BernDirac/blob/main/BernDirac.wl).

# BernDirac
[![Wolfram Language](https://wolfr.am/NyiJ4BVJ)](https://www.wolfram.com/language/)
[![License: GPL v3](https://img.shields.io/badge/License-GPLv3-blue.svg)](https://www.gnu.org/licenses/gpl-3.0)

A [Wolfram Mathematica](https://www.wolfram.com/mathematica/) package for performing calculations involving matrices/vectors in the [Dirac notation](https://en.wikipedia.org/wiki/Bra%E2%80%93ket_notation) which is usually used in [quantum mechanics](https://en.wikipedia.org/wiki/Quantum_mechanics)/[quantum computing](https://en.wikipedia.org/wiki/Quantum_computing). It utilises the built-in functions *without predefined meanings*: `Ket[]`, `Bra[]`, and `CircleTimes[]`, along with their respective alias, namely <code>"| ⟩" → <kbd>esc</kbd>ket<kbd>esc</kbd></code>, <code>"⟨ |" → <kbd>esc</kbd>bra<kbd>esc</kbd></code> and <code>"⊗" → <kbd>esc</kbd>c*<kbd>esc</kbd></code>.

The package was written in Wolfram Mathematica version [12.2](https://www.wolfram.com/mathematica/quick-revision-history.html) in Windows 10.

# How to use?
Download [BernDirac.wl](https://github.com/bernie-wu/BernDirac/blob/main/BernDirac.wl) and place it wherever you like. Then, in your Mathematica notebook, run the following line:

```wolframlanguage
Get[<path-to-BernDirac.wl>];
```

# Functions that this package provides.
Importing [BernDirac.wl](https://github.com/bernie-wu/BernDirac/blob/main/BernDirac.wl) into your Mathematica notebook session yields the following additional functions:  
→[`Ket[]`](#Ket "Go-to Ket[]")  
→[`Bra[]`](#Bra "Go-to Bra[]")  
→[`CircleTimes[]`](#CircleTimes "Go-to CircleTimes[]")  
→[`DiracForm[]`](#CircleTimes "Go-to DiracForm[]")  
→[`PartialTr[]`](#CircleTimes "Go-to PartialTr[]")  

## Ket[]
The alias `| ⟩` for `Ket[]` can be obtained with <code><kbd>esc</kbd>ket<kbd>esc</kbd></code>.
The input for `Ket[]` is either `0` or `1` and the output for each case is as shown here:

>> ![|0⟩](Image/Ket_ket0_in.svg "|0⟩")  
>> ![|0⟩](Image/Ket_ket0_outv2.svg "|0⟩")
>
>> ![|1⟩](Image/Ket_ket1_in.svg "|1⟩")  
>> ![|1⟩](Image/Ket_ket1_outv2.svg "|1⟩")

`Ket[]` also supports multiple inputs, as long as they are `0` and `1`.

>  

## Bra[]

## CircleTimes[]

## DiracForm[]

## PartialTr[]

# Example
The only file you need is [BernDirac.wl](https://github.com/bernie-wu/BernDirac/blob/main/BernDirac.wl). A Mathematica notebook .nb file showing examples of how to use this package can be found in the [Example](https://github.com/bernie-wu/BernDirac/tree/main/Example) folder.

# Who am I and why did I create this package?
At the time of writing this I am a graduate student with homework assignments involved in heavy and tedious quantum mechanics calculations. I created this Mathematica package to ease my life and since it helped me a tonne, I figured I should share this with the public too in case someone is also in the same boat as me.

# TO-DO
 * Write a full fledged example usage within the [readme.md](https://github.com/bernie-wu/BernDirac/blob/main/README.md) itself.
 * Write better *usage* descriptions in [BernDirac.wl](https://github.com/bernie-wu/BernDirac/blob/main/BernDirac.wl).
 * Add more functions to [BernDirac.wl](https://github.com/bernie-wu/BernDirac/blob/main/BernDirac.wl).

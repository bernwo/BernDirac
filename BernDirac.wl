(* ::Package:: *)

BeginPackage["BernDirac`"];


Protect[\[FormalCapitalC]X,\[FormalCapitalC]NOT,\[FormalCapitalC]Z,\[FormalCapitalS]WAP,\[FormalCapitalT]OFFOLI,\[FormalSigma]p,\[FormalSigma]n,\[FormalCapitalS]X,\[FormalCapitalS]Y,\[FormalCapitalS]Z,\[FormalCapitalS]p,\[FormalCapitalS]n,\:ff0d,\:ff0b];


CircleTimes::usage="a\[CircleTimes]b is the alias for KroneckerProduct[a,b]."


Ket::usage="Ket[a] where a\[Element]{0,1}."


Bra::usage="Bra[a] where a\[Element]{0,1}."


OverHat::usage="Provides some common quantum logic gates."


PartialTr::usage="PartialTr[square_matrix,loc_list] performs partial trace on the square_matrix at 'indices' given by loc_list."


DiracForm::usage="DiracForm[A] where A could be either a square matrix, a column vector or a row vector. It outputs the given input in Dirac notation (i.e. Ket and Bra)."


SimpDiracForm::usage="SimpDiracForm[A] where A could be either a square matrix, a column vector or a row vector. It outputs the given input in Dirac notation where the terms with common coefficients are grouped together."


Fidelity::usage="Fidelity[\[Rho],\[Sigma]] returns the fidelity given density matrices \[Rho] and \[Sigma]."


Begin["`Private`"]


CircleTimes[xsSeq___]:=KroneckerProduct[xsSeq]/;(Dimensions[{xsSeq}][[1]]>=2);
CircleTimes/:(Superscript[m_List,\[CircleTimes]xsSeq_Integer]):=Catch[Module[{out,temp},
out=m;
temp=m;
Do[out=KroneckerProduct[temp,out];,{i,1,xsSeq-1}];
out
]];


Ket[xsSeq___]:=Catch[With[{xs=If[$VersionNumber >= 13.3, xsSeq, {xsSeq}]}
,
Module[{ket,tket,n=Length[xs]},
Do[
tket=Which[SameQ[xs[[t]],0],{{1},{0}},SameQ[xs[[t]],1],{{0},{1}},Or[SameQ[xs[[t]],\:ff0b],SameQ[xs[[t]],"+"]],{{1/Sqrt[2]},{1/Sqrt[2]}},Or[SameQ[xs[[t]],\:ff0d],SameQ[xs[[t]],"-"]],{{1/Sqrt[2]},{-(1/Sqrt[2])}},True,Throw[$Failed]];
If[t==1
,ket=tket;
,ket=KroneckerProduct[ket,tket];
]
,
{t,n}];
ket]]];
Ket[Subscript[a_Symbol, n___]]:=Catch[
Which[
SameQ[a,\[FormalCapitalPhi]],
Which[
{n}=={0,0},{{1/(\[Sqrt]2)},{0},{0},{1/(\[Sqrt]2)}},
{n}=={0,1},{{0},{1/(\[Sqrt]2)},{1/(\[Sqrt]2)},{0}},
{n}=={1,0},{{1/(\[Sqrt]2)},{0},{0},{-(1/(\[Sqrt]2))}},
{n}=={1,1},{{0},{1/(\[Sqrt]2)},{-(1/(\[Sqrt]2))},{0}},
True,Throw[$Failed]],
True,
Throw[$Failed]
]
];


Bra[xsSeq___]:=Ket[xsSeq]\[ConjugateTranspose];


Bra[Subscript[a_Symbol, n___]]:=Ket[Subscript[a, n]]\[ConjugateTranspose];


Options[PartialTr]={"Basis"->Automatic}
PartialTr[a_,loc_List,OptionsPattern[]]:=Catch[
With[{basis=Replace[OptionValue["Basis"],Automatic:>ConstantArray["Z",Length[loc]]]},
Module[{\[Rho]=a,d=Dimensions[a],bits1,bits2,sortedloc,loclength=Length[loc],sortedbasis,basislength,lk0,lk1,\[DoubleStruckCapitalI]k0,\[DoubleStruckCapitalI]k1,\[DoubleStruckCapitalI]b0,\[DoubleStruckCapitalI]b1,k0={{1},{0}},k1={{0},{1}},kp={{1/Sqrt[2]},{1/Sqrt[2]}},kn={{1/Sqrt[2]},{-(1/Sqrt[2])}}},
bits1=Ceiling[Log2[d[[1]]]];
bits2=Ceiling[Log2[d[[2]]]];
sortedloc=Sort[loc,Greater];
sortedbasis=basis[[Reverse[Ordering@loc]]];
basislength=Length[sortedbasis];
Which[d[[1]]==d[[2]],Do[
lk0=ConstantArray[IdentityMatrix[2],bits1+1-i];
lk0[[sortedloc[[i]]]]=Which[SameQ[sortedbasis[[i]],"Z"],k0,SameQ[sortedbasis[[i]],"X"],kp];
\[DoubleStruckCapitalI]k0=Apply[KroneckerProduct,lk0];
lk1=ConstantArray[IdentityMatrix[2],bits1+1-i];
lk1[[sortedloc[[i]]]]=Which[SameQ[sortedbasis[[i]],"Z"],k1,SameQ[sortedbasis[[i]],"X"],kn];
\[DoubleStruckCapitalI]k1=Apply[KroneckerProduct,lk1];
\[DoubleStruckCapitalI]b0=\[DoubleStruckCapitalI]k0\[ConjugateTranspose];
\[DoubleStruckCapitalI]b1=\[DoubleStruckCapitalI]k1\[ConjugateTranspose];
\[Rho]=\[DoubleStruckCapitalI]b0 . \[Rho] . \[DoubleStruckCapitalI]k0+\[DoubleStruckCapitalI]b1 . \[Rho] . \[DoubleStruckCapitalI]k1;,{i,1,loclength}];
,
d[[1]]==1&&d[[2]]>1,Do[
lk0=ConstantArray[IdentityMatrix[2],bits2+1-i];
lk0[[sortedloc[[i]]]]=Which[SameQ[sortedbasis[[i]],"Z"],k0,SameQ[sortedbasis[[i]],"X"],kp];
\[DoubleStruckCapitalI]k0=Apply[KroneckerProduct,lk0];
lk1=ConstantArray[IdentityMatrix[2],bits2+1-i];
lk1[[sortedloc[[i]]]]=Which[SameQ[sortedbasis[[i]],"Z"],k1,SameQ[sortedbasis[[i]],"X"],kn];
\[DoubleStruckCapitalI]k1=Apply[KroneckerProduct,lk1];
\[Rho]=\[Rho] . \[DoubleStruckCapitalI]k0+\[Rho] . \[DoubleStruckCapitalI]k1;,{i,1,loclength}];
,
d[[1]]>1&&d[[2]]==1,Do[
lk0=ConstantArray[IdentityMatrix[2],bits1+1-i];
lk0[[sortedloc[[i]]]]=Which[SameQ[sortedbasis[[i]],"Z"],k0,SameQ[sortedbasis[[i]],"X"],kp];
\[DoubleStruckCapitalI]k0=Apply[KroneckerProduct,lk0];
lk1=ConstantArray[IdentityMatrix[2],bits1+1-i];
lk1[[sortedloc[[i]]]]=Which[SameQ[sortedbasis[[i]],"Z"],k1,SameQ[sortedbasis[[i]],"X"],kn];
\[DoubleStruckCapitalI]k1=Apply[KroneckerProduct,lk1];
\[DoubleStruckCapitalI]b0=\[DoubleStruckCapitalI]k0\[ConjugateTranspose];
\[DoubleStruckCapitalI]b1=\[DoubleStruckCapitalI]k1\[ConjugateTranspose];
\[Rho]=\[DoubleStruckCapitalI]b0 . \[Rho]+\[DoubleStruckCapitalI]b1 . \[Rho];,{i,1,loclength}];
,sortedloc[[1]]>Max[{bits1,bits2}],Throw[$Failed],True,Throw[$Failed]];
\[Rho]]]];


OverHat[a_Symbol]:=Catch[
Which[
SameQ[a,\[FormalCapitalX]],
{{0,1},{1,0}}
,SameQ[a,\[FormalCapitalY]],
{{0,-I},{I,0}}
,SameQ[a,\[FormalCapitalZ]],
{{1,0},{0,-1}}
,SameQ[a,\[FormalCapitalS]X],
{{0,1/2},{1/2,0}}
,SameQ[a,\[FormalCapitalS]Y],
{{0,-I/2},{I/2,0}}
,SameQ[a,\[FormalCapitalS]Z],
{{1/2,0},{0,-1/2}}
,SameQ[a,\[FormalCapitalH]],
{{1/Sqrt[2],1/Sqrt[2]},{1/Sqrt[2],-(1/Sqrt[2])}}
,SameQ[a,\[FormalCapitalS]],
{{1,0},{0,I}}
,SameQ[a,\[FormalCapitalT]],
{{1,0},{0,E^((I \[Pi])/4)}}
,SameQ[a,\[FormalCapitalC]X]\[Or]SameQ[a,\[FormalCapitalC]NOT],
{{1,0,0,0},{0,1,0,0},{0,0,0,1},{0,0,1,0}}
,SameQ[a,\[FormalCapitalC]Z],
{{1,0,0,0},{0,1,0,0},{0,0,1,0},{0,0,0,-1}}
,SameQ[a,\[FormalSigma]p],(*Overscript[\[FormalSigma]p, ^]==1/2(Overscript[\[FormalCapitalX], ^]-\[ImaginaryI]Overscript[\[FormalCapitalY], ^])*)
{{0,0},{1,0}}
,SameQ[a,\[FormalSigma]n],(*Overscript[\[FormalSigma]n, ^]==1/2(Overscript[\[FormalCapitalX], ^]+\[ImaginaryI]Overscript[\[FormalCapitalY], ^])*)
{{0,1},{0,0}}
,SameQ[a,\[FormalCapitalS]p],
{{0,0},{1/2,0}}
,SameQ[a,\[FormalCapitalS]n],
{{0,1/2},{0,0}}
,SameQ[a,\[FormalCapitalS]WAP],
{{1,0,0,0},{0,0,1,0},{0,1,0,0},{0,0,0,1}}
,SameQ[a,\[FormalCapitalT]OFFOLI],
{{1,0,0,0,0,0,0,0},{0,1,0,0,0,0,0,0},{0,0,1,0,0,0,0,0},{0,0,0,1,0,0,0,0},{0,0,0,0,1,0,0,0},{0,0,0,0,0,1,0,0},{0,0,0,0,0,0,0,1},{0,0,0,0,0,0,1,0}}
,True,
$Failed
]
];


Options[DiracForm]={"Basis"->Automatic}
DiracForm[a_,OptionsPattern[]]:=Catch[
With[{basis=Replace[OptionValue["Basis"],Automatic:>ConstantArray["Z",Max[Ceiling[Log2[Dimensions[a][[1]]]],Ceiling[Log2[Dimensions[a][[2]]]]]]]},
Module[{mutable\[Ellipsis]a,sum,d=Dimensions[a],bits1,bits2,maxbits,dBra,dKet,unitary,KProduct,where\[Ellipsis]X,ReplaceBasis},
If[$VersionNumber>=13.3,
dBra[b1__]:=Defer[Bra[b1]];
dKet[b2__]:=Defer[Ket[b2]];
,
dBra[{b1__}]:=Defer[Bra[b1]];
dKet[{b2__}]:=Defer[Ket[b2]];
];

KProduct[{u___},maxbits_]:=If[maxbits>1,KroneckerProduct[u],{u}[[1,All,All]]];
ReplaceBasis[{l___},loc_List]:=Module[{m=l},m[[loc]]=m[[loc]]/.{p_?NumericQ/;p==1->\:ff0d,q_?NumericQ/;q==0->\:ff0b};m];
bits1=Ceiling[Log2[d[[1]]]];
bits2=Ceiling[Log2[d[[2]]]];
maxbits=Max[{bits1,bits2}];
unitary=ConstantArray[IdentityMatrix[2],maxbits];
where\[Ellipsis]X=Flatten[Position[basis,"X"]];
Do[unitary[[where\[Ellipsis]X[[k]],All,All]]={{1/Sqrt[2],1/Sqrt[2]},{1/Sqrt[2],-(1/Sqrt[2])}};,{k,1,Length[where\[Ellipsis]X]}];
sum=Which[d[[1]]==d[[2]],
mutable\[Ellipsis]a=KProduct[unitary,maxbits] . a . KProduct[unitary,maxbits]\[ConjugateTranspose];
\!\(
\*UnderoverscriptBox[\(\[Sum]\), \(i = 1\), \(d[\([1]\)]\)]\(
\*UnderoverscriptBox[\(\[Sum]\), \(j = 1\), \(d[\([2]\)]\)]\((mutable\[Ellipsis]a[\([i, j]\)]*dKet[ReplaceBasis[{IntegerDigits[i - 1, 2, bits1]}, where\[Ellipsis]X]] . dBra[ReplaceBasis[{IntegerDigits[j - 1, 2, bits1]}, where\[Ellipsis]X]])\)\)\)
,d[[1]]==1&&d[[2]]>1,
mutable\[Ellipsis]a=a . KProduct[unitary,maxbits]\[ConjugateTranspose];
\!\(
\*UnderoverscriptBox[\(\[Sum]\), \(j = 1\), \(d[\([2]\)]\)]\((mutable\[Ellipsis]a[\([1, j]\)]*dBra[ReplaceBasis[{IntegerDigits[j - 1, 2, bits2]}, where\[Ellipsis]X]])\)\)
,d[[1]]>1&&d[[2]]==1,
mutable\[Ellipsis]a=KProduct[unitary,maxbits] . a;
\!\(
\*UnderoverscriptBox[\(\[Sum]\), \(i = 1\), \(d[\([1]\)]\)]\((mutable\[Ellipsis]a[\([i, 1]\)]*dKet[ReplaceBasis[{IntegerDigits[i - 1, 2, bits1]}, where\[Ellipsis]X]])\)\)
,True,
Throw[$Failed]];
sum]]];


SimpDiracForm[v_List]:=Catch[Module[{out,sum,d,bits1,bits2,dBra,dKet,unique\[Ellipsis]coeff,lu,c},
d=Dimensions[v];
dBra[{b1__}]:=Defer[Bra[b1]];
dKet[{b2__}]:=Defer[Ket[b2]];
bits1=Ceiling[Log2[d[[1]]]];
bits2=Ceiling[Log2[d[[2]]]];
unique\[Ellipsis]coeff=DeleteCases[DeleteDuplicates@*Flatten@v,0,Infinity];
lu=unique\[Ellipsis]coeff//Length;
c=Apply[PolynomialGCD,unique\[Ellipsis]coeff];
sum=ConstantArray[0,lu];
Which[d[[1]]==d[[2]],
Do[
If[v[[i,j]]===unique\[Ellipsis]coeff[[k]],sum[[k]]+=dKet[IntegerDigits[i-1,2,bits1]] . dBra[IntegerDigits[j-1,2,bits2]]];
,
{k,1,lu},
{i,1,d[[1]]},
{j,1,d[[2]]}
];
,d[[1]]==1&&d[[2]]>1,
Do[
If[v[[1,j]]===unique\[Ellipsis]coeff[[k]],sum[[k]]+=dBra[IntegerDigits[j-1,2,bits2]]];
,
{k,1,lu},
{j,1,d[[2]]}
];
,d[[1]]>1&&d[[2]]==1,
Do[
If[v[[i,1]]===unique\[Ellipsis]coeff[[k]],sum[[k]]+=dKet[IntegerDigits[i-1,2,bits1]]];
,
{k,1,lu},
{i,1,d[[1]]}
];
,True,
Throw[$Failed]
];
out=c*Dot[sum,unique\[Ellipsis]coeff/c];
out]];


Fidelity[\[Rho]_,\[Sigma]_]:=Re[Tr[MatrixPower[MatrixPower[\[Rho],1/2] . \[Sigma] . MatrixPower[\[Rho],1/2],1/2]]]^2;


End[];


EndPackage[];

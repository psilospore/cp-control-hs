
// TaxiConfMat
// Prism Looping State Machine
// Generated: 2025-01-10 10:21:42.630716
// PC values:
//   0 : Perceiver (CTE)
//   1 : Perceiver (HE)
//   2 : Controller
//   3 : Dynamics
//   4 : Aborter
//   5 : Loop Logic
//   6 : cte_fail
//   7 : he_fail
//   8 : dyn_fail


dtmc

const N;

module TaxiConfMat

  cte : [-4..4] init 0;
  he : [-2..2] init 0;
  cte_est : [-2..2] init 0;
  he_est : [-1..1] init 0;
  a : [-1..1] init 0;
  pc : [0..8] init 0; // program counter
  k : [0..N] init 1; // loop counter


  // Perceiver (CTE)
  [] cte=-2  & pc=0 -> 0.2268041237113402 : (cte_est'=-2) & (pc'=1) + 0.211340206185567 : (cte_est'=-1) & (pc'=1) + 0.24742268041237114 : (cte_est'=0) & (pc'=1) + 0.15463917525773196 : (cte_est'=1) & (pc'=1) + 0.15979381443298968 : (cte_est'=2) & (pc'=1) ;
  [] cte=-1  & pc=0 -> 0.23979591836734693 : (cte_est'=-2) & (pc'=1) + 0.1683673469387755 : (cte_est'=-1) & (pc'=1) + 0.1836734693877551 : (cte_est'=0) & (pc'=1) + 0.1836734693877551 : (cte_est'=1) & (pc'=1) + 0.22448979591836735 : (cte_est'=2) & (pc'=1) ;
  [] cte=0  & pc=0 -> 0.17 : (cte_est'=-2) & (pc'=1) + 0.245 : (cte_est'=-1) & (pc'=1) + 0.19 : (cte_est'=0) & (pc'=1) + 0.23 : (cte_est'=1) & (pc'=1) + 0.165 : (cte_est'=2) & (pc'=1) ;
  [] cte=1  & pc=0 -> 0.2413793103448276 : (cte_est'=-2) & (pc'=1) + 0.20689655172413793 : (cte_est'=-1) & (pc'=1) + 0.21674876847290642 : (cte_est'=0) & (pc'=1) + 0.18226600985221675 : (cte_est'=1) & (pc'=1) + 0.15270935960591134 : (cte_est'=2) & (pc'=1) ;
  [] cte=2  & pc=0 -> 0.21739130434782608 : (cte_est'=-2) & (pc'=1) + 0.1642512077294686 : (cte_est'=-1) & (pc'=1) + 0.21256038647342995 : (cte_est'=0) & (pc'=1) + 0.18840579710144928 : (cte_est'=1) & (pc'=1) + 0.21739130434782608 : (cte_est'=2) & (pc'=1) ;

  // Perceiver (HE)
  [] he=-1  & pc=1 -> 0.3575949367088608 : (he_est'=-1) & (pc'=2) + 0.3069620253164557 : (he_est'=0) & (pc'=2) + 0.33544303797468356 : (he_est'=1) & (pc'=2) ;
  [] he=0  & pc=1 -> 0.3554913294797688 : (he_est'=-1) & (pc'=2) + 0.315028901734104 : (he_est'=0) & (pc'=2) + 0.32947976878612717 : (he_est'=1) & (pc'=2) ;
  [] he=1  & pc=1 -> 0.31952662721893493 : (he_est'=-1) & (pc'=2) + 0.28402366863905326 : (he_est'=0) & (pc'=2) + 0.39644970414201186 : (he_est'=1) & (pc'=2) ;

  // Controller
  [] cte_est=-2 & he_est=-1  & pc=2 -> 1 : (a'=1) & (pc'=3) ;
  [] cte_est=-2 & he_est=0  & pc=2 -> 1 : (a'=1) & (pc'=3) ;
  [] cte_est=-2 & he_est=1  & pc=2 -> 1 : (a'=0) & (pc'=3) ;
  [] cte_est=-1 & he_est=-1  & pc=2 -> 1 : (a'=1) & (pc'=3) ;
  [] cte_est=-1 & he_est=0  & pc=2 -> 1 : (a'=1) & (pc'=3) ;
  [] cte_est=-1 & he_est=1  & pc=2 -> 1 : (a'=0) & (pc'=3) ;
  [] cte_est=0 & he_est=-1  & pc=2 -> 1 : (a'=1) & (pc'=3) ;
  [] cte_est=0 & he_est=0  & pc=2 -> 1 : (a'=0) & (pc'=3) ;
  [] cte_est=0 & he_est=1  & pc=2 -> 1 : (a'=-1) & (pc'=3) ;
  [] cte_est=1 & he_est=-1  & pc=2 -> 1 : (a'=0) & (pc'=3) ;
  [] cte_est=1 & he_est=0  & pc=2 -> 1 : (a'=-1) & (pc'=3) ;
  [] cte_est=1 & he_est=1  & pc=2 -> 1 : (a'=-1) & (pc'=3) ;
  [] cte_est=2 & he_est=-1  & pc=2 -> 1 : (a'=0) & (pc'=3) ;
  [] cte_est=2 & he_est=0  & pc=2 -> 1 : (a'=-1) & (pc'=3) ;
  [] cte_est=2 & he_est=1  & pc=2 -> 1 : (a'=-1) & (pc'=3) ;

  // Dynamics
  [] cte>=-2 & cte<=2 & he>=-1 & he<=1 & pc=3 -> 1 : (he'=he+a) & (cte'=cte+he+a) & (pc'=4) ;
  [] (cte< -2 | cte>2 | he< -1 | he>1) & pc=3 -> 1 : (pc'=8) ;

  // Aborter
  [] (cte< -2 | cte>2) & pc=4 -> 1 : (pc'=6) ;
  [] (he< -1 | he>1) & pc=4 -> 1 : (pc'=7) ;
  [] cte>=-2 & cte<=2 & he>=-1 & he<=1 & pc=4 -> 1 : (pc'=5) ;



  // Loop Logic
  [] pc=5 & k < N -> 1 : (pc'=0) & (k'=k+1) ;


endmodule

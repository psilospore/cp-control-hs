
// TaxiConfMat
// Prism Looping State Machine
// Generated: 2025-01-10 10:21:12.264687
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
  [] cte=-2  & pc=0 -> 0.19289340101522842 : (cte_est'=-2) & (pc'=1) + 0.233502538071066 : (cte_est'=-1) & (pc'=1) + 0.18781725888324874 : (cte_est'=0) & (pc'=1) + 0.2233502538071066 : (cte_est'=1) & (pc'=1) + 0.16243654822335024 : (cte_est'=2) & (pc'=1) ;
  [] cte=-1  & pc=0 -> 0.21428571428571427 : (cte_est'=-2) & (pc'=1) + 0.17857142857142858 : (cte_est'=-1) & (pc'=1) + 0.22448979591836735 : (cte_est'=0) & (pc'=1) + 0.20408163265306123 : (cte_est'=1) & (pc'=1) + 0.17857142857142858 : (cte_est'=2) & (pc'=1) ;
  [] cte=0  & pc=0 -> 0.1658291457286432 : (cte_est'=-2) & (pc'=1) + 0.1658291457286432 : (cte_est'=-1) & (pc'=1) + 0.24623115577889448 : (cte_est'=0) & (pc'=1) + 0.21608040201005024 : (cte_est'=1) & (pc'=1) + 0.20603015075376885 : (cte_est'=2) & (pc'=1) ;
  [] cte=1  & pc=0 -> 0.19402985074626866 : (cte_est'=-2) & (pc'=1) + 0.22388059701492538 : (cte_est'=-1) & (pc'=1) + 0.22388059701492538 : (cte_est'=0) & (pc'=1) + 0.15920398009950248 : (cte_est'=1) & (pc'=1) + 0.19900497512437812 : (cte_est'=2) & (pc'=1) ;
  [] cte=2  & pc=0 -> 0.2608695652173913 : (cte_est'=-2) & (pc'=1) + 0.21256038647342995 : (cte_est'=-1) & (pc'=1) + 0.13043478260869565 : (cte_est'=0) & (pc'=1) + 0.18357487922705315 : (cte_est'=1) & (pc'=1) + 0.21256038647342995 : (cte_est'=2) & (pc'=1) ;

  // Perceiver (HE)
  [] he=-1  & pc=1 -> 0.32294617563739375 : (he_est'=-1) & (pc'=2) + 0.31444759206798867 : (he_est'=0) & (pc'=2) + 0.3626062322946176 : (he_est'=1) & (pc'=2) ;
  [] he=0  & pc=1 -> 0.3226837060702875 : (he_est'=-1) & (pc'=2) + 0.3258785942492013 : (he_est'=0) & (pc'=2) + 0.3514376996805112 : (he_est'=1) & (pc'=2) ;
  [] he=1  & pc=1 -> 0.2904191616766467 : (he_est'=-1) & (pc'=2) + 0.38323353293413176 : (he_est'=0) & (pc'=2) + 0.3263473053892216 : (he_est'=1) & (pc'=2) ;

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


// TaxiConfMat
// Prism Looping State Machine
// Generated: 2025-01-10 10:19:40.970541
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
  [] cte=-2  & pc=0 -> 0.21739130434782608 : (cte_est'=-2) & (pc'=1) + 0.17391304347826086 : (cte_est'=-1) & (pc'=1) + 0.20772946859903382 : (cte_est'=0) & (pc'=1) + 0.18357487922705315 : (cte_est'=1) & (pc'=1) + 0.21739130434782608 : (cte_est'=2) & (pc'=1) ;
  [] cte=-1  & pc=0 -> 0.23469387755102042 : (cte_est'=-2) & (pc'=1) + 0.22448979591836735 : (cte_est'=-1) & (pc'=1) + 0.14285714285714285 : (cte_est'=0) & (pc'=1) + 0.23979591836734693 : (cte_est'=1) & (pc'=1) + 0.15816326530612246 : (cte_est'=2) & (pc'=1) ;
  [] cte=0  & pc=0 -> 0.1794871794871795 : (cte_est'=-2) & (pc'=1) + 0.1794871794871795 : (cte_est'=-1) & (pc'=1) + 0.19487179487179487 : (cte_est'=0) & (pc'=1) + 0.2564102564102564 : (cte_est'=1) & (pc'=1) + 0.18974358974358974 : (cte_est'=2) & (pc'=1) ;
  [] cte=1  & pc=0 -> 0.22065727699530516 : (cte_est'=-2) & (pc'=1) + 0.2300469483568075 : (cte_est'=-1) & (pc'=1) + 0.14553990610328638 : (cte_est'=0) & (pc'=1) + 0.17370892018779344 : (cte_est'=1) & (pc'=1) + 0.2300469483568075 : (cte_est'=2) & (pc'=1) ;
  [] cte=2  & pc=0 -> 0.17989417989417988 : (cte_est'=-2) & (pc'=1) + 0.19047619047619047 : (cte_est'=-1) & (pc'=1) + 0.18518518518518517 : (cte_est'=0) & (pc'=1) + 0.14814814814814814 : (cte_est'=1) & (pc'=1) + 0.2962962962962963 : (cte_est'=2) & (pc'=1) ;

  // Perceiver (HE)
  [] he=-1  & pc=1 -> 0.3670886075949367 : (he_est'=-1) & (pc'=2) + 0.2848101265822785 : (he_est'=0) & (pc'=2) + 0.34810126582278483 : (he_est'=1) & (pc'=2) ;
  [] he=0  & pc=1 -> 0.34818941504178275 : (he_est'=-1) & (pc'=2) + 0.3370473537604457 : (he_est'=0) & (pc'=2) + 0.3147632311977716 : (he_est'=1) & (pc'=2) ;
  [] he=1  & pc=1 -> 0.3446153846153846 : (he_est'=-1) & (pc'=2) + 0.32 : (he_est'=0) & (pc'=2) + 0.3353846153846154 : (he_est'=1) & (pc'=2) ;

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

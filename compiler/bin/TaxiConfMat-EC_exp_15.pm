
// TaxiConfMat
// Prism Looping State Machine
// Generated: 2025-01-10 10:23:13.565265
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
  [] cte=-2  & pc=0 -> 0.22535211267605634 : (cte_est'=-2) & (pc'=1) + 0.15023474178403756 : (cte_est'=-1) & (pc'=1) + 0.19248826291079812 : (cte_est'=0) & (pc'=1) + 0.2300469483568075 : (cte_est'=1) & (pc'=1) + 0.20187793427230047 : (cte_est'=2) & (pc'=1) ;
  [] cte=-1  & pc=0 -> 0.1712962962962963 : (cte_est'=-2) & (pc'=1) + 0.23148148148148148 : (cte_est'=-1) & (pc'=1) + 0.2175925925925926 : (cte_est'=0) & (pc'=1) + 0.18518518518518517 : (cte_est'=1) & (pc'=1) + 0.19444444444444445 : (cte_est'=2) & (pc'=1) ;
  [] cte=0  & pc=0 -> 0.20670391061452514 : (cte_est'=-2) & (pc'=1) + 0.25139664804469275 : (cte_est'=-1) & (pc'=1) + 0.1452513966480447 : (cte_est'=0) & (pc'=1) + 0.19553072625698323 : (cte_est'=1) & (pc'=1) + 0.2011173184357542 : (cte_est'=2) & (pc'=1) ;
  [] cte=1  & pc=0 -> 0.23222748815165878 : (cte_est'=-2) & (pc'=1) + 0.22748815165876776 : (cte_est'=-1) & (pc'=1) + 0.1848341232227488 : (cte_est'=0) & (pc'=1) + 0.1895734597156398 : (cte_est'=1) & (pc'=1) + 0.16587677725118483 : (cte_est'=2) & (pc'=1) ;
  [] cte=2  & pc=0 -> 0.15469613259668508 : (cte_est'=-2) & (pc'=1) + 0.16022099447513813 : (cte_est'=-1) & (pc'=1) + 0.287292817679558 : (cte_est'=0) & (pc'=1) + 0.13812154696132597 : (cte_est'=1) & (pc'=1) + 0.2596685082872928 : (cte_est'=2) & (pc'=1) ;

  // Perceiver (HE)
  [] he=-1  & pc=1 -> 0.3595166163141994 : (he_est'=-1) & (pc'=2) + 0.32326283987915405 : (he_est'=0) & (pc'=2) + 0.31722054380664655 : (he_est'=1) & (pc'=2) ;
  [] he=0  & pc=1 -> 0.34036144578313254 : (he_est'=-1) & (pc'=2) + 0.35240963855421686 : (he_est'=0) & (pc'=2) + 0.3072289156626506 : (he_est'=1) & (pc'=2) ;
  [] he=1  & pc=1 -> 0.31750741839762614 : (he_est'=-1) & (pc'=2) + 0.3560830860534125 : (he_est'=0) & (pc'=2) + 0.3264094955489614 : (he_est'=1) & (pc'=2) ;

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

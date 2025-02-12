
// TaxiConfMat
// Prism Looping State Machine
// Generated: 2025-01-10 10:23:28.740949
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
  [] cte=-2  & pc=0 -> 0.22826086956521738 : (cte_est'=-2) & (pc'=1) + 0.1956521739130435 : (cte_est'=-1) & (pc'=1) + 0.14130434782608695 : (cte_est'=0) & (pc'=1) + 0.24456521739130435 : (cte_est'=1) & (pc'=1) + 0.19021739130434784 : (cte_est'=2) & (pc'=1) ;
  [] cte=-1  & pc=0 -> 0.21634615384615385 : (cte_est'=-2) & (pc'=1) + 0.19230769230769232 : (cte_est'=-1) & (pc'=1) + 0.1778846153846154 : (cte_est'=0) & (pc'=1) + 0.20673076923076922 : (cte_est'=1) & (pc'=1) + 0.20673076923076922 : (cte_est'=2) & (pc'=1) ;
  [] cte=0  & pc=0 -> 0.1711229946524064 : (cte_est'=-2) & (pc'=1) + 0.1925133689839572 : (cte_est'=-1) & (pc'=1) + 0.1925133689839572 : (cte_est'=0) & (pc'=1) + 0.24064171122994651 : (cte_est'=1) & (pc'=1) + 0.20320855614973263 : (cte_est'=2) & (pc'=1) ;
  [] cte=1  & pc=0 -> 0.20304568527918782 : (cte_est'=-2) & (pc'=1) + 0.23857868020304568 : (cte_est'=-1) & (pc'=1) + 0.20812182741116753 : (cte_est'=0) & (pc'=1) + 0.15736040609137056 : (cte_est'=1) & (pc'=1) + 0.19289340101522842 : (cte_est'=2) & (pc'=1) ;
  [] cte=2  & pc=0 -> 0.20535714285714285 : (cte_est'=-2) & (pc'=1) + 0.24107142857142858 : (cte_est'=-1) & (pc'=1) + 0.16517857142857142 : (cte_est'=0) & (pc'=1) + 0.20982142857142858 : (cte_est'=1) & (pc'=1) + 0.17857142857142858 : (cte_est'=2) & (pc'=1) ;

  // Perceiver (HE)
  [] he=-1  & pc=1 -> 0.3480825958702065 : (he_est'=-1) & (pc'=2) + 0.32448377581120946 : (he_est'=0) & (pc'=2) + 0.3274336283185841 : (he_est'=1) & (pc'=2) ;
  [] he=0  & pc=1 -> 0.34534534534534533 : (he_est'=-1) & (pc'=2) + 0.37537537537537535 : (he_est'=0) & (pc'=2) + 0.27927927927927926 : (he_est'=1) & (pc'=2) ;
  [] he=1  & pc=1 -> 0.32926829268292684 : (he_est'=-1) & (pc'=2) + 0.3231707317073171 : (he_est'=0) & (pc'=2) + 0.3475609756097561 : (he_est'=1) & (pc'=2) ;

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

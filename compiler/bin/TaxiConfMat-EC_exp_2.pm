
// TaxiConfMat
// Prism Looping State Machine
// Generated: 2025-01-10 10:19:56.167567
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
  [] cte=-2  & pc=0 -> 0.17889908256880735 : (cte_est'=-2) & (pc'=1) + 0.19724770642201836 : (cte_est'=-1) & (pc'=1) + 0.22018348623853212 : (cte_est'=0) & (pc'=1) + 0.23394495412844038 : (cte_est'=1) & (pc'=1) + 0.16972477064220184 : (cte_est'=2) & (pc'=1) ;
  [] cte=-1  & pc=0 -> 0.1793478260869565 : (cte_est'=-2) & (pc'=1) + 0.1956521739130435 : (cte_est'=-1) & (pc'=1) + 0.22282608695652173 : (cte_est'=0) & (pc'=1) + 0.21195652173913043 : (cte_est'=1) & (pc'=1) + 0.19021739130434784 : (cte_est'=2) & (pc'=1) ;
  [] cte=0  & pc=0 -> 0.19047619047619047 : (cte_est'=-2) & (pc'=1) + 0.18095238095238095 : (cte_est'=-1) & (pc'=1) + 0.18571428571428572 : (cte_est'=0) & (pc'=1) + 0.20952380952380953 : (cte_est'=1) & (pc'=1) + 0.23333333333333334 : (cte_est'=2) & (pc'=1) ;
  [] cte=1  & pc=0 -> 0.17801047120418848 : (cte_est'=-2) & (pc'=1) + 0.24607329842931938 : (cte_est'=-1) & (pc'=1) + 0.18848167539267016 : (cte_est'=0) & (pc'=1) + 0.18848167539267016 : (cte_est'=1) & (pc'=1) + 0.19895287958115182 : (cte_est'=2) & (pc'=1) ;
  [] cte=2  & pc=0 -> 0.18781725888324874 : (cte_est'=-2) & (pc'=1) + 0.16243654822335024 : (cte_est'=-1) & (pc'=1) + 0.18781725888324874 : (cte_est'=0) & (pc'=1) + 0.25380710659898476 : (cte_est'=1) & (pc'=1) + 0.20812182741116753 : (cte_est'=2) & (pc'=1) ;

  // Perceiver (HE)
  [] he=-1  & pc=1 -> 0.25903614457831325 : (he_est'=-1) & (pc'=2) + 0.40963855421686746 : (he_est'=0) & (pc'=2) + 0.3313253012048193 : (he_est'=1) & (pc'=2) ;
  [] he=0  & pc=1 -> 0.3450479233226837 : (he_est'=-1) & (pc'=2) + 0.30670926517571884 : (he_est'=0) & (pc'=2) + 0.34824281150159747 : (he_est'=1) & (pc'=2) ;
  [] he=1  & pc=1 -> 0.28450704225352114 : (he_est'=-1) & (pc'=2) + 0.3211267605633803 : (he_est'=0) & (pc'=2) + 0.39436619718309857 : (he_est'=1) & (pc'=2) ;

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

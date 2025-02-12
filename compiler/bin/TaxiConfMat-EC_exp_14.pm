
// TaxiConfMat
// Prism Looping State Machine
// Generated: 2025-01-10 10:22:58.161565
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
  [] cte=-2  & pc=0 -> 0.19111111111111112 : (cte_est'=-2) & (pc'=1) + 0.24444444444444444 : (cte_est'=-1) & (pc'=1) + 0.17333333333333334 : (cte_est'=0) & (pc'=1) + 0.13777777777777778 : (cte_est'=1) & (pc'=1) + 0.25333333333333335 : (cte_est'=2) & (pc'=1) ;
  [] cte=-1  & pc=0 -> 0.24867724867724866 : (cte_est'=-2) & (pc'=1) + 0.20105820105820105 : (cte_est'=-1) & (pc'=1) + 0.20634920634920634 : (cte_est'=0) & (pc'=1) + 0.15343915343915343 : (cte_est'=1) & (pc'=1) + 0.19047619047619047 : (cte_est'=2) & (pc'=1) ;
  [] cte=0  & pc=0 -> 0.20652173913043478 : (cte_est'=-2) & (pc'=1) + 0.10869565217391304 : (cte_est'=-1) & (pc'=1) + 0.20108695652173914 : (cte_est'=0) & (pc'=1) + 0.2391304347826087 : (cte_est'=1) & (pc'=1) + 0.24456521739130435 : (cte_est'=2) & (pc'=1) ;
  [] cte=1  & pc=0 -> 0.21287128712871287 : (cte_est'=-2) & (pc'=1) + 0.19801980198019803 : (cte_est'=-1) & (pc'=1) + 0.12871287128712872 : (cte_est'=0) & (pc'=1) + 0.22277227722772278 : (cte_est'=1) & (pc'=1) + 0.2376237623762376 : (cte_est'=2) & (pc'=1) ;
  [] cte=2  & pc=0 -> 0.185 : (cte_est'=-2) & (pc'=1) + 0.235 : (cte_est'=-1) & (pc'=1) + 0.155 : (cte_est'=0) & (pc'=1) + 0.22 : (cte_est'=1) & (pc'=1) + 0.205 : (cte_est'=2) & (pc'=1) ;

  // Perceiver (HE)
  [] he=-1  & pc=1 -> 0.334375 : (he_est'=-1) & (pc'=2) + 0.353125 : (he_est'=0) & (pc'=2) + 0.3125 : (he_est'=1) & (pc'=2) ;
  [] he=0  & pc=1 -> 0.35919540229885055 : (he_est'=-1) & (pc'=2) + 0.3218390804597701 : (he_est'=0) & (pc'=2) + 0.31896551724137934 : (he_est'=1) & (pc'=2) ;
  [] he=1  & pc=1 -> 0.3855421686746988 : (he_est'=-1) & (pc'=2) + 0.2710843373493976 : (he_est'=0) & (pc'=2) + 0.3433734939759036 : (he_est'=1) & (pc'=2) ;

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

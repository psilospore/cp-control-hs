
// TaxiConfMat
// Prism Looping State Machine
// Generated: 2025-01-10 10:22:12.746415
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
  [] cte=-2  & pc=0 -> 0.1919191919191919 : (cte_est'=-2) & (pc'=1) + 0.22727272727272727 : (cte_est'=-1) & (pc'=1) + 0.18181818181818182 : (cte_est'=0) & (pc'=1) + 0.21212121212121213 : (cte_est'=1) & (pc'=1) + 0.18686868686868688 : (cte_est'=2) & (pc'=1) ;
  [] cte=-1  & pc=0 -> 0.14423076923076922 : (cte_est'=-2) & (pc'=1) + 0.1778846153846154 : (cte_est'=-1) & (pc'=1) + 0.1778846153846154 : (cte_est'=0) & (pc'=1) + 0.1971153846153846 : (cte_est'=1) & (pc'=1) + 0.30288461538461536 : (cte_est'=2) & (pc'=1) ;
  [] cte=0  & pc=0 -> 0.23295454545454544 : (cte_est'=-2) & (pc'=1) + 0.21022727272727273 : (cte_est'=-1) & (pc'=1) + 0.17613636363636365 : (cte_est'=0) & (pc'=1) + 0.16477272727272727 : (cte_est'=1) & (pc'=1) + 0.2159090909090909 : (cte_est'=2) & (pc'=1) ;
  [] cte=1  & pc=0 -> 0.125 : (cte_est'=-2) & (pc'=1) + 0.18055555555555555 : (cte_est'=-1) & (pc'=1) + 0.20833333333333334 : (cte_est'=0) & (pc'=1) + 0.2638888888888889 : (cte_est'=1) & (pc'=1) + 0.2222222222222222 : (cte_est'=2) & (pc'=1) ;
  [] cte=2  & pc=0 -> 0.20297029702970298 : (cte_est'=-2) & (pc'=1) + 0.19801980198019803 : (cte_est'=-1) & (pc'=1) + 0.21287128712871287 : (cte_est'=0) & (pc'=1) + 0.1782178217821782 : (cte_est'=1) & (pc'=1) + 0.2079207920792079 : (cte_est'=2) & (pc'=1) ;

  // Perceiver (HE)
  [] he=-1  & pc=1 -> 0.28 : (he_est'=-1) & (pc'=2) + 0.3507692307692308 : (he_est'=0) & (pc'=2) + 0.36923076923076925 : (he_est'=1) & (pc'=2) ;
  [] he=0  & pc=1 -> 0.3021148036253776 : (he_est'=-1) & (pc'=2) + 0.3474320241691843 : (he_est'=0) & (pc'=2) + 0.3504531722054381 : (he_est'=1) & (pc'=2) ;
  [] he=1  & pc=1 -> 0.32558139534883723 : (he_est'=-1) & (pc'=2) + 0.35174418604651164 : (he_est'=0) & (pc'=2) + 0.3226744186046512 : (he_est'=1) & (pc'=2) ;

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

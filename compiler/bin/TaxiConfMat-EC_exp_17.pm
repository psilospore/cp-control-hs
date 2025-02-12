
// TaxiConfMat
// Prism Looping State Machine
// Generated: 2025-01-10 10:23:44.506588
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
  [] cte=-2  & pc=0 -> 0.2422680412371134 : (cte_est'=-2) & (pc'=1) + 0.17010309278350516 : (cte_est'=-1) & (pc'=1) + 0.1958762886597938 : (cte_est'=0) & (pc'=1) + 0.20103092783505155 : (cte_est'=1) & (pc'=1) + 0.19072164948453607 : (cte_est'=2) & (pc'=1) ;
  [] cte=-1  & pc=0 -> 0.16279069767441862 : (cte_est'=-2) & (pc'=1) + 0.19534883720930232 : (cte_est'=-1) & (pc'=1) + 0.18604651162790697 : (cte_est'=0) & (pc'=1) + 0.2186046511627907 : (cte_est'=1) & (pc'=1) + 0.2372093023255814 : (cte_est'=2) & (pc'=1) ;
  [] cte=0  & pc=0 -> 0.2048780487804878 : (cte_est'=-2) & (pc'=1) + 0.2048780487804878 : (cte_est'=-1) & (pc'=1) + 0.1951219512195122 : (cte_est'=0) & (pc'=1) + 0.1951219512195122 : (cte_est'=1) & (pc'=1) + 0.2 : (cte_est'=2) & (pc'=1) ;
  [] cte=1  & pc=0 -> 0.2660098522167488 : (cte_est'=-2) & (pc'=1) + 0.16748768472906403 : (cte_est'=-1) & (pc'=1) + 0.1921182266009852 : (cte_est'=0) & (pc'=1) + 0.18226600985221675 : (cte_est'=1) & (pc'=1) + 0.1921182266009852 : (cte_est'=2) & (pc'=1) ;
  [] cte=2  & pc=0 -> 0.20218579234972678 : (cte_est'=-2) & (pc'=1) + 0.20765027322404372 : (cte_est'=-1) & (pc'=1) + 0.20218579234972678 : (cte_est'=0) & (pc'=1) + 0.19672131147540983 : (cte_est'=1) & (pc'=1) + 0.1912568306010929 : (cte_est'=2) & (pc'=1) ;

  // Perceiver (HE)
  [] he=-1  & pc=1 -> 0.3153153153153153 : (he_est'=-1) & (pc'=2) + 0.3483483483483483 : (he_est'=0) & (pc'=2) + 0.33633633633633636 : (he_est'=1) & (pc'=2) ;
  [] he=0  & pc=1 -> 0.3862928348909657 : (he_est'=-1) & (pc'=2) + 0.3395638629283489 : (he_est'=0) & (pc'=2) + 0.27414330218068533 : (he_est'=1) & (pc'=2) ;
  [] he=1  & pc=1 -> 0.3439306358381503 : (he_est'=-1) & (pc'=2) + 0.3179190751445087 : (he_est'=0) & (pc'=2) + 0.33815028901734107 : (he_est'=1) & (pc'=2) ;

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

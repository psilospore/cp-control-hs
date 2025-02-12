
// TaxiConfMat
// Prism Looping State Machine
// Generated: 2025-01-10 10:24:01.335685
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
  [] cte=-2  & pc=0 -> 0.14361702127659576 : (cte_est'=-2) & (pc'=1) + 0.2074468085106383 : (cte_est'=-1) & (pc'=1) + 0.16489361702127658 : (cte_est'=0) & (pc'=1) + 0.24468085106382978 : (cte_est'=1) & (pc'=1) + 0.2393617021276596 : (cte_est'=2) & (pc'=1) ;
  [] cte=-1  & pc=0 -> 0.22641509433962265 : (cte_est'=-2) & (pc'=1) + 0.25943396226415094 : (cte_est'=-1) & (pc'=1) + 0.16981132075471697 : (cte_est'=0) & (pc'=1) + 0.14150943396226415 : (cte_est'=1) & (pc'=1) + 0.2028301886792453 : (cte_est'=2) & (pc'=1) ;
  [] cte=0  & pc=0 -> 0.25757575757575757 : (cte_est'=-2) & (pc'=1) + 0.2222222222222222 : (cte_est'=-1) & (pc'=1) + 0.20707070707070707 : (cte_est'=0) & (pc'=1) + 0.15151515151515152 : (cte_est'=1) & (pc'=1) + 0.16161616161616163 : (cte_est'=2) & (pc'=1) ;
  [] cte=1  & pc=0 -> 0.1990521327014218 : (cte_est'=-2) & (pc'=1) + 0.23696682464454977 : (cte_est'=-1) & (pc'=1) + 0.1895734597156398 : (cte_est'=0) & (pc'=1) + 0.18009478672985782 : (cte_est'=1) & (pc'=1) + 0.1943127962085308 : (cte_est'=2) & (pc'=1) ;
  [] cte=2  & pc=0 -> 0.19895287958115182 : (cte_est'=-2) & (pc'=1) + 0.23036649214659685 : (cte_est'=-1) & (pc'=1) + 0.17277486910994763 : (cte_est'=0) & (pc'=1) + 0.18324607329842932 : (cte_est'=1) & (pc'=1) + 0.21465968586387435 : (cte_est'=2) & (pc'=1) ;

  // Perceiver (HE)
  [] he=-1  & pc=1 -> 0.3293768545994065 : (he_est'=-1) & (pc'=2) + 0.34421364985163205 : (he_est'=0) & (pc'=2) + 0.3264094955489614 : (he_est'=1) & (pc'=2) ;
  [] he=0  & pc=1 -> 0.3056379821958457 : (he_est'=-1) & (pc'=2) + 0.35311572700296734 : (he_est'=0) & (pc'=2) + 0.34124629080118696 : (he_est'=1) & (pc'=2) ;
  [] he=1  & pc=1 -> 0.34049079754601225 : (he_est'=-1) & (pc'=2) + 0.31901840490797545 : (he_est'=0) & (pc'=2) + 0.34049079754601225 : (he_est'=1) & (pc'=2) ;

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

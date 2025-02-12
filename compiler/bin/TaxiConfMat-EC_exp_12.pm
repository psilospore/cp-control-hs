
// TaxiConfMat
// Prism Looping State Machine
// Generated: 2025-01-10 10:22:27.915007
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
  [] cte=-2  & pc=0 -> 0.23880597014925373 : (cte_est'=-2) & (pc'=1) + 0.23880597014925373 : (cte_est'=-1) & (pc'=1) + 0.18407960199004975 : (cte_est'=0) & (pc'=1) + 0.19402985074626866 : (cte_est'=1) & (pc'=1) + 0.14427860696517414 : (cte_est'=2) & (pc'=1) ;
  [] cte=-1  & pc=0 -> 0.2756756756756757 : (cte_est'=-2) & (pc'=1) + 0.22162162162162163 : (cte_est'=-1) & (pc'=1) + 0.17297297297297298 : (cte_est'=0) & (pc'=1) + 0.16756756756756758 : (cte_est'=1) & (pc'=1) + 0.16216216216216217 : (cte_est'=2) & (pc'=1) ;
  [] cte=0  & pc=0 -> 0.14705882352941177 : (cte_est'=-2) & (pc'=1) + 0.19607843137254902 : (cte_est'=-1) & (pc'=1) + 0.23039215686274508 : (cte_est'=0) & (pc'=1) + 0.22549019607843138 : (cte_est'=1) & (pc'=1) + 0.20098039215686275 : (cte_est'=2) & (pc'=1) ;
  [] cte=1  & pc=0 -> 0.205607476635514 : (cte_est'=-2) & (pc'=1) + 0.2336448598130841 : (cte_est'=-1) & (pc'=1) + 0.14485981308411214 : (cte_est'=0) & (pc'=1) + 0.2383177570093458 : (cte_est'=1) & (pc'=1) + 0.17757009345794392 : (cte_est'=2) & (pc'=1) ;
  [] cte=2  & pc=0 -> 0.22959183673469388 : (cte_est'=-2) & (pc'=1) + 0.15306122448979592 : (cte_est'=-1) & (pc'=1) + 0.23469387755102042 : (cte_est'=0) & (pc'=1) + 0.19387755102040816 : (cte_est'=1) & (pc'=1) + 0.18877551020408162 : (cte_est'=2) & (pc'=1) ;

  // Perceiver (HE)
  [] he=-1  & pc=1 -> 0.3123123123123123 : (he_est'=-1) & (pc'=2) + 0.34534534534534533 : (he_est'=0) & (pc'=2) + 0.34234234234234234 : (he_est'=1) & (pc'=2) ;
  [] he=0  & pc=1 -> 0.34870317002881845 : (he_est'=-1) & (pc'=2) + 0.3227665706051873 : (he_est'=0) & (pc'=2) + 0.3285302593659942 : (he_est'=1) & (pc'=2) ;
  [] he=1  & pc=1 -> 0.34375 : (he_est'=-1) & (pc'=2) + 0.359375 : (he_est'=0) & (pc'=2) + 0.296875 : (he_est'=1) & (pc'=2) ;

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

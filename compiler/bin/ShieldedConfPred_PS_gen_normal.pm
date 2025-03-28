
// Prism Looping State Machine

// ShieldedConfPred PS_gen_normal
// --conf_pred_cte lib/cte_confpred_gen_normal.csv
// --conf_pred_he lib/he_confpred_gen_normal.csv
// --tempest_pred lib/temp_extr_dir.csv
// --action_filter 0.3

// PC values:
//   0 : Perceiver (CTE)
//   1 : Perceiver (HE)
//   2 : Controller
//   3 : Dynamics
//   4 : Loop Logic
//   -1 : dyn_fail

// Generated: 2025-03-14 14:00:19.849312

mdp

const N;

module ShieldedConfPred

  cte : [-1..4] init 0;
  he : [-1..2] init 0;
  a : [0..2] init 0;
  alpha : [0..N] init 0; // Counts number of times controller found no safe actions
  cte_est0 : [0..1] init 0;
  cte_est1 : [0..1] init 0;
  cte_est2 : [0..1] init 0;
  cte_est3 : [0..1] init 0;
  cte_est4 : [0..1] init 0;
  he_est0 : [0..1] init 0;
  he_est1 : [0..1] init 0;
  he_est2 : [0..1] init 0;
  pc : [-1..4] init 0; // program counter
  k : [0..N] init 1; // loop counter


  // Perceiver (CTE)
  [] cte=0 & pc=0 -> 0.00015 : (cte_est0'=0) & (cte_est1'=0) & (cte_est2'=1) & (cte_est3'=0) & (cte_est4'=0) & (pc'=1) + 5e-05 : (cte_est0'=0) & (cte_est1'=0) & (cte_est2'=1) & (cte_est3'=1) & (cte_est4'=0) & (pc'=1) + 0.00015 : (cte_est0'=0) & (cte_est1'=1) & (cte_est2'=0) & (cte_est3'=0) & (cte_est4'=0) & (pc'=1) + 0.0028 : (cte_est0'=0) & (cte_est1'=1) & (cte_est2'=1) & (cte_est3'=0) & (cte_est4'=0) & (pc'=1) + 0.0002 : (cte_est0'=0) & (cte_est1'=1) & (cte_est2'=1) & (cte_est3'=0) & (cte_est4'=1) & (pc'=1) + 5e-05 : (cte_est0'=0) & (cte_est1'=1) & (cte_est2'=1) & (cte_est3'=1) & (cte_est4'=0) & (pc'=1) + 0.14595 : (cte_est0'=1) & (cte_est1'=0) & (cte_est2'=0) & (cte_est3'=0) & (cte_est4'=0) & (pc'=1) + 0.001 : (cte_est0'=1) & (cte_est1'=0) & (cte_est2'=0) & (cte_est3'=0) & (cte_est4'=1) & (pc'=1) + 0.00105 : (cte_est0'=1) & (cte_est1'=0) & (cte_est2'=0) & (cte_est3'=1) & (cte_est4'=0) & (pc'=1) + 0.2695 : (cte_est0'=1) & (cte_est1'=0) & (cte_est2'=1) & (cte_est3'=0) & (cte_est4'=0) & (pc'=1) + 0.00175 : (cte_est0'=1) & (cte_est1'=0) & (cte_est2'=1) & (cte_est3'=0) & (cte_est4'=1) & (pc'=1) + 0.0015 : (cte_est0'=1) & (cte_est1'=0) & (cte_est2'=1) & (cte_est3'=1) & (cte_est4'=0) & (pc'=1) + 0.27185 : (cte_est0'=1) & (cte_est1'=1) & (cte_est2'=0) & (cte_est3'=0) & (cte_est4'=0) & (pc'=1) + 0.00225 : (cte_est0'=1) & (cte_est1'=1) & (cte_est2'=0) & (cte_est3'=0) & (cte_est4'=1) & (pc'=1) + 0.00155 : (cte_est0'=1) & (cte_est1'=1) & (cte_est2'=0) & (cte_est3'=1) & (cte_est4'=0) & (pc'=1) + 0.2974 : (cte_est0'=1) & (cte_est1'=1) & (cte_est2'=1) & (cte_est3'=0) & (cte_est4'=0) & (pc'=1) + 0.0015 : (cte_est0'=1) & (cte_est1'=1) & (cte_est2'=1) & (cte_est3'=0) & (cte_est4'=1) & (pc'=1) + 0.0013 : (cte_est0'=1) & (cte_est1'=1) & (cte_est2'=1) & (cte_est3'=1) & (cte_est4'=0) & (pc'=1) ;
  [] cte=1 & pc=0 -> 5e-05 : (cte_est0'=0) & (cte_est1'=0) & (cte_est2'=0) & (cte_est3'=1) & (cte_est4'=0) & (pc'=1) + 0.15375 : (cte_est0'=0) & (cte_est1'=1) & (cte_est2'=0) & (cte_est3'=0) & (cte_est4'=0) & (pc'=1) + 0.2709 : (cte_est0'=0) & (cte_est1'=1) & (cte_est2'=0) & (cte_est3'=1) & (cte_est4'=0) & (pc'=1) + 0.00165 : (cte_est0'=0) & (cte_est1'=1) & (cte_est2'=1) & (cte_est3'=0) & (cte_est4'=0) & (pc'=1) + 0.00205 : (cte_est0'=0) & (cte_est1'=1) & (cte_est2'=1) & (cte_est3'=1) & (cte_est4'=0) & (pc'=1) + 5e-05 : (cte_est0'=1) & (cte_est1'=0) & (cte_est2'=0) & (cte_est3'=0) & (cte_est4'=0) & (pc'=1) + 0.0031 : (cte_est0'=1) & (cte_est1'=0) & (cte_est2'=0) & (cte_est3'=1) & (cte_est4'=0) & (pc'=1) + 5e-05 : (cte_est0'=1) & (cte_est1'=0) & (cte_est2'=1) & (cte_est3'=1) & (cte_est4'=0) & (pc'=1) + 0.2693 : (cte_est0'=1) & (cte_est1'=1) & (cte_est2'=0) & (cte_est3'=0) & (cte_est4'=0) & (pc'=1) + 0.296 : (cte_est0'=1) & (cte_est1'=1) & (cte_est2'=0) & (cte_est3'=1) & (cte_est4'=0) & (pc'=1) + 0.0016 : (cte_est0'=1) & (cte_est1'=1) & (cte_est2'=1) & (cte_est3'=0) & (cte_est4'=0) & (pc'=1) + 0.0015 : (cte_est0'=1) & (cte_est1'=1) & (cte_est2'=1) & (cte_est3'=1) & (cte_est4'=0) & (pc'=1) ;
  [] cte=2 & pc=0 -> 5e-05 : (cte_est0'=0) & (cte_est1'=0) & (cte_est2'=0) & (cte_est3'=0) & (cte_est4'=1) & (pc'=1) + 0.15165 : (cte_est0'=0) & (cte_est1'=0) & (cte_est2'=1) & (cte_est3'=0) & (cte_est4'=0) & (pc'=1) + 0.2678 : (cte_est0'=0) & (cte_est1'=0) & (cte_est2'=1) & (cte_est3'=0) & (cte_est4'=1) & (pc'=1) + 0.0013 : (cte_est0'=0) & (cte_est1'=1) & (cte_est2'=1) & (cte_est3'=0) & (cte_est4'=0) & (pc'=1) + 0.0023 : (cte_est0'=0) & (cte_est1'=1) & (cte_est2'=1) & (cte_est3'=0) & (cte_est4'=1) & (pc'=1) + 0.0001 : (cte_est0'=1) & (cte_est1'=0) & (cte_est2'=0) & (cte_est3'=0) & (cte_est4'=0) & (pc'=1) + 0.00315 : (cte_est0'=1) & (cte_est1'=0) & (cte_est2'=0) & (cte_est3'=0) & (cte_est4'=1) & (pc'=1) + 0.2716 : (cte_est0'=1) & (cte_est1'=0) & (cte_est2'=1) & (cte_est3'=0) & (cte_est4'=0) & (pc'=1) + 0.2982 : (cte_est0'=1) & (cte_est1'=0) & (cte_est2'=1) & (cte_est3'=0) & (cte_est4'=1) & (pc'=1) + 5e-05 : (cte_est0'=1) & (cte_est1'=1) & (cte_est2'=0) & (cte_est3'=0) & (cte_est4'=1) & (pc'=1) + 0.00245 : (cte_est0'=1) & (cte_est1'=1) & (cte_est2'=1) & (cte_est3'=0) & (cte_est4'=0) & (pc'=1) + 0.00135 : (cte_est0'=1) & (cte_est1'=1) & (cte_est2'=1) & (cte_est3'=0) & (cte_est4'=1) & (pc'=1) ;
  [] cte=3 & pc=0 -> 5e-05 : (cte_est0'=0) & (cte_est1'=0) & (cte_est2'=0) & (cte_est3'=0) & (cte_est4'=0) & (pc'=1) + 0.4179 : (cte_est0'=0) & (cte_est1'=0) & (cte_est2'=0) & (cte_est3'=1) & (cte_est4'=0) & (pc'=1) + 0.0028 : (cte_est0'=0) & (cte_est1'=1) & (cte_est2'=0) & (cte_est3'=0) & (cte_est4'=0) & (pc'=1) + 0.5726 : (cte_est0'=0) & (cte_est1'=1) & (cte_est2'=0) & (cte_est3'=1) & (cte_est4'=0) & (pc'=1) + 5e-05 : (cte_est0'=1) & (cte_est1'=0) & (cte_est2'=0) & (cte_est3'=0) & (cte_est4'=0) & (pc'=1) + 0.00285 : (cte_est0'=1) & (cte_est1'=0) & (cte_est2'=0) & (cte_est3'=1) & (cte_est4'=0) & (pc'=1) + 5e-05 : (cte_est0'=1) & (cte_est1'=1) & (cte_est2'=0) & (cte_est3'=0) & (cte_est4'=0) & (pc'=1) + 0.0037 : (cte_est0'=1) & (cte_est1'=1) & (cte_est2'=0) & (cte_est3'=1) & (cte_est4'=0) & (pc'=1) ;
  [] cte=4 & pc=0 -> 0.00015 : (cte_est0'=0) & (cte_est1'=0) & (cte_est2'=0) & (cte_est3'=0) & (cte_est4'=0) & (pc'=1) + 0.42675 : (cte_est0'=0) & (cte_est1'=0) & (cte_est2'=0) & (cte_est3'=0) & (cte_est4'=1) & (pc'=1) + 0.00305 : (cte_est0'=0) & (cte_est1'=0) & (cte_est2'=1) & (cte_est3'=0) & (cte_est4'=0) & (pc'=1) + 0.5637 : (cte_est0'=0) & (cte_est1'=0) & (cte_est2'=1) & (cte_est3'=0) & (cte_est4'=1) & (pc'=1) + 0.00295 : (cte_est0'=1) & (cte_est1'=0) & (cte_est2'=0) & (cte_est3'=0) & (cte_est4'=1) & (pc'=1) + 0.0001 : (cte_est0'=1) & (cte_est1'=0) & (cte_est2'=1) & (cte_est3'=0) & (cte_est4'=0) & (pc'=1) + 0.0033 : (cte_est0'=1) & (cte_est1'=0) & (cte_est2'=1) & (cte_est3'=0) & (cte_est4'=1) & (pc'=1) ;

  // Perceiver (HE)
  [] he=0 & pc=1 -> 0.00425 : (he_est0'=0) & (he_est1'=0) & (he_est2'=1) & (pc'=2) + 0.00435 : (he_est0'=0) & (he_est1'=1) & (he_est2'=0) & (pc'=2) + 0.0239 : (he_est0'=0) & (he_est1'=1) & (he_est2'=1) & (pc'=2) + 0.32355 : (he_est0'=1) & (he_est1'=0) & (he_est2'=0) & (pc'=2) + 0.26825 : (he_est0'=1) & (he_est1'=0) & (he_est2'=1) & (pc'=2) + 0.2753 : (he_est0'=1) & (he_est1'=1) & (he_est2'=0) & (pc'=2) + 0.1004 : (he_est0'=1) & (he_est1'=1) & (he_est2'=1) & (pc'=2) ;
  [] he=1 & pc=1 -> 0.00405 : (he_est0'=0) & (he_est1'=0) & (he_est2'=0) & (pc'=2) + 0.0001 : (he_est0'=0) & (he_est1'=0) & (he_est2'=1) & (pc'=2) + 0.59305 : (he_est0'=0) & (he_est1'=1) & (he_est2'=0) & (pc'=2) + 0.00265 : (he_est0'=0) & (he_est1'=1) & (he_est2'=1) & (pc'=2) + 0.0295 : (he_est0'=1) & (he_est1'=0) & (he_est2'=0) & (pc'=2) + 0.00015 : (he_est0'=1) & (he_est1'=0) & (he_est2'=1) & (pc'=2) + 0.36985 : (he_est0'=1) & (he_est1'=1) & (he_est2'=0) & (pc'=2) + 0.00065 : (he_est0'=1) & (he_est1'=1) & (he_est2'=1) & (pc'=2) ;
  [] he=2 & pc=1 -> 0.0046 : (he_est0'=0) & (he_est1'=0) & (he_est2'=0) & (pc'=2) + 0.59315 : (he_est0'=0) & (he_est1'=0) & (he_est2'=1) & (pc'=2) + 0.00015 : (he_est0'=0) & (he_est1'=1) & (he_est2'=0) & (pc'=2) + 0.00305 : (he_est0'=0) & (he_est1'=1) & (he_est2'=1) & (pc'=2) + 0.02785 : (he_est0'=1) & (he_est1'=0) & (he_est2'=0) & (pc'=2) + 0.3698 : (he_est0'=1) & (he_est1'=0) & (he_est2'=1) & (pc'=2) + 0.00025 : (he_est0'=1) & (he_est1'=1) & (he_est2'=0) & (pc'=2) + 0.00115 : (he_est0'=1) & (he_est1'=1) & (he_est2'=1) & (pc'=2) ;

  // Controller
  [] cte_est0=0 & cte_est1=0 & cte_est2=0 & cte_est3=0 & cte_est4=1 & he_est0=0 & he_est1=0 & he_est2=1 & pc=2 -> (a'=1) & (pc'=3) ;
  [] cte_est0=0 & cte_est1=0 & cte_est2=0 & cte_est3=0 & cte_est4=1 & he_est0=0 & he_est1=1 & he_est2=0 & pc=2 -> (a'=0) & (pc'=3) ;
  [] cte_est0=0 & cte_est1=0 & cte_est2=0 & cte_est3=0 & cte_est4=1 & he_est0=0 & he_est1=1 & he_est2=0 & pc=2 -> (a'=2) & (pc'=3) ;
  [] cte_est0=0 & cte_est1=0 & cte_est2=0 & cte_est3=0 & cte_est4=1 & he_est0=0 & he_est1=1 & he_est2=1 & pc=2 -> (a'=0) & (alpha'=alpha+1) & (pc'=3) ;
  [] cte_est0=0 & cte_est1=0 & cte_est2=0 & cte_est3=0 & cte_est4=1 & he_est0=1 & he_est1=0 & he_est2=0 & pc=2 -> (a'=0) & (pc'=3) ;
  [] cte_est0=0 & cte_est1=0 & cte_est2=0 & cte_est3=0 & cte_est4=1 & he_est0=1 & he_est1=0 & he_est2=0 & pc=2 -> (a'=1) & (pc'=3) ;
  [] cte_est0=0 & cte_est1=0 & cte_est2=0 & cte_est3=0 & cte_est4=1 & he_est0=1 & he_est1=0 & he_est2=1 & pc=2 -> (a'=1) & (pc'=3) ;
  [] cte_est0=0 & cte_est1=0 & cte_est2=0 & cte_est3=0 & cte_est4=1 & he_est0=1 & he_est1=1 & he_est2=0 & pc=2 -> (a'=0) & (pc'=3) ;
  [] cte_est0=0 & cte_est1=0 & cte_est2=0 & cte_est3=0 & cte_est4=1 & he_est0=1 & he_est1=1 & he_est2=1 & pc=2 -> (a'=0) & (alpha'=alpha+1) & (pc'=3) ;
  [] cte_est0=0 & cte_est1=0 & cte_est2=0 & cte_est3=1 & cte_est4=0 & he_est0=0 & he_est1=0 & he_est2=1 & pc=2 -> (a'=0) & (pc'=3) ;
  [] cte_est0=0 & cte_est1=0 & cte_est2=0 & cte_est3=1 & cte_est4=0 & he_est0=0 & he_est1=0 & he_est2=1 & pc=2 -> (a'=1) & (pc'=3) ;
  [] cte_est0=0 & cte_est1=0 & cte_est2=0 & cte_est3=1 & cte_est4=0 & he_est0=0 & he_est1=1 & he_est2=0 & pc=2 -> (a'=2) & (pc'=3) ;
  [] cte_est0=0 & cte_est1=0 & cte_est2=0 & cte_est3=1 & cte_est4=0 & he_est0=0 & he_est1=1 & he_est2=1 & pc=2 -> (a'=0) & (alpha'=alpha+1) & (pc'=3) ;
  [] cte_est0=0 & cte_est1=0 & cte_est2=0 & cte_est3=1 & cte_est4=0 & he_est0=1 & he_est1=0 & he_est2=0 & pc=2 -> (a'=0) & (pc'=3) ;
  [] cte_est0=0 & cte_est1=0 & cte_est2=0 & cte_est3=1 & cte_est4=0 & he_est0=1 & he_est1=0 & he_est2=0 & pc=2 -> (a'=2) & (pc'=3) ;
  [] cte_est0=0 & cte_est1=0 & cte_est2=0 & cte_est3=1 & cte_est4=0 & he_est0=1 & he_est1=0 & he_est2=1 & pc=2 -> (a'=0) & (pc'=3) ;
  [] cte_est0=0 & cte_est1=0 & cte_est2=0 & cte_est3=1 & cte_est4=0 & he_est0=1 & he_est1=1 & he_est2=0 & pc=2 -> (a'=2) & (pc'=3) ;
  [] cte_est0=0 & cte_est1=0 & cte_est2=0 & cte_est3=1 & cte_est4=0 & he_est0=1 & he_est1=1 & he_est2=1 & pc=2 -> (a'=0) & (alpha'=alpha+1) & (pc'=3) ;
  [] cte_est0=0 & cte_est1=0 & cte_est2=0 & cte_est3=1 & cte_est4=1 & he_est0=0 & he_est1=0 & he_est2=1 & pc=2 -> (a'=1) & (pc'=3) ;
  [] cte_est0=0 & cte_est1=0 & cte_est2=0 & cte_est3=1 & cte_est4=1 & he_est0=0 & he_est1=1 & he_est2=0 & pc=2 -> (a'=2) & (pc'=3) ;
  [] cte_est0=0 & cte_est1=0 & cte_est2=0 & cte_est3=1 & cte_est4=1 & he_est0=0 & he_est1=1 & he_est2=1 & pc=2 -> (a'=0) & (alpha'=alpha+1) & (pc'=3) ;
  [] cte_est0=0 & cte_est1=0 & cte_est2=0 & cte_est3=1 & cte_est4=1 & he_est0=1 & he_est1=0 & he_est2=0 & pc=2 -> (a'=0) & (pc'=3) ;
  [] cte_est0=0 & cte_est1=0 & cte_est2=0 & cte_est3=1 & cte_est4=1 & he_est0=1 & he_est1=0 & he_est2=1 & pc=2 -> (a'=0) & (alpha'=alpha+1) & (pc'=3) ;
  [] cte_est0=0 & cte_est1=0 & cte_est2=0 & cte_est3=1 & cte_est4=1 & he_est0=1 & he_est1=1 & he_est2=0 & pc=2 -> (a'=0) & (alpha'=alpha+1) & (pc'=3) ;
  [] cte_est0=0 & cte_est1=0 & cte_est2=0 & cte_est3=1 & cte_est4=1 & he_est0=1 & he_est1=1 & he_est2=1 & pc=2 -> (a'=0) & (alpha'=alpha+1) & (pc'=3) ;
  [] cte_est0=0 & cte_est1=0 & cte_est2=1 & cte_est3=0 & cte_est4=0 & he_est0=0 & he_est1=0 & he_est2=1 & pc=2 -> (a'=0) & (pc'=3) ;
  [] cte_est0=0 & cte_est1=0 & cte_est2=1 & cte_est3=0 & cte_est4=0 & he_est0=0 & he_est1=0 & he_est2=1 & pc=2 -> (a'=1) & (pc'=3) ;
  [] cte_est0=0 & cte_est1=0 & cte_est2=1 & cte_est3=0 & cte_est4=0 & he_est0=0 & he_est1=1 & he_est2=0 & pc=2 -> (a'=0) & (pc'=3) ;
  [] cte_est0=0 & cte_est1=0 & cte_est2=1 & cte_est3=0 & cte_est4=0 & he_est0=0 & he_est1=1 & he_est2=0 & pc=2 -> (a'=2) & (pc'=3) ;
  [] cte_est0=0 & cte_est1=0 & cte_est2=1 & cte_est3=0 & cte_est4=0 & he_est0=0 & he_est1=1 & he_est2=1 & pc=2 -> (a'=0) & (pc'=3) ;
  [] cte_est0=0 & cte_est1=0 & cte_est2=1 & cte_est3=0 & cte_est4=0 & he_est0=1 & he_est1=0 & he_est2=0 & pc=2 -> (a'=0) & (pc'=3) ;
  [] cte_est0=0 & cte_est1=0 & cte_est2=1 & cte_est3=0 & cte_est4=0 & he_est0=1 & he_est1=0 & he_est2=0 & pc=2 -> (a'=1) & (pc'=3) ;
  [] cte_est0=0 & cte_est1=0 & cte_est2=1 & cte_est3=0 & cte_est4=0 & he_est0=1 & he_est1=0 & he_est2=0 & pc=2 -> (a'=2) & (pc'=3) ;
  [] cte_est0=0 & cte_est1=0 & cte_est2=1 & cte_est3=0 & cte_est4=0 & he_est0=1 & he_est1=0 & he_est2=1 & pc=2 -> (a'=0) & (pc'=3) ;
  [] cte_est0=0 & cte_est1=0 & cte_est2=1 & cte_est3=0 & cte_est4=0 & he_est0=1 & he_est1=0 & he_est2=1 & pc=2 -> (a'=1) & (pc'=3) ;
  [] cte_est0=0 & cte_est1=0 & cte_est2=1 & cte_est3=0 & cte_est4=0 & he_est0=1 & he_est1=1 & he_est2=0 & pc=2 -> (a'=0) & (pc'=3) ;
  [] cte_est0=0 & cte_est1=0 & cte_est2=1 & cte_est3=0 & cte_est4=0 & he_est0=1 & he_est1=1 & he_est2=0 & pc=2 -> (a'=2) & (pc'=3) ;
  [] cte_est0=0 & cte_est1=0 & cte_est2=1 & cte_est3=0 & cte_est4=0 & he_est0=1 & he_est1=1 & he_est2=1 & pc=2 -> (a'=0) & (pc'=3) ;
  [] cte_est0=0 & cte_est1=0 & cte_est2=1 & cte_est3=0 & cte_est4=1 & he_est0=0 & he_est1=0 & he_est2=1 & pc=2 -> (a'=1) & (pc'=3) ;
  [] cte_est0=0 & cte_est1=0 & cte_est2=1 & cte_est3=0 & cte_est4=1 & he_est0=0 & he_est1=1 & he_est2=0 & pc=2 -> (a'=0) & (pc'=3) ;
  [] cte_est0=0 & cte_est1=0 & cte_est2=1 & cte_est3=0 & cte_est4=1 & he_est0=0 & he_est1=1 & he_est2=0 & pc=2 -> (a'=2) & (pc'=3) ;
  [] cte_est0=0 & cte_est1=0 & cte_est2=1 & cte_est3=0 & cte_est4=1 & he_est0=0 & he_est1=1 & he_est2=1 & pc=2 -> (a'=0) & (alpha'=alpha+1) & (pc'=3) ;
  [] cte_est0=0 & cte_est1=0 & cte_est2=1 & cte_est3=0 & cte_est4=1 & he_est0=1 & he_est1=0 & he_est2=0 & pc=2 -> (a'=0) & (pc'=3) ;
  [] cte_est0=0 & cte_est1=0 & cte_est2=1 & cte_est3=0 & cte_est4=1 & he_est0=1 & he_est1=0 & he_est2=0 & pc=2 -> (a'=1) & (pc'=3) ;
  [] cte_est0=0 & cte_est1=0 & cte_est2=1 & cte_est3=0 & cte_est4=1 & he_est0=1 & he_est1=0 & he_est2=1 & pc=2 -> (a'=1) & (pc'=3) ;
  [] cte_est0=0 & cte_est1=0 & cte_est2=1 & cte_est3=0 & cte_est4=1 & he_est0=1 & he_est1=1 & he_est2=0 & pc=2 -> (a'=0) & (pc'=3) ;
  [] cte_est0=0 & cte_est1=0 & cte_est2=1 & cte_est3=0 & cte_est4=1 & he_est0=1 & he_est1=1 & he_est2=1 & pc=2 -> (a'=0) & (alpha'=alpha+1) & (pc'=3) ;
  [] cte_est0=0 & cte_est1=0 & cte_est2=1 & cte_est3=1 & cte_est4=0 & he_est0=0 & he_est1=0 & he_est2=1 & pc=2 -> (a'=0) & (pc'=3) ;
  [] cte_est0=0 & cte_est1=0 & cte_est2=1 & cte_est3=1 & cte_est4=0 & he_est0=0 & he_est1=0 & he_est2=1 & pc=2 -> (a'=1) & (pc'=3) ;
  [] cte_est0=0 & cte_est1=0 & cte_est2=1 & cte_est3=1 & cte_est4=0 & he_est0=0 & he_est1=1 & he_est2=0 & pc=2 -> (a'=2) & (pc'=3) ;
  [] cte_est0=0 & cte_est1=0 & cte_est2=1 & cte_est3=1 & cte_est4=0 & he_est0=0 & he_est1=1 & he_est2=1 & pc=2 -> (a'=0) & (alpha'=alpha+1) & (pc'=3) ;
  [] cte_est0=0 & cte_est1=0 & cte_est2=1 & cte_est3=1 & cte_est4=0 & he_est0=1 & he_est1=0 & he_est2=0 & pc=2 -> (a'=0) & (pc'=3) ;
  [] cte_est0=0 & cte_est1=0 & cte_est2=1 & cte_est3=1 & cte_est4=0 & he_est0=1 & he_est1=0 & he_est2=0 & pc=2 -> (a'=2) & (pc'=3) ;
  [] cte_est0=0 & cte_est1=0 & cte_est2=1 & cte_est3=1 & cte_est4=0 & he_est0=1 & he_est1=0 & he_est2=1 & pc=2 -> (a'=0) & (pc'=3) ;
  [] cte_est0=0 & cte_est1=0 & cte_est2=1 & cte_est3=1 & cte_est4=0 & he_est0=1 & he_est1=1 & he_est2=0 & pc=2 -> (a'=2) & (pc'=3) ;
  [] cte_est0=0 & cte_est1=0 & cte_est2=1 & cte_est3=1 & cte_est4=0 & he_est0=1 & he_est1=1 & he_est2=1 & pc=2 -> (a'=0) & (alpha'=alpha+1) & (pc'=3) ;
  [] cte_est0=0 & cte_est1=0 & cte_est2=1 & cte_est3=1 & cte_est4=1 & he_est0=0 & he_est1=0 & he_est2=1 & pc=2 -> (a'=1) & (pc'=3) ;
  [] cte_est0=0 & cte_est1=0 & cte_est2=1 & cte_est3=1 & cte_est4=1 & he_est0=0 & he_est1=1 & he_est2=0 & pc=2 -> (a'=2) & (pc'=3) ;
  [] cte_est0=0 & cte_est1=0 & cte_est2=1 & cte_est3=1 & cte_est4=1 & he_est0=0 & he_est1=1 & he_est2=1 & pc=2 -> (a'=0) & (alpha'=alpha+1) & (pc'=3) ;
  [] cte_est0=0 & cte_est1=0 & cte_est2=1 & cte_est3=1 & cte_est4=1 & he_est0=1 & he_est1=0 & he_est2=0 & pc=2 -> (a'=0) & (pc'=3) ;
  [] cte_est0=0 & cte_est1=0 & cte_est2=1 & cte_est3=1 & cte_est4=1 & he_est0=1 & he_est1=0 & he_est2=1 & pc=2 -> (a'=0) & (alpha'=alpha+1) & (pc'=3) ;
  [] cte_est0=0 & cte_est1=0 & cte_est2=1 & cte_est3=1 & cte_est4=1 & he_est0=1 & he_est1=1 & he_est2=0 & pc=2 -> (a'=0) & (alpha'=alpha+1) & (pc'=3) ;
  [] cte_est0=0 & cte_est1=0 & cte_est2=1 & cte_est3=1 & cte_est4=1 & he_est0=1 & he_est1=1 & he_est2=1 & pc=2 -> (a'=0) & (alpha'=alpha+1) & (pc'=3) ;
  [] cte_est0=0 & cte_est1=1 & cte_est2=0 & cte_est3=0 & cte_est4=0 & he_est0=0 & he_est1=0 & he_est2=1 & pc=2 -> (a'=0) & (pc'=3) ;
  [] cte_est0=0 & cte_est1=1 & cte_est2=0 & cte_est3=0 & cte_est4=0 & he_est0=0 & he_est1=0 & he_est2=1 & pc=2 -> (a'=1) & (pc'=3) ;
  [] cte_est0=0 & cte_est1=1 & cte_est2=0 & cte_est3=0 & cte_est4=0 & he_est0=0 & he_est1=1 & he_est2=0 & pc=2 -> (a'=0) & (pc'=3) ;
  [] cte_est0=0 & cte_est1=1 & cte_est2=0 & cte_est3=0 & cte_est4=0 & he_est0=0 & he_est1=1 & he_est2=0 & pc=2 -> (a'=2) & (pc'=3) ;
  [] cte_est0=0 & cte_est1=1 & cte_est2=0 & cte_est3=0 & cte_est4=0 & he_est0=0 & he_est1=1 & he_est2=1 & pc=2 -> (a'=0) & (pc'=3) ;
  [] cte_est0=0 & cte_est1=1 & cte_est2=0 & cte_est3=0 & cte_est4=0 & he_est0=1 & he_est1=0 & he_est2=0 & pc=2 -> (a'=0) & (pc'=3) ;
  [] cte_est0=0 & cte_est1=1 & cte_est2=0 & cte_est3=0 & cte_est4=0 & he_est0=1 & he_est1=0 & he_est2=0 & pc=2 -> (a'=1) & (pc'=3) ;
  [] cte_est0=0 & cte_est1=1 & cte_est2=0 & cte_est3=0 & cte_est4=0 & he_est0=1 & he_est1=0 & he_est2=0 & pc=2 -> (a'=2) & (pc'=3) ;
  [] cte_est0=0 & cte_est1=1 & cte_est2=0 & cte_est3=0 & cte_est4=0 & he_est0=1 & he_est1=0 & he_est2=1 & pc=2 -> (a'=0) & (pc'=3) ;
  [] cte_est0=0 & cte_est1=1 & cte_est2=0 & cte_est3=0 & cte_est4=0 & he_est0=1 & he_est1=0 & he_est2=1 & pc=2 -> (a'=1) & (pc'=3) ;
  [] cte_est0=0 & cte_est1=1 & cte_est2=0 & cte_est3=0 & cte_est4=0 & he_est0=1 & he_est1=1 & he_est2=0 & pc=2 -> (a'=0) & (pc'=3) ;
  [] cte_est0=0 & cte_est1=1 & cte_est2=0 & cte_est3=0 & cte_est4=0 & he_est0=1 & he_est1=1 & he_est2=0 & pc=2 -> (a'=2) & (pc'=3) ;
  [] cte_est0=0 & cte_est1=1 & cte_est2=0 & cte_est3=0 & cte_est4=0 & he_est0=1 & he_est1=1 & he_est2=1 & pc=2 -> (a'=0) & (pc'=3) ;
  [] cte_est0=0 & cte_est1=1 & cte_est2=0 & cte_est3=0 & cte_est4=1 & he_est0=0 & he_est1=0 & he_est2=1 & pc=2 -> (a'=1) & (pc'=3) ;
  [] cte_est0=0 & cte_est1=1 & cte_est2=0 & cte_est3=0 & cte_est4=1 & he_est0=0 & he_est1=1 & he_est2=0 & pc=2 -> (a'=0) & (pc'=3) ;
  [] cte_est0=0 & cte_est1=1 & cte_est2=0 & cte_est3=0 & cte_est4=1 & he_est0=0 & he_est1=1 & he_est2=0 & pc=2 -> (a'=2) & (pc'=3) ;
  [] cte_est0=0 & cte_est1=1 & cte_est2=0 & cte_est3=0 & cte_est4=1 & he_est0=0 & he_est1=1 & he_est2=1 & pc=2 -> (a'=0) & (alpha'=alpha+1) & (pc'=3) ;
  [] cte_est0=0 & cte_est1=1 & cte_est2=0 & cte_est3=0 & cte_est4=1 & he_est0=1 & he_est1=0 & he_est2=0 & pc=2 -> (a'=0) & (pc'=3) ;
  [] cte_est0=0 & cte_est1=1 & cte_est2=0 & cte_est3=0 & cte_est4=1 & he_est0=1 & he_est1=0 & he_est2=0 & pc=2 -> (a'=1) & (pc'=3) ;
  [] cte_est0=0 & cte_est1=1 & cte_est2=0 & cte_est3=0 & cte_est4=1 & he_est0=1 & he_est1=0 & he_est2=1 & pc=2 -> (a'=1) & (pc'=3) ;
  [] cte_est0=0 & cte_est1=1 & cte_est2=0 & cte_est3=0 & cte_est4=1 & he_est0=1 & he_est1=1 & he_est2=0 & pc=2 -> (a'=0) & (pc'=3) ;
  [] cte_est0=0 & cte_est1=1 & cte_est2=0 & cte_est3=0 & cte_est4=1 & he_est0=1 & he_est1=1 & he_est2=1 & pc=2 -> (a'=0) & (alpha'=alpha+1) & (pc'=3) ;
  [] cte_est0=0 & cte_est1=1 & cte_est2=0 & cte_est3=1 & cte_est4=0 & he_est0=0 & he_est1=0 & he_est2=1 & pc=2 -> (a'=0) & (pc'=3) ;
  [] cte_est0=0 & cte_est1=1 & cte_est2=0 & cte_est3=1 & cte_est4=0 & he_est0=0 & he_est1=0 & he_est2=1 & pc=2 -> (a'=1) & (pc'=3) ;
  [] cte_est0=0 & cte_est1=1 & cte_est2=0 & cte_est3=1 & cte_est4=0 & he_est0=0 & he_est1=1 & he_est2=0 & pc=2 -> (a'=2) & (pc'=3) ;
  [] cte_est0=0 & cte_est1=1 & cte_est2=0 & cte_est3=1 & cte_est4=0 & he_est0=0 & he_est1=1 & he_est2=1 & pc=2 -> (a'=0) & (alpha'=alpha+1) & (pc'=3) ;
  [] cte_est0=0 & cte_est1=1 & cte_est2=0 & cte_est3=1 & cte_est4=0 & he_est0=1 & he_est1=0 & he_est2=0 & pc=2 -> (a'=0) & (pc'=3) ;
  [] cte_est0=0 & cte_est1=1 & cte_est2=0 & cte_est3=1 & cte_est4=0 & he_est0=1 & he_est1=0 & he_est2=0 & pc=2 -> (a'=2) & (pc'=3) ;
  [] cte_est0=0 & cte_est1=1 & cte_est2=0 & cte_est3=1 & cte_est4=0 & he_est0=1 & he_est1=0 & he_est2=1 & pc=2 -> (a'=0) & (pc'=3) ;
  [] cte_est0=0 & cte_est1=1 & cte_est2=0 & cte_est3=1 & cte_est4=0 & he_est0=1 & he_est1=1 & he_est2=0 & pc=2 -> (a'=2) & (pc'=3) ;
  [] cte_est0=0 & cte_est1=1 & cte_est2=0 & cte_est3=1 & cte_est4=0 & he_est0=1 & he_est1=1 & he_est2=1 & pc=2 -> (a'=0) & (alpha'=alpha+1) & (pc'=3) ;
  [] cte_est0=0 & cte_est1=1 & cte_est2=0 & cte_est3=1 & cte_est4=1 & he_est0=0 & he_est1=0 & he_est2=1 & pc=2 -> (a'=1) & (pc'=3) ;
  [] cte_est0=0 & cte_est1=1 & cte_est2=0 & cte_est3=1 & cte_est4=1 & he_est0=0 & he_est1=1 & he_est2=0 & pc=2 -> (a'=2) & (pc'=3) ;
  [] cte_est0=0 & cte_est1=1 & cte_est2=0 & cte_est3=1 & cte_est4=1 & he_est0=0 & he_est1=1 & he_est2=1 & pc=2 -> (a'=0) & (alpha'=alpha+1) & (pc'=3) ;
  [] cte_est0=0 & cte_est1=1 & cte_est2=0 & cte_est3=1 & cte_est4=1 & he_est0=1 & he_est1=0 & he_est2=0 & pc=2 -> (a'=0) & (pc'=3) ;
  [] cte_est0=0 & cte_est1=1 & cte_est2=0 & cte_est3=1 & cte_est4=1 & he_est0=1 & he_est1=0 & he_est2=1 & pc=2 -> (a'=0) & (alpha'=alpha+1) & (pc'=3) ;
  [] cte_est0=0 & cte_est1=1 & cte_est2=0 & cte_est3=1 & cte_est4=1 & he_est0=1 & he_est1=1 & he_est2=0 & pc=2 -> (a'=0) & (alpha'=alpha+1) & (pc'=3) ;
  [] cte_est0=0 & cte_est1=1 & cte_est2=0 & cte_est3=1 & cte_est4=1 & he_est0=1 & he_est1=1 & he_est2=1 & pc=2 -> (a'=0) & (alpha'=alpha+1) & (pc'=3) ;
  [] cte_est0=0 & cte_est1=1 & cte_est2=1 & cte_est3=0 & cte_est4=0 & he_est0=0 & he_est1=0 & he_est2=1 & pc=2 -> (a'=0) & (pc'=3) ;
  [] cte_est0=0 & cte_est1=1 & cte_est2=1 & cte_est3=0 & cte_est4=0 & he_est0=0 & he_est1=0 & he_est2=1 & pc=2 -> (a'=1) & (pc'=3) ;
  [] cte_est0=0 & cte_est1=1 & cte_est2=1 & cte_est3=0 & cte_est4=0 & he_est0=0 & he_est1=1 & he_est2=0 & pc=2 -> (a'=0) & (pc'=3) ;
  [] cte_est0=0 & cte_est1=1 & cte_est2=1 & cte_est3=0 & cte_est4=0 & he_est0=0 & he_est1=1 & he_est2=0 & pc=2 -> (a'=2) & (pc'=3) ;
  [] cte_est0=0 & cte_est1=1 & cte_est2=1 & cte_est3=0 & cte_est4=0 & he_est0=0 & he_est1=1 & he_est2=1 & pc=2 -> (a'=0) & (pc'=3) ;
  [] cte_est0=0 & cte_est1=1 & cte_est2=1 & cte_est3=0 & cte_est4=0 & he_est0=1 & he_est1=0 & he_est2=0 & pc=2 -> (a'=0) & (pc'=3) ;
  [] cte_est0=0 & cte_est1=1 & cte_est2=1 & cte_est3=0 & cte_est4=0 & he_est0=1 & he_est1=0 & he_est2=0 & pc=2 -> (a'=1) & (pc'=3) ;
  [] cte_est0=0 & cte_est1=1 & cte_est2=1 & cte_est3=0 & cte_est4=0 & he_est0=1 & he_est1=0 & he_est2=0 & pc=2 -> (a'=2) & (pc'=3) ;
  [] cte_est0=0 & cte_est1=1 & cte_est2=1 & cte_est3=0 & cte_est4=0 & he_est0=1 & he_est1=0 & he_est2=1 & pc=2 -> (a'=0) & (pc'=3) ;
  [] cte_est0=0 & cte_est1=1 & cte_est2=1 & cte_est3=0 & cte_est4=0 & he_est0=1 & he_est1=0 & he_est2=1 & pc=2 -> (a'=1) & (pc'=3) ;
  [] cte_est0=0 & cte_est1=1 & cte_est2=1 & cte_est3=0 & cte_est4=0 & he_est0=1 & he_est1=1 & he_est2=0 & pc=2 -> (a'=0) & (pc'=3) ;
  [] cte_est0=0 & cte_est1=1 & cte_est2=1 & cte_est3=0 & cte_est4=0 & he_est0=1 & he_est1=1 & he_est2=0 & pc=2 -> (a'=2) & (pc'=3) ;
  [] cte_est0=0 & cte_est1=1 & cte_est2=1 & cte_est3=0 & cte_est4=0 & he_est0=1 & he_est1=1 & he_est2=1 & pc=2 -> (a'=0) & (pc'=3) ;
  [] cte_est0=0 & cte_est1=1 & cte_est2=1 & cte_est3=0 & cte_est4=1 & he_est0=0 & he_est1=0 & he_est2=1 & pc=2 -> (a'=1) & (pc'=3) ;
  [] cte_est0=0 & cte_est1=1 & cte_est2=1 & cte_est3=0 & cte_est4=1 & he_est0=0 & he_est1=1 & he_est2=0 & pc=2 -> (a'=0) & (pc'=3) ;
  [] cte_est0=0 & cte_est1=1 & cte_est2=1 & cte_est3=0 & cte_est4=1 & he_est0=0 & he_est1=1 & he_est2=0 & pc=2 -> (a'=2) & (pc'=3) ;
  [] cte_est0=0 & cte_est1=1 & cte_est2=1 & cte_est3=0 & cte_est4=1 & he_est0=0 & he_est1=1 & he_est2=1 & pc=2 -> (a'=0) & (alpha'=alpha+1) & (pc'=3) ;
  [] cte_est0=0 & cte_est1=1 & cte_est2=1 & cte_est3=0 & cte_est4=1 & he_est0=1 & he_est1=0 & he_est2=0 & pc=2 -> (a'=0) & (pc'=3) ;
  [] cte_est0=0 & cte_est1=1 & cte_est2=1 & cte_est3=0 & cte_est4=1 & he_est0=1 & he_est1=0 & he_est2=0 & pc=2 -> (a'=1) & (pc'=3) ;
  [] cte_est0=0 & cte_est1=1 & cte_est2=1 & cte_est3=0 & cte_est4=1 & he_est0=1 & he_est1=0 & he_est2=1 & pc=2 -> (a'=1) & (pc'=3) ;
  [] cte_est0=0 & cte_est1=1 & cte_est2=1 & cte_est3=0 & cte_est4=1 & he_est0=1 & he_est1=1 & he_est2=0 & pc=2 -> (a'=0) & (pc'=3) ;
  [] cte_est0=0 & cte_est1=1 & cte_est2=1 & cte_est3=0 & cte_est4=1 & he_est0=1 & he_est1=1 & he_est2=1 & pc=2 -> (a'=0) & (alpha'=alpha+1) & (pc'=3) ;
  [] cte_est0=0 & cte_est1=1 & cte_est2=1 & cte_est3=1 & cte_est4=0 & he_est0=0 & he_est1=0 & he_est2=1 & pc=2 -> (a'=0) & (pc'=3) ;
  [] cte_est0=0 & cte_est1=1 & cte_est2=1 & cte_est3=1 & cte_est4=0 & he_est0=0 & he_est1=0 & he_est2=1 & pc=2 -> (a'=1) & (pc'=3) ;
  [] cte_est0=0 & cte_est1=1 & cte_est2=1 & cte_est3=1 & cte_est4=0 & he_est0=0 & he_est1=1 & he_est2=0 & pc=2 -> (a'=2) & (pc'=3) ;
  [] cte_est0=0 & cte_est1=1 & cte_est2=1 & cte_est3=1 & cte_est4=0 & he_est0=0 & he_est1=1 & he_est2=1 & pc=2 -> (a'=0) & (alpha'=alpha+1) & (pc'=3) ;
  [] cte_est0=0 & cte_est1=1 & cte_est2=1 & cte_est3=1 & cte_est4=0 & he_est0=1 & he_est1=0 & he_est2=0 & pc=2 -> (a'=0) & (pc'=3) ;
  [] cte_est0=0 & cte_est1=1 & cte_est2=1 & cte_est3=1 & cte_est4=0 & he_est0=1 & he_est1=0 & he_est2=0 & pc=2 -> (a'=2) & (pc'=3) ;
  [] cte_est0=0 & cte_est1=1 & cte_est2=1 & cte_est3=1 & cte_est4=0 & he_est0=1 & he_est1=0 & he_est2=1 & pc=2 -> (a'=0) & (pc'=3) ;
  [] cte_est0=0 & cte_est1=1 & cte_est2=1 & cte_est3=1 & cte_est4=0 & he_est0=1 & he_est1=1 & he_est2=0 & pc=2 -> (a'=2) & (pc'=3) ;
  [] cte_est0=0 & cte_est1=1 & cte_est2=1 & cte_est3=1 & cte_est4=0 & he_est0=1 & he_est1=1 & he_est2=1 & pc=2 -> (a'=0) & (alpha'=alpha+1) & (pc'=3) ;
  [] cte_est0=0 & cte_est1=1 & cte_est2=1 & cte_est3=1 & cte_est4=1 & he_est0=0 & he_est1=0 & he_est2=1 & pc=2 -> (a'=1) & (pc'=3) ;
  [] cte_est0=0 & cte_est1=1 & cte_est2=1 & cte_est3=1 & cte_est4=1 & he_est0=0 & he_est1=1 & he_est2=0 & pc=2 -> (a'=2) & (pc'=3) ;
  [] cte_est0=0 & cte_est1=1 & cte_est2=1 & cte_est3=1 & cte_est4=1 & he_est0=0 & he_est1=1 & he_est2=1 & pc=2 -> (a'=0) & (alpha'=alpha+1) & (pc'=3) ;
  [] cte_est0=0 & cte_est1=1 & cte_est2=1 & cte_est3=1 & cte_est4=1 & he_est0=1 & he_est1=0 & he_est2=0 & pc=2 -> (a'=0) & (pc'=3) ;
  [] cte_est0=0 & cte_est1=1 & cte_est2=1 & cte_est3=1 & cte_est4=1 & he_est0=1 & he_est1=0 & he_est2=1 & pc=2 -> (a'=0) & (alpha'=alpha+1) & (pc'=3) ;
  [] cte_est0=0 & cte_est1=1 & cte_est2=1 & cte_est3=1 & cte_est4=1 & he_est0=1 & he_est1=1 & he_est2=0 & pc=2 -> (a'=0) & (alpha'=alpha+1) & (pc'=3) ;
  [] cte_est0=0 & cte_est1=1 & cte_est2=1 & cte_est3=1 & cte_est4=1 & he_est0=1 & he_est1=1 & he_est2=1 & pc=2 -> (a'=0) & (alpha'=alpha+1) & (pc'=3) ;
  [] cte_est0=1 & cte_est1=0 & cte_est2=0 & cte_est3=0 & cte_est4=0 & he_est0=0 & he_est1=0 & he_est2=1 & pc=2 -> (a'=0) & (pc'=3) ;
  [] cte_est0=1 & cte_est1=0 & cte_est2=0 & cte_est3=0 & cte_est4=0 & he_est0=0 & he_est1=0 & he_est2=1 & pc=2 -> (a'=1) & (pc'=3) ;
  [] cte_est0=1 & cte_est1=0 & cte_est2=0 & cte_est3=0 & cte_est4=0 & he_est0=0 & he_est1=1 & he_est2=0 & pc=2 -> (a'=0) & (pc'=3) ;
  [] cte_est0=1 & cte_est1=0 & cte_est2=0 & cte_est3=0 & cte_est4=0 & he_est0=0 & he_est1=1 & he_est2=0 & pc=2 -> (a'=2) & (pc'=3) ;
  [] cte_est0=1 & cte_est1=0 & cte_est2=0 & cte_est3=0 & cte_est4=0 & he_est0=0 & he_est1=1 & he_est2=1 & pc=2 -> (a'=0) & (pc'=3) ;
  [] cte_est0=1 & cte_est1=0 & cte_est2=0 & cte_est3=0 & cte_est4=0 & he_est0=1 & he_est1=0 & he_est2=0 & pc=2 -> (a'=0) & (pc'=3) ;
  [] cte_est0=1 & cte_est1=0 & cte_est2=0 & cte_est3=0 & cte_est4=0 & he_est0=1 & he_est1=0 & he_est2=0 & pc=2 -> (a'=1) & (pc'=3) ;
  [] cte_est0=1 & cte_est1=0 & cte_est2=0 & cte_est3=0 & cte_est4=0 & he_est0=1 & he_est1=0 & he_est2=0 & pc=2 -> (a'=2) & (pc'=3) ;
  [] cte_est0=1 & cte_est1=0 & cte_est2=0 & cte_est3=0 & cte_est4=0 & he_est0=1 & he_est1=0 & he_est2=1 & pc=2 -> (a'=0) & (pc'=3) ;
  [] cte_est0=1 & cte_est1=0 & cte_est2=0 & cte_est3=0 & cte_est4=0 & he_est0=1 & he_est1=0 & he_est2=1 & pc=2 -> (a'=1) & (pc'=3) ;
  [] cte_est0=1 & cte_est1=0 & cte_est2=0 & cte_est3=0 & cte_est4=0 & he_est0=1 & he_est1=1 & he_est2=0 & pc=2 -> (a'=0) & (pc'=3) ;
  [] cte_est0=1 & cte_est1=0 & cte_est2=0 & cte_est3=0 & cte_est4=0 & he_est0=1 & he_est1=1 & he_est2=0 & pc=2 -> (a'=2) & (pc'=3) ;
  [] cte_est0=1 & cte_est1=0 & cte_est2=0 & cte_est3=0 & cte_est4=0 & he_est0=1 & he_est1=1 & he_est2=1 & pc=2 -> (a'=0) & (pc'=3) ;
  [] cte_est0=1 & cte_est1=0 & cte_est2=0 & cte_est3=0 & cte_est4=1 & he_est0=0 & he_est1=0 & he_est2=1 & pc=2 -> (a'=1) & (pc'=3) ;
  [] cte_est0=1 & cte_est1=0 & cte_est2=0 & cte_est3=0 & cte_est4=1 & he_est0=0 & he_est1=1 & he_est2=0 & pc=2 -> (a'=0) & (pc'=3) ;
  [] cte_est0=1 & cte_est1=0 & cte_est2=0 & cte_est3=0 & cte_est4=1 & he_est0=0 & he_est1=1 & he_est2=0 & pc=2 -> (a'=2) & (pc'=3) ;
  [] cte_est0=1 & cte_est1=0 & cte_est2=0 & cte_est3=0 & cte_est4=1 & he_est0=0 & he_est1=1 & he_est2=1 & pc=2 -> (a'=0) & (alpha'=alpha+1) & (pc'=3) ;
  [] cte_est0=1 & cte_est1=0 & cte_est2=0 & cte_est3=0 & cte_est4=1 & he_est0=1 & he_est1=0 & he_est2=0 & pc=2 -> (a'=0) & (pc'=3) ;
  [] cte_est0=1 & cte_est1=0 & cte_est2=0 & cte_est3=0 & cte_est4=1 & he_est0=1 & he_est1=0 & he_est2=0 & pc=2 -> (a'=1) & (pc'=3) ;
  [] cte_est0=1 & cte_est1=0 & cte_est2=0 & cte_est3=0 & cte_est4=1 & he_est0=1 & he_est1=0 & he_est2=1 & pc=2 -> (a'=1) & (pc'=3) ;
  [] cte_est0=1 & cte_est1=0 & cte_est2=0 & cte_est3=0 & cte_est4=1 & he_est0=1 & he_est1=1 & he_est2=0 & pc=2 -> (a'=0) & (pc'=3) ;
  [] cte_est0=1 & cte_est1=0 & cte_est2=0 & cte_est3=0 & cte_est4=1 & he_est0=1 & he_est1=1 & he_est2=1 & pc=2 -> (a'=0) & (alpha'=alpha+1) & (pc'=3) ;
  [] cte_est0=1 & cte_est1=0 & cte_est2=0 & cte_est3=1 & cte_est4=0 & he_est0=0 & he_est1=0 & he_est2=1 & pc=2 -> (a'=0) & (pc'=3) ;
  [] cte_est0=1 & cte_est1=0 & cte_est2=0 & cte_est3=1 & cte_est4=0 & he_est0=0 & he_est1=0 & he_est2=1 & pc=2 -> (a'=1) & (pc'=3) ;
  [] cte_est0=1 & cte_est1=0 & cte_est2=0 & cte_est3=1 & cte_est4=0 & he_est0=0 & he_est1=1 & he_est2=0 & pc=2 -> (a'=2) & (pc'=3) ;
  [] cte_est0=1 & cte_est1=0 & cte_est2=0 & cte_est3=1 & cte_est4=0 & he_est0=0 & he_est1=1 & he_est2=1 & pc=2 -> (a'=0) & (alpha'=alpha+1) & (pc'=3) ;
  [] cte_est0=1 & cte_est1=0 & cte_est2=0 & cte_est3=1 & cte_est4=0 & he_est0=1 & he_est1=0 & he_est2=0 & pc=2 -> (a'=0) & (pc'=3) ;
  [] cte_est0=1 & cte_est1=0 & cte_est2=0 & cte_est3=1 & cte_est4=0 & he_est0=1 & he_est1=0 & he_est2=0 & pc=2 -> (a'=2) & (pc'=3) ;
  [] cte_est0=1 & cte_est1=0 & cte_est2=0 & cte_est3=1 & cte_est4=0 & he_est0=1 & he_est1=0 & he_est2=1 & pc=2 -> (a'=0) & (pc'=3) ;
  [] cte_est0=1 & cte_est1=0 & cte_est2=0 & cte_est3=1 & cte_est4=0 & he_est0=1 & he_est1=1 & he_est2=0 & pc=2 -> (a'=2) & (pc'=3) ;
  [] cte_est0=1 & cte_est1=0 & cte_est2=0 & cte_est3=1 & cte_est4=0 & he_est0=1 & he_est1=1 & he_est2=1 & pc=2 -> (a'=0) & (alpha'=alpha+1) & (pc'=3) ;
  [] cte_est0=1 & cte_est1=0 & cte_est2=0 & cte_est3=1 & cte_est4=1 & he_est0=0 & he_est1=0 & he_est2=1 & pc=2 -> (a'=1) & (pc'=3) ;
  [] cte_est0=1 & cte_est1=0 & cte_est2=0 & cte_est3=1 & cte_est4=1 & he_est0=0 & he_est1=1 & he_est2=0 & pc=2 -> (a'=2) & (pc'=3) ;
  [] cte_est0=1 & cte_est1=0 & cte_est2=0 & cte_est3=1 & cte_est4=1 & he_est0=0 & he_est1=1 & he_est2=1 & pc=2 -> (a'=0) & (alpha'=alpha+1) & (pc'=3) ;
  [] cte_est0=1 & cte_est1=0 & cte_est2=0 & cte_est3=1 & cte_est4=1 & he_est0=1 & he_est1=0 & he_est2=0 & pc=2 -> (a'=0) & (pc'=3) ;
  [] cte_est0=1 & cte_est1=0 & cte_est2=0 & cte_est3=1 & cte_est4=1 & he_est0=1 & he_est1=0 & he_est2=1 & pc=2 -> (a'=0) & (alpha'=alpha+1) & (pc'=3) ;
  [] cte_est0=1 & cte_est1=0 & cte_est2=0 & cte_est3=1 & cte_est4=1 & he_est0=1 & he_est1=1 & he_est2=0 & pc=2 -> (a'=0) & (alpha'=alpha+1) & (pc'=3) ;
  [] cte_est0=1 & cte_est1=0 & cte_est2=0 & cte_est3=1 & cte_est4=1 & he_est0=1 & he_est1=1 & he_est2=1 & pc=2 -> (a'=0) & (alpha'=alpha+1) & (pc'=3) ;
  [] cte_est0=1 & cte_est1=0 & cte_est2=1 & cte_est3=0 & cte_est4=0 & he_est0=0 & he_est1=0 & he_est2=1 & pc=2 -> (a'=0) & (pc'=3) ;
  [] cte_est0=1 & cte_est1=0 & cte_est2=1 & cte_est3=0 & cte_est4=0 & he_est0=0 & he_est1=0 & he_est2=1 & pc=2 -> (a'=1) & (pc'=3) ;
  [] cte_est0=1 & cte_est1=0 & cte_est2=1 & cte_est3=0 & cte_est4=0 & he_est0=0 & he_est1=1 & he_est2=0 & pc=2 -> (a'=0) & (pc'=3) ;
  [] cte_est0=1 & cte_est1=0 & cte_est2=1 & cte_est3=0 & cte_est4=0 & he_est0=0 & he_est1=1 & he_est2=0 & pc=2 -> (a'=2) & (pc'=3) ;
  [] cte_est0=1 & cte_est1=0 & cte_est2=1 & cte_est3=0 & cte_est4=0 & he_est0=0 & he_est1=1 & he_est2=1 & pc=2 -> (a'=0) & (pc'=3) ;
  [] cte_est0=1 & cte_est1=0 & cte_est2=1 & cte_est3=0 & cte_est4=0 & he_est0=1 & he_est1=0 & he_est2=0 & pc=2 -> (a'=0) & (pc'=3) ;
  [] cte_est0=1 & cte_est1=0 & cte_est2=1 & cte_est3=0 & cte_est4=0 & he_est0=1 & he_est1=0 & he_est2=0 & pc=2 -> (a'=1) & (pc'=3) ;
  [] cte_est0=1 & cte_est1=0 & cte_est2=1 & cte_est3=0 & cte_est4=0 & he_est0=1 & he_est1=0 & he_est2=0 & pc=2 -> (a'=2) & (pc'=3) ;
  [] cte_est0=1 & cte_est1=0 & cte_est2=1 & cte_est3=0 & cte_est4=0 & he_est0=1 & he_est1=0 & he_est2=1 & pc=2 -> (a'=0) & (pc'=3) ;
  [] cte_est0=1 & cte_est1=0 & cte_est2=1 & cte_est3=0 & cte_est4=0 & he_est0=1 & he_est1=0 & he_est2=1 & pc=2 -> (a'=1) & (pc'=3) ;
  [] cte_est0=1 & cte_est1=0 & cte_est2=1 & cte_est3=0 & cte_est4=0 & he_est0=1 & he_est1=1 & he_est2=0 & pc=2 -> (a'=0) & (pc'=3) ;
  [] cte_est0=1 & cte_est1=0 & cte_est2=1 & cte_est3=0 & cte_est4=0 & he_est0=1 & he_est1=1 & he_est2=0 & pc=2 -> (a'=2) & (pc'=3) ;
  [] cte_est0=1 & cte_est1=0 & cte_est2=1 & cte_est3=0 & cte_est4=0 & he_est0=1 & he_est1=1 & he_est2=1 & pc=2 -> (a'=0) & (pc'=3) ;
  [] cte_est0=1 & cte_est1=0 & cte_est2=1 & cte_est3=0 & cte_est4=1 & he_est0=0 & he_est1=0 & he_est2=1 & pc=2 -> (a'=1) & (pc'=3) ;
  [] cte_est0=1 & cte_est1=0 & cte_est2=1 & cte_est3=0 & cte_est4=1 & he_est0=0 & he_est1=1 & he_est2=0 & pc=2 -> (a'=0) & (pc'=3) ;
  [] cte_est0=1 & cte_est1=0 & cte_est2=1 & cte_est3=0 & cte_est4=1 & he_est0=0 & he_est1=1 & he_est2=0 & pc=2 -> (a'=2) & (pc'=3) ;
  [] cte_est0=1 & cte_est1=0 & cte_est2=1 & cte_est3=0 & cte_est4=1 & he_est0=0 & he_est1=1 & he_est2=1 & pc=2 -> (a'=0) & (alpha'=alpha+1) & (pc'=3) ;
  [] cte_est0=1 & cte_est1=0 & cte_est2=1 & cte_est3=0 & cte_est4=1 & he_est0=1 & he_est1=0 & he_est2=0 & pc=2 -> (a'=0) & (pc'=3) ;
  [] cte_est0=1 & cte_est1=0 & cte_est2=1 & cte_est3=0 & cte_est4=1 & he_est0=1 & he_est1=0 & he_est2=0 & pc=2 -> (a'=1) & (pc'=3) ;
  [] cte_est0=1 & cte_est1=0 & cte_est2=1 & cte_est3=0 & cte_est4=1 & he_est0=1 & he_est1=0 & he_est2=1 & pc=2 -> (a'=1) & (pc'=3) ;
  [] cte_est0=1 & cte_est1=0 & cte_est2=1 & cte_est3=0 & cte_est4=1 & he_est0=1 & he_est1=1 & he_est2=0 & pc=2 -> (a'=0) & (pc'=3) ;
  [] cte_est0=1 & cte_est1=0 & cte_est2=1 & cte_est3=0 & cte_est4=1 & he_est0=1 & he_est1=1 & he_est2=1 & pc=2 -> (a'=0) & (alpha'=alpha+1) & (pc'=3) ;
  [] cte_est0=1 & cte_est1=0 & cte_est2=1 & cte_est3=1 & cte_est4=0 & he_est0=0 & he_est1=0 & he_est2=1 & pc=2 -> (a'=0) & (pc'=3) ;
  [] cte_est0=1 & cte_est1=0 & cte_est2=1 & cte_est3=1 & cte_est4=0 & he_est0=0 & he_est1=0 & he_est2=1 & pc=2 -> (a'=1) & (pc'=3) ;
  [] cte_est0=1 & cte_est1=0 & cte_est2=1 & cte_est3=1 & cte_est4=0 & he_est0=0 & he_est1=1 & he_est2=0 & pc=2 -> (a'=2) & (pc'=3) ;
  [] cte_est0=1 & cte_est1=0 & cte_est2=1 & cte_est3=1 & cte_est4=0 & he_est0=0 & he_est1=1 & he_est2=1 & pc=2 -> (a'=0) & (alpha'=alpha+1) & (pc'=3) ;
  [] cte_est0=1 & cte_est1=0 & cte_est2=1 & cte_est3=1 & cte_est4=0 & he_est0=1 & he_est1=0 & he_est2=0 & pc=2 -> (a'=0) & (pc'=3) ;
  [] cte_est0=1 & cte_est1=0 & cte_est2=1 & cte_est3=1 & cte_est4=0 & he_est0=1 & he_est1=0 & he_est2=0 & pc=2 -> (a'=2) & (pc'=3) ;
  [] cte_est0=1 & cte_est1=0 & cte_est2=1 & cte_est3=1 & cte_est4=0 & he_est0=1 & he_est1=0 & he_est2=1 & pc=2 -> (a'=0) & (pc'=3) ;
  [] cte_est0=1 & cte_est1=0 & cte_est2=1 & cte_est3=1 & cte_est4=0 & he_est0=1 & he_est1=1 & he_est2=0 & pc=2 -> (a'=2) & (pc'=3) ;
  [] cte_est0=1 & cte_est1=0 & cte_est2=1 & cte_est3=1 & cte_est4=0 & he_est0=1 & he_est1=1 & he_est2=1 & pc=2 -> (a'=0) & (alpha'=alpha+1) & (pc'=3) ;
  [] cte_est0=1 & cte_est1=0 & cte_est2=1 & cte_est3=1 & cte_est4=1 & he_est0=0 & he_est1=0 & he_est2=1 & pc=2 -> (a'=1) & (pc'=3) ;
  [] cte_est0=1 & cte_est1=0 & cte_est2=1 & cte_est3=1 & cte_est4=1 & he_est0=0 & he_est1=1 & he_est2=0 & pc=2 -> (a'=2) & (pc'=3) ;
  [] cte_est0=1 & cte_est1=0 & cte_est2=1 & cte_est3=1 & cte_est4=1 & he_est0=0 & he_est1=1 & he_est2=1 & pc=2 -> (a'=0) & (alpha'=alpha+1) & (pc'=3) ;
  [] cte_est0=1 & cte_est1=0 & cte_est2=1 & cte_est3=1 & cte_est4=1 & he_est0=1 & he_est1=0 & he_est2=0 & pc=2 -> (a'=0) & (pc'=3) ;
  [] cte_est0=1 & cte_est1=0 & cte_est2=1 & cte_est3=1 & cte_est4=1 & he_est0=1 & he_est1=0 & he_est2=1 & pc=2 -> (a'=0) & (alpha'=alpha+1) & (pc'=3) ;
  [] cte_est0=1 & cte_est1=0 & cte_est2=1 & cte_est3=1 & cte_est4=1 & he_est0=1 & he_est1=1 & he_est2=0 & pc=2 -> (a'=0) & (alpha'=alpha+1) & (pc'=3) ;
  [] cte_est0=1 & cte_est1=0 & cte_est2=1 & cte_est3=1 & cte_est4=1 & he_est0=1 & he_est1=1 & he_est2=1 & pc=2 -> (a'=0) & (alpha'=alpha+1) & (pc'=3) ;
  [] cte_est0=1 & cte_est1=1 & cte_est2=0 & cte_est3=0 & cte_est4=0 & he_est0=0 & he_est1=0 & he_est2=1 & pc=2 -> (a'=0) & (pc'=3) ;
  [] cte_est0=1 & cte_est1=1 & cte_est2=0 & cte_est3=0 & cte_est4=0 & he_est0=0 & he_est1=0 & he_est2=1 & pc=2 -> (a'=1) & (pc'=3) ;
  [] cte_est0=1 & cte_est1=1 & cte_est2=0 & cte_est3=0 & cte_est4=0 & he_est0=0 & he_est1=1 & he_est2=0 & pc=2 -> (a'=0) & (pc'=3) ;
  [] cte_est0=1 & cte_est1=1 & cte_est2=0 & cte_est3=0 & cte_est4=0 & he_est0=0 & he_est1=1 & he_est2=0 & pc=2 -> (a'=2) & (pc'=3) ;
  [] cte_est0=1 & cte_est1=1 & cte_est2=0 & cte_est3=0 & cte_est4=0 & he_est0=0 & he_est1=1 & he_est2=1 & pc=2 -> (a'=0) & (pc'=3) ;
  [] cte_est0=1 & cte_est1=1 & cte_est2=0 & cte_est3=0 & cte_est4=0 & he_est0=1 & he_est1=0 & he_est2=0 & pc=2 -> (a'=0) & (pc'=3) ;
  [] cte_est0=1 & cte_est1=1 & cte_est2=0 & cte_est3=0 & cte_est4=0 & he_est0=1 & he_est1=0 & he_est2=0 & pc=2 -> (a'=1) & (pc'=3) ;
  [] cte_est0=1 & cte_est1=1 & cte_est2=0 & cte_est3=0 & cte_est4=0 & he_est0=1 & he_est1=0 & he_est2=0 & pc=2 -> (a'=2) & (pc'=3) ;
  [] cte_est0=1 & cte_est1=1 & cte_est2=0 & cte_est3=0 & cte_est4=0 & he_est0=1 & he_est1=0 & he_est2=1 & pc=2 -> (a'=0) & (pc'=3) ;
  [] cte_est0=1 & cte_est1=1 & cte_est2=0 & cte_est3=0 & cte_est4=0 & he_est0=1 & he_est1=0 & he_est2=1 & pc=2 -> (a'=1) & (pc'=3) ;
  [] cte_est0=1 & cte_est1=1 & cte_est2=0 & cte_est3=0 & cte_est4=0 & he_est0=1 & he_est1=1 & he_est2=0 & pc=2 -> (a'=0) & (pc'=3) ;
  [] cte_est0=1 & cte_est1=1 & cte_est2=0 & cte_est3=0 & cte_est4=0 & he_est0=1 & he_est1=1 & he_est2=0 & pc=2 -> (a'=2) & (pc'=3) ;
  [] cte_est0=1 & cte_est1=1 & cte_est2=0 & cte_est3=0 & cte_est4=0 & he_est0=1 & he_est1=1 & he_est2=1 & pc=2 -> (a'=0) & (pc'=3) ;
  [] cte_est0=1 & cte_est1=1 & cte_est2=0 & cte_est3=0 & cte_est4=1 & he_est0=0 & he_est1=0 & he_est2=1 & pc=2 -> (a'=1) & (pc'=3) ;
  [] cte_est0=1 & cte_est1=1 & cte_est2=0 & cte_est3=0 & cte_est4=1 & he_est0=0 & he_est1=1 & he_est2=0 & pc=2 -> (a'=0) & (pc'=3) ;
  [] cte_est0=1 & cte_est1=1 & cte_est2=0 & cte_est3=0 & cte_est4=1 & he_est0=0 & he_est1=1 & he_est2=0 & pc=2 -> (a'=2) & (pc'=3) ;
  [] cte_est0=1 & cte_est1=1 & cte_est2=0 & cte_est3=0 & cte_est4=1 & he_est0=0 & he_est1=1 & he_est2=1 & pc=2 -> (a'=0) & (alpha'=alpha+1) & (pc'=3) ;
  [] cte_est0=1 & cte_est1=1 & cte_est2=0 & cte_est3=0 & cte_est4=1 & he_est0=1 & he_est1=0 & he_est2=0 & pc=2 -> (a'=0) & (pc'=3) ;
  [] cte_est0=1 & cte_est1=1 & cte_est2=0 & cte_est3=0 & cte_est4=1 & he_est0=1 & he_est1=0 & he_est2=0 & pc=2 -> (a'=1) & (pc'=3) ;
  [] cte_est0=1 & cte_est1=1 & cte_est2=0 & cte_est3=0 & cte_est4=1 & he_est0=1 & he_est1=0 & he_est2=1 & pc=2 -> (a'=1) & (pc'=3) ;
  [] cte_est0=1 & cte_est1=1 & cte_est2=0 & cte_est3=0 & cte_est4=1 & he_est0=1 & he_est1=1 & he_est2=0 & pc=2 -> (a'=0) & (pc'=3) ;
  [] cte_est0=1 & cte_est1=1 & cte_est2=0 & cte_est3=0 & cte_est4=1 & he_est0=1 & he_est1=1 & he_est2=1 & pc=2 -> (a'=0) & (alpha'=alpha+1) & (pc'=3) ;
  [] cte_est0=1 & cte_est1=1 & cte_est2=0 & cte_est3=1 & cte_est4=0 & he_est0=0 & he_est1=0 & he_est2=1 & pc=2 -> (a'=0) & (pc'=3) ;
  [] cte_est0=1 & cte_est1=1 & cte_est2=0 & cte_est3=1 & cte_est4=0 & he_est0=0 & he_est1=0 & he_est2=1 & pc=2 -> (a'=1) & (pc'=3) ;
  [] cte_est0=1 & cte_est1=1 & cte_est2=0 & cte_est3=1 & cte_est4=0 & he_est0=0 & he_est1=1 & he_est2=0 & pc=2 -> (a'=2) & (pc'=3) ;
  [] cte_est0=1 & cte_est1=1 & cte_est2=0 & cte_est3=1 & cte_est4=0 & he_est0=0 & he_est1=1 & he_est2=1 & pc=2 -> (a'=0) & (alpha'=alpha+1) & (pc'=3) ;
  [] cte_est0=1 & cte_est1=1 & cte_est2=0 & cte_est3=1 & cte_est4=0 & he_est0=1 & he_est1=0 & he_est2=0 & pc=2 -> (a'=0) & (pc'=3) ;
  [] cte_est0=1 & cte_est1=1 & cte_est2=0 & cte_est3=1 & cte_est4=0 & he_est0=1 & he_est1=0 & he_est2=0 & pc=2 -> (a'=2) & (pc'=3) ;
  [] cte_est0=1 & cte_est1=1 & cte_est2=0 & cte_est3=1 & cte_est4=0 & he_est0=1 & he_est1=0 & he_est2=1 & pc=2 -> (a'=0) & (pc'=3) ;
  [] cte_est0=1 & cte_est1=1 & cte_est2=0 & cte_est3=1 & cte_est4=0 & he_est0=1 & he_est1=1 & he_est2=0 & pc=2 -> (a'=2) & (pc'=3) ;
  [] cte_est0=1 & cte_est1=1 & cte_est2=0 & cte_est3=1 & cte_est4=0 & he_est0=1 & he_est1=1 & he_est2=1 & pc=2 -> (a'=0) & (alpha'=alpha+1) & (pc'=3) ;
  [] cte_est0=1 & cte_est1=1 & cte_est2=0 & cte_est3=1 & cte_est4=1 & he_est0=0 & he_est1=0 & he_est2=1 & pc=2 -> (a'=1) & (pc'=3) ;
  [] cte_est0=1 & cte_est1=1 & cte_est2=0 & cte_est3=1 & cte_est4=1 & he_est0=0 & he_est1=1 & he_est2=0 & pc=2 -> (a'=2) & (pc'=3) ;
  [] cte_est0=1 & cte_est1=1 & cte_est2=0 & cte_est3=1 & cte_est4=1 & he_est0=0 & he_est1=1 & he_est2=1 & pc=2 -> (a'=0) & (alpha'=alpha+1) & (pc'=3) ;
  [] cte_est0=1 & cte_est1=1 & cte_est2=0 & cte_est3=1 & cte_est4=1 & he_est0=1 & he_est1=0 & he_est2=0 & pc=2 -> (a'=0) & (pc'=3) ;
  [] cte_est0=1 & cte_est1=1 & cte_est2=0 & cte_est3=1 & cte_est4=1 & he_est0=1 & he_est1=0 & he_est2=1 & pc=2 -> (a'=0) & (alpha'=alpha+1) & (pc'=3) ;
  [] cte_est0=1 & cte_est1=1 & cte_est2=0 & cte_est3=1 & cte_est4=1 & he_est0=1 & he_est1=1 & he_est2=0 & pc=2 -> (a'=0) & (alpha'=alpha+1) & (pc'=3) ;
  [] cte_est0=1 & cte_est1=1 & cte_est2=0 & cte_est3=1 & cte_est4=1 & he_est0=1 & he_est1=1 & he_est2=1 & pc=2 -> (a'=0) & (alpha'=alpha+1) & (pc'=3) ;
  [] cte_est0=1 & cte_est1=1 & cte_est2=1 & cte_est3=0 & cte_est4=0 & he_est0=0 & he_est1=0 & he_est2=1 & pc=2 -> (a'=0) & (pc'=3) ;
  [] cte_est0=1 & cte_est1=1 & cte_est2=1 & cte_est3=0 & cte_est4=0 & he_est0=0 & he_est1=0 & he_est2=1 & pc=2 -> (a'=1) & (pc'=3) ;
  [] cte_est0=1 & cte_est1=1 & cte_est2=1 & cte_est3=0 & cte_est4=0 & he_est0=0 & he_est1=1 & he_est2=0 & pc=2 -> (a'=0) & (pc'=3) ;
  [] cte_est0=1 & cte_est1=1 & cte_est2=1 & cte_est3=0 & cte_est4=0 & he_est0=0 & he_est1=1 & he_est2=0 & pc=2 -> (a'=2) & (pc'=3) ;
  [] cte_est0=1 & cte_est1=1 & cte_est2=1 & cte_est3=0 & cte_est4=0 & he_est0=0 & he_est1=1 & he_est2=1 & pc=2 -> (a'=0) & (pc'=3) ;
  [] cte_est0=1 & cte_est1=1 & cte_est2=1 & cte_est3=0 & cte_est4=0 & he_est0=1 & he_est1=0 & he_est2=0 & pc=2 -> (a'=0) & (pc'=3) ;
  [] cte_est0=1 & cte_est1=1 & cte_est2=1 & cte_est3=0 & cte_est4=0 & he_est0=1 & he_est1=0 & he_est2=0 & pc=2 -> (a'=1) & (pc'=3) ;
  [] cte_est0=1 & cte_est1=1 & cte_est2=1 & cte_est3=0 & cte_est4=0 & he_est0=1 & he_est1=0 & he_est2=0 & pc=2 -> (a'=2) & (pc'=3) ;
  [] cte_est0=1 & cte_est1=1 & cte_est2=1 & cte_est3=0 & cte_est4=0 & he_est0=1 & he_est1=0 & he_est2=1 & pc=2 -> (a'=0) & (pc'=3) ;
  [] cte_est0=1 & cte_est1=1 & cte_est2=1 & cte_est3=0 & cte_est4=0 & he_est0=1 & he_est1=0 & he_est2=1 & pc=2 -> (a'=1) & (pc'=3) ;
  [] cte_est0=1 & cte_est1=1 & cte_est2=1 & cte_est3=0 & cte_est4=0 & he_est0=1 & he_est1=1 & he_est2=0 & pc=2 -> (a'=0) & (pc'=3) ;
  [] cte_est0=1 & cte_est1=1 & cte_est2=1 & cte_est3=0 & cte_est4=0 & he_est0=1 & he_est1=1 & he_est2=0 & pc=2 -> (a'=2) & (pc'=3) ;
  [] cte_est0=1 & cte_est1=1 & cte_est2=1 & cte_est3=0 & cte_est4=0 & he_est0=1 & he_est1=1 & he_est2=1 & pc=2 -> (a'=0) & (pc'=3) ;
  [] cte_est0=1 & cte_est1=1 & cte_est2=1 & cte_est3=0 & cte_est4=1 & he_est0=0 & he_est1=0 & he_est2=1 & pc=2 -> (a'=1) & (pc'=3) ;
  [] cte_est0=1 & cte_est1=1 & cte_est2=1 & cte_est3=0 & cte_est4=1 & he_est0=0 & he_est1=1 & he_est2=0 & pc=2 -> (a'=0) & (pc'=3) ;
  [] cte_est0=1 & cte_est1=1 & cte_est2=1 & cte_est3=0 & cte_est4=1 & he_est0=0 & he_est1=1 & he_est2=0 & pc=2 -> (a'=2) & (pc'=3) ;
  [] cte_est0=1 & cte_est1=1 & cte_est2=1 & cte_est3=0 & cte_est4=1 & he_est0=0 & he_est1=1 & he_est2=1 & pc=2 -> (a'=0) & (alpha'=alpha+1) & (pc'=3) ;
  [] cte_est0=1 & cte_est1=1 & cte_est2=1 & cte_est3=0 & cte_est4=1 & he_est0=1 & he_est1=0 & he_est2=0 & pc=2 -> (a'=0) & (pc'=3) ;
  [] cte_est0=1 & cte_est1=1 & cte_est2=1 & cte_est3=0 & cte_est4=1 & he_est0=1 & he_est1=0 & he_est2=0 & pc=2 -> (a'=1) & (pc'=3) ;
  [] cte_est0=1 & cte_est1=1 & cte_est2=1 & cte_est3=0 & cte_est4=1 & he_est0=1 & he_est1=0 & he_est2=1 & pc=2 -> (a'=1) & (pc'=3) ;
  [] cte_est0=1 & cte_est1=1 & cte_est2=1 & cte_est3=0 & cte_est4=1 & he_est0=1 & he_est1=1 & he_est2=0 & pc=2 -> (a'=0) & (pc'=3) ;
  [] cte_est0=1 & cte_est1=1 & cte_est2=1 & cte_est3=0 & cte_est4=1 & he_est0=1 & he_est1=1 & he_est2=1 & pc=2 -> (a'=0) & (alpha'=alpha+1) & (pc'=3) ;
  [] cte_est0=1 & cte_est1=1 & cte_est2=1 & cte_est3=1 & cte_est4=0 & he_est0=0 & he_est1=0 & he_est2=1 & pc=2 -> (a'=0) & (pc'=3) ;
  [] cte_est0=1 & cte_est1=1 & cte_est2=1 & cte_est3=1 & cte_est4=0 & he_est0=0 & he_est1=0 & he_est2=1 & pc=2 -> (a'=1) & (pc'=3) ;
  [] cte_est0=1 & cte_est1=1 & cte_est2=1 & cte_est3=1 & cte_est4=0 & he_est0=0 & he_est1=1 & he_est2=0 & pc=2 -> (a'=2) & (pc'=3) ;
  [] cte_est0=1 & cte_est1=1 & cte_est2=1 & cte_est3=1 & cte_est4=0 & he_est0=0 & he_est1=1 & he_est2=1 & pc=2 -> (a'=0) & (alpha'=alpha+1) & (pc'=3) ;
  [] cte_est0=1 & cte_est1=1 & cte_est2=1 & cte_est3=1 & cte_est4=0 & he_est0=1 & he_est1=0 & he_est2=0 & pc=2 -> (a'=0) & (pc'=3) ;
  [] cte_est0=1 & cte_est1=1 & cte_est2=1 & cte_est3=1 & cte_est4=0 & he_est0=1 & he_est1=0 & he_est2=0 & pc=2 -> (a'=2) & (pc'=3) ;
  [] cte_est0=1 & cte_est1=1 & cte_est2=1 & cte_est3=1 & cte_est4=0 & he_est0=1 & he_est1=0 & he_est2=1 & pc=2 -> (a'=0) & (pc'=3) ;
  [] cte_est0=1 & cte_est1=1 & cte_est2=1 & cte_est3=1 & cte_est4=0 & he_est0=1 & he_est1=1 & he_est2=0 & pc=2 -> (a'=2) & (pc'=3) ;
  [] cte_est0=1 & cte_est1=1 & cte_est2=1 & cte_est3=1 & cte_est4=0 & he_est0=1 & he_est1=1 & he_est2=1 & pc=2 -> (a'=0) & (alpha'=alpha+1) & (pc'=3) ;
  [] cte_est0=1 & cte_est1=1 & cte_est2=1 & cte_est3=1 & cte_est4=1 & he_est0=0 & he_est1=0 & he_est2=1 & pc=2 -> (a'=1) & (pc'=3) ;
  [] cte_est0=1 & cte_est1=1 & cte_est2=1 & cte_est3=1 & cte_est4=1 & he_est0=0 & he_est1=1 & he_est2=0 & pc=2 -> (a'=2) & (pc'=3) ;
  [] cte_est0=1 & cte_est1=1 & cte_est2=1 & cte_est3=1 & cte_est4=1 & he_est0=0 & he_est1=1 & he_est2=1 & pc=2 -> (a'=0) & (alpha'=alpha+1) & (pc'=3) ;
  [] cte_est0=1 & cte_est1=1 & cte_est2=1 & cte_est3=1 & cte_est4=1 & he_est0=1 & he_est1=0 & he_est2=0 & pc=2 -> (a'=0) & (pc'=3) ;
  [] cte_est0=1 & cte_est1=1 & cte_est2=1 & cte_est3=1 & cte_est4=1 & he_est0=1 & he_est1=0 & he_est2=1 & pc=2 -> (a'=0) & (alpha'=alpha+1) & (pc'=3) ;
  [] cte_est0=1 & cte_est1=1 & cte_est2=1 & cte_est3=1 & cte_est4=1 & he_est0=1 & he_est1=1 & he_est2=0 & pc=2 -> (a'=0) & (alpha'=alpha+1) & (pc'=3) ;
  [] cte_est0=1 & cte_est1=1 & cte_est2=1 & cte_est3=1 & cte_est4=1 & he_est0=1 & he_est1=1 & he_est2=1 & pc=2 -> (a'=0) & (alpha'=alpha+1) & (pc'=3) ;

  // Dynamics
  
  [] he=1 & a=1 & pc=3 -> 1 : (he'=-1) & (pc'=-1); // error
  [] he=2 & a=2 & pc=3 -> 1 : (he'=-1) & (pc'=-1); // error
  [] cte=0 & he=0 & a=0 & pc=3 -> 1 : (pc'=4);
  [] cte=0 & he=0 & a=1 & pc=3 -> 1 : (cte'=1) & (he'=1) & (pc'=4);
  [] cte=0 & he=0 & a=2 & pc=3 -> 1 : (cte'=2) & (he'=2) & (pc'=4);
  [] cte=0 & he=1 & a=0 & pc=3 -> 1 : (cte'=1) & (pc'=4);
  [] cte=0 & he=1 & a=2 & pc=3 -> 1 : (he'=0) & (pc'=4);
  [] cte=0 & he=2 & a=0 & pc=3 -> 1 : (cte'=2) & (pc'=4);
  [] cte=0 & he=2 & a=1 & pc=3 -> 1 : (he'=0) & (pc'=4);
  // left -side dynamics:
  [] cte=1 & he=0 & a=0 & pc=3 -> 1 : (pc'=4);
  [] cte=1 & he=0 & a=1 & pc=3 -> 1 : (cte'=3) & (he'=1) & (pc'=4);
  [] cte=1 & he=0 & a=2 & pc=3 -> 1 : (cte'=0) & (he'=2) & (pc'=4);
  [] cte=1 & he=1 & a=0 & pc=3 -> 1 : (cte'=3) & (pc'=4);
  [] cte=1 & he=1 & a=2 & pc=3 -> 1 : (he'=0) & (pc'=4);
  [] cte=1 & he=2 & a=0 & pc=3 -> 1 : (cte'=0) & (pc'=4);
  [] cte=1 & he=2 & a=1 & pc=3 -> 1 : (he'=0) & (pc'=4);
  [] cte=3 & he=0 & a=0 & pc=3 -> 1 : (pc'=4);
  [] cte=3 & he=0 & a=1 & pc=3 -> 1 : (cte'=-1) & (pc'=-1); // error
  [] cte=3 & he=0 & a=2 & pc=3 -> 1 : (cte'=1) & (he'=2) & (pc'=4);
  [] cte=3 & he=1 & a=0 & pc=3 -> 1 : (cte'=-1) & (pc'=-1); // error
  [] cte=3 & he=1 & a=2 & pc=3 -> 1 : (he'=0) & (pc'=4);
  [] cte=3 & he=2 & a=0 & pc=3 -> 1 : (cte'=1) & (pc'=4);
  [] cte=3 & he=2 & a=1 & pc=3 -> 1 : (he'=0) & (pc'=4);
  // right -side dynamics:
  [] cte=2 & he=0 & a=0 & pc=3 -> 1 : (pc'=4);
  [] cte=2 & he=0 & a=1 & pc=3 -> 1 : (cte'=0) & (he'=1) & (pc'=4);
  [] cte=2 & he=0 & a=2 & pc=3 -> 1 : (cte'=4) & (he'=2) & (pc'=4);
  [] cte=2 & he=1 & a=0 & pc=3 -> 1 : (cte'=0) & (pc'=4);
  [] cte=2 & he=1 & a=2 & pc=3 -> 1 : (he'=0) & (pc'=4);
  [] cte=2 & he=2 & a=0 & pc=3 -> 1 : (cte'=4) & (pc'=4);
  [] cte=2 & he=2 & a=1 & pc=3 -> 1 : (he'=0) & (pc'=4);
  [] cte=4 & he=0 & a=0 & pc=3 -> 1 : (pc'=4);
  [] cte=4 & he=0 & a=1 & pc=3 -> 1 : (cte'=2) & (he'=1) & (pc'=4);
  [] cte=4 & he=0 & a=2 & pc=3 -> 1 : (cte'=-1) & (pc'=-1); // error
  [] cte=4 & he=1 & a=0 & pc=3 -> 1 : (cte'=2) & (pc'=4);
  [] cte=4 & he=1 & a=2 & pc=3 -> 1 : (he'=0) & (pc'=4);
  [] cte=4 & he=2 & a=0 & pc=3 -> 1 : (cte'=-1) & (pc'=-1); // error
  [] cte=4 & he=2 & a=1 & pc=3 -> 1 : (he'=0) & (pc'=4);
  



  // Loop Logic
  [] pc=4 & k<N -> 1 : (pc'=0) & (k'=k+1) ;


endmodule

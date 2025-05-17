mdp

const double prob_success=1.0;
const double prob_fail=(1-prob_success)/4;

init  cte=0 & he=0 & cte_est=0 & he_est=0 & pc=1 & a=-1 & crash=0 endinit

module taxinet

	//  state
	cte : [-1..4];
	// cte=0: on centerline
	// cte=1: left of centerline
	// cte=2: right of centerline
	// cte=3: more left
 	// cte=4: more right
	// cte=-1: off runway ERROR STATE

	he: [-1..2];
	// he=0: no angle
	// he=1: negative
	// he=2: positive
	// he=-1: ERROR

	// estimate of the state from NN
	cte_est: [0..4];
	he_est: [0..2]; 
	

  	// program counter
	pc:[1..5]; 
	// 5 is now "sink state"

	// actions issued by controller
	a:[-1..2];
	// a=-1: still to decide 
	// a=0: go straight
	// a=1: turn left
	// a=2: turn right

	// NN perfect perception 
	[] cte=0 & pc=1 -> prob_success: (cte_est'=0) & (pc'=2) + 
				 prob_fail: (cte_est'=1) & (pc'=2) + 
				 prob_fail: (cte_est'=2) & (pc'=2) + 
				 prob_fail: (cte_est'=3) & (pc'=2) + 
				 prob_fail: (cte_est'=4) & (pc'=2);
	[] cte=1 & pc=1 -> prob_fail: (cte_est'=0) & (pc'=2) + 
				 prob_success: (cte_est'=1) & (pc'=2) + 
				 prob_fail: (cte_est'=2) & (pc'=2) + 
				 prob_fail: (cte_est'=3) & (pc'=2) + 
				 prob_fail: (cte_est'=4) & (pc'=2);
	[] cte=2 & pc=1 -> prob_fail: (cte_est'=0) & (pc'=2) + 
				 prob_fail: (cte_est'=1) & (pc'=2) + 
				 prob_success: (cte_est'=2) & (pc'=2) + 
				 prob_fail: (cte_est'=3) & (pc'=2) + 
				 prob_fail: (cte_est'=4) & (pc'=2);
	[] cte=3 & pc=1 -> prob_fail: (cte_est'=0) & (pc'=2) + 
				 prob_fail: (cte_est'=1) & (pc'=2) + 
				 prob_fail: (cte_est'=2) & (pc'=2) + 
				 prob_success: (cte_est'=3) & (pc'=2) + 
				 prob_fail: (cte_est'=4) & (pc'=2);
	[] cte=4 & pc=1 -> prob_fail: (cte_est'=0) & (pc'=2) + 
				 prob_fail: (cte_est'=1) & (pc'=2) + 
				 prob_fail: (cte_est'=2) & (pc'=2) + 
				 prob_fail: (cte_est'=3) & (pc'=2) + 
				 prob_success: (cte_est'=4) & (pc'=2);


	[] he=0 & pc=2 -> prob_success: (he_est'=0) & (pc'=3) + prob_fail: (he_est'=1) & (pc'=3) + prob_fail: (he_est'=2) & (pc'=3); 	
	[] he=1 & pc=2 -> prob_fail: (he_est'=0) & (pc'=3) + prob_success: (he_est'=1) & (pc'=3) + prob_fail: (he_est'=2) & (pc'=3);
	[] he=2 & pc=2 -> prob_fail: (he_est'=0) & (pc'=3) + prob_fail: (he_est'=1) & (pc'=3) + prob_success: (he_est'=2) & (pc'=3);


	// Select actions
	//prob_success:(a'=)&pc'=4 + 0.0prob_fail'=)&(pc'=4) + 0.05prob_fail)&(pc'=4);

	/// CTE=0 ///
	[] cte_est=0 & he_est=0 & pc=3 -> (a'=0)&(pc'=4);	
	[] cte_est=0 & he_est=0 & pc=3 -> (a'=1)&(pc'=4);	
	[] cte_est=0 & he_est=0 & pc=3 -> (a'=2)&(pc'=4);	
	
	[] cte_est=0 & he_est=1 & pc=3 -> (a'=0)&(pc'=4);	
	[] cte_est=0 & he_est=1 & pc=3 -> (a'=1)&(pc'=4);	
	[] cte_est=0 & he_est=1 & pc=3 -> (a'=2)&(pc'=4);	

	[] cte_est=0 & he_est=2 & pc=3 -> (a'=0)&(pc'=4);	
	[] cte_est=0 & he_est=2 & pc=3 -> (a'=1)&(pc'=4);	
	[] cte_est=0 & he_est=2 & pc=3 -> (a'=2)&(pc'=4);	
	
	/// CTE=1 ///
	[] cte_est=1 & he_est=0 & pc=3 -> (a'=0)&(pc'=4);	
	[] cte_est=1 & he_est=0 & pc=3 -> (a'=1)&(pc'=4);	
	[] cte_est=1 & he_est=0 & pc=3 -> (a'=2)&(pc'=4);	
	
	[] cte_est=1 & he_est=1 & pc=3 -> (a'=0)&(pc'=4);	
	[] cte_est=1 & he_est=1 & pc=3 -> (a'=1)&(pc'=4);	
	[] cte_est=1 & he_est=1 & pc=3 -> (a'=2)&(pc'=4);	

	[] cte_est=1 & he_est=2 & pc=3 -> (a'=0)&(pc'=4);	
	[] cte_est=1 & he_est=2 & pc=3 -> (a'=1)&(pc'=4);	
	[] cte_est=1 & he_est=2 & pc=3 -> (a'=2)&(pc'=4);	
	
	/// CTE=2 ///
	[] cte_est=2 & he_est=0 & pc=3 -> (a'=0)&(pc'=4);	
	[] cte_est=2 & he_est=0 & pc=3 -> (a'=1)&(pc'=4);	
	[] cte_est=2 & he_est=0 & pc=3 -> (a'=2)&(pc'=4);	
	
	[] cte_est=2 & he_est=1 & pc=3 -> (a'=0)&(pc'=4);	
	[] cte_est=2 & he_est=1 & pc=3 -> (a'=1)&(pc'=4);	
	[] cte_est=2 & he_est=1 & pc=3 -> (a'=2)&(pc'=4);	

	[] cte_est=2 & he_est=2 & pc=3 -> (a'=0)&(pc'=4);	
	[] cte_est=2 & he_est=2 & pc=3 -> (a'=1)&(pc'=4);	
	[] cte_est=2 & he_est=2 & pc=3 -> (a'=2)&(pc'=4);	
	
	/// CTE=3 ///
	[] cte_est=3 & he_est=0 & pc=3 -> (a'=0)&(pc'=4);	
	[] cte_est=3 & he_est=0 & pc=3 -> (a'=1)&(pc'=4);	
	[] cte_est=3 & he_est=0 & pc=3 -> (a'=2)&(pc'=4);	
	
	[] cte_est=3 & he_est=1 & pc=3 -> (a'=0)&(pc'=4);	
	[] cte_est=3 & he_est=1 & pc=3 -> (a'=1)&(pc'=4);	
	[] cte_est=3 & he_est=1 & pc=3 -> (a'=2)&(pc'=4);	

	[] cte_est=3 & he_est=2 & pc=3 -> (a'=0)&(pc'=4);	
	[] cte_est=3 & he_est=2 & pc=3 -> (a'=1)&(pc'=4);	
	[] cte_est=3 & he_est=2 & pc=3 -> (a'=2)&(pc'=4);	
	
	/// CTE=4 ///
	[] cte_est=4 & he_est=0 & pc=3 -> (a'=0)&(pc'=4);	
	[] cte_est=4 & he_est=0 & pc=3 -> (a'=1)&(pc'=4);	
	[] cte_est=4 & he_est=0 & pc=3 -> (a'=2)&(pc'=4);	
	
	[] cte_est=4 & he_est=1 & pc=3 -> (a'=0)&(pc'=4);	
	[] cte_est=4 & he_est=1 & pc=3 -> (a'=1)&(pc'=4);	
	[] cte_est=4 & he_est=1 & pc=3 -> (a'=2)&(pc'=4);	

	[] cte_est=4 & he_est=2 & pc=3 -> (a'=0)&(pc'=4);	
	[] cte_est=4 & he_est=2 & pc=3 -> (a'=1)&(pc'=4);	
	[] cte_est=4 & he_est=2 & pc=3 -> (a'=2)&(pc'=4);	
	
	// airplane and environment: 
	[] he=1 & a=1 & pc=4 -> 1 : (he'=-1) & (pc'=5); // error
	[] he=2 & a=2 & pc=4 -> 1 : (he'=-1) & (pc'=5); // error

	[] cte=0 & he=0 & a=0 & pc=4 -> 1 : (pc'=1) & (a'=-1);
	[] cte=0 & he=0 & a=1 & pc=4 -> 1 : (cte'=1) & (he'=1) & (pc'=1) & (a'=-1);
	[] cte=0 & he=0 & a=2 & pc=4 -> 1 : (cte'=2) & (he'=2) & (pc'=1) & (a'=-1);

	[] cte=0 & he=1 & a=0 & pc=4 -> 1 : (cte'=1) & (pc'=1) & (a'=-1);
	[] cte=0 & he=1 & a=2 & pc=4 -> 1 : (he'=0) & (pc'=1) & (a'=-1);

	[] cte=0 & he=2 & a=0 & pc=4 -> 1 : (cte'=2) & (pc'=1) & (a'=-1);
	[] cte=0 & he=2 & a=1 & pc=4 -> 1 : (he'=0) & (pc'=1) & (a'=-1);

	// left-side dynamics:
	[] cte=1 & he=0 & a=0 & pc=4 -> 1 : (pc'=1) & (a'=-1);
	[] cte=1 & he=0 & a=1 & pc=4 -> 1 : (cte'=3) & (he'=1) & (pc'=1) & (a'=-1);
	[] cte=1 & he=0 & a=2 & pc=4 -> 1 : (cte'=0) & (he'=2) & (pc'=1) & (a'=-1);

	[] cte=1 & he=1 & a=0 & pc=4 -> 1 : (cte'=3) & (pc'=1) & (a'=-1);
	[] cte=1 & he=1 & a=2 & pc=4 -> 1 : (he'=0) & (pc'=1) & (a'=-1);

	[] cte=1 & he=2 & a=0 & pc=4 -> 1 : (cte'=0) & (pc'=1) & (a'=-1);
	[] cte=1 & he=2 & a=1 & pc=4 -> 1 : (he'=0) & (pc'=1) & (a'=-1);

	[] cte=3 & he=0 & a=0 & pc=4 -> 1 : (pc'=1) & (a'=-1);
	[] cte=3 & he=0 & a=1 & pc=4 -> 1 : (cte'=-1) & (pc'=5); //error
	[] cte=3 & he=0 & a=2 & pc=4 -> 1 : (cte'=1) & (he'=2) & (pc'=1) & (a'=-1);

	[] cte=3 & he=1 & a=0 & pc=4 -> 1 : (cte'=-1) & (pc'=5); //error
	[] cte=3 & he=1 & a=2 & pc=4 -> 1 : (he'=0) & (pc'=1) & (a'=-1);

	[] cte=3 & he=2 & a=0 & pc=4 -> 1 : (cte'=1) & (pc'=1) & (a'=-1);
	[] cte=3 & he=2 & a=1 & pc=4 -> 1 : (he'=0) & (pc'=1) & (a'=-1);

	// right-side dynamics:
	[] cte=2 & he=0 & a=0 & pc=4 -> 1 : (pc'=1) & (a'=-1);
	[] cte=2 & he=0 & a=1 & pc=4 -> 1 : (cte'=0) & (he'=1) & (pc'=1) & (a'=-1);
	[] cte=2 & he=0 & a=2 & pc=4 -> 1 : (cte'=4) & (he'=2) & (pc'=1) & (a'=-1);

	[] cte=2 & he=1 & a=0 & pc=4 -> 1 : (cte'=0) & (pc'=1) & (a'=-1);
	[] cte=2 & he=1 & a=2 & pc=4 -> 1 : (he'=0) & (pc'=1) & (a'=-1);

	[] cte=2 & he=2 & a=0 & pc=4 -> 1 : (cte'=4) & (pc'=1) & (a'=-1);
	[] cte=2 & he=2 & a=1 & pc=4 -> 1 : (he'=0) & (pc'=1) & (a'=-1);

	[] cte=4 & he=0 & a=0 & pc=4 -> 1 : (pc'=1) & (a'=-1);
	[] cte=4 & he=0 & a=1 & pc=4 -> 1 : (cte'=2) & (he'=1) & (pc'=1) & (a'=-1);
	[] cte=4 & he=0 & a=2 & pc=4 -> 1 : (cte'=-1) & (pc'=5); //error

	[] cte=4 & he=1 & a=0 & pc=4 -> 1 : (cte'=2) & (pc'=1) & (a'=-1);
	[] cte=4 & he=1 & a=2 & pc=4 -> 1 : (he'=0) & (pc'=1) & (a'=-1);

	[] cte=4 & he=2 & a=0 & pc=4 -> 1 : (cte'=-1) & (pc'=5); //error
	[] cte=4 & he=2 & a=1 & pc=4 -> 1 : (he'=0) & (pc'=1) & (a'=-1);

endmodule

module crashed
	crash: [0..1];
	[] crash=0 & pc=5 -> 1:(crash'=1);
endmodule


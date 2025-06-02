mdp

const double dyn_suc=0.9;
const double dyn_fail=(1-dyn_suc)/2;

const int N;

init  cte=0 & he=0 & cte_est=0 & he_est=0 & pc=1 & a=-1 & crash=0 & k=1 endinit

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
	pc:[1..6]; 
	// 6 is now "sink state"

	k:[1..N];
	// actions issued by controller
	a:[-1..2];
	// a=-1: still to decide 
	// a=0: go straight
	// a=1: turn left
	// a=2: turn right

	// NN imperfect perception 
	[] cte=0 & k<N & pc=1 -> 0.994475138121547: (cte_est'=0) & (pc'=2) + 
				 0: (cte_est'=1) & (pc'=2) + 
				 0.0055248618784530384: (cte_est'=2) & (pc'=2) + 
				 0: (cte_est'=3) & (pc'=2) + 
				 0: (cte_est'=4) & (pc'=2)&(k'=k+1);
	[] cte=1 & k<N & pc=1 -> 0.20915032679738563: (cte_est'=0) & (pc'=2) + 
				 0.6862745098039216: (cte_est'=1) & (pc'=2) + 
				 0: (cte_est'=2) & (pc'=2) + 
				 0.10457516339869281: (cte_est'=3) & (pc'=2) + 
				 0: (cte_est'=4) & (pc'=2)&(k'=k+1);
	[] cte=2 & k<N & pc=1 -> 0.06666666666666667: (cte_est'=0) & (pc'=2) + 
				 0: (cte_est'=1) & (pc'=2) + 
				 0.9333333333333333: (cte_est'=2) & (pc'=2) + 
				 0: (cte_est'=3) & (pc'=2) + 
				 0: (cte_est'=4) & (pc'=2)&(k'=k+1);
	[] cte=3 & k<N & pc=1 -> 0: (cte_est'=0) & (pc'=2) + 
				 0.03896103896103896: (cte_est'=1) & (pc'=2) + 
				 0: (cte_est'=2) & (pc'=2) + 
				 0.961038961038961: (cte_est'=3) & (pc'=2) + 
				 0: (cte_est'=4) & (pc'=2)&(k'=k+1);
	[] cte=4 & k<N & pc=1 -> 0: (cte_est'=0) & (pc'=2) + 
				 0: (cte_est'=1) & (pc'=2) + 
				 0.19186046511627908: (cte_est'=2) & (pc'=2) + 
				 0: (cte_est'=3) & (pc'=2) + 
				 0.8081395348837209: (cte_est'=4) & (pc'=2)&(k'=k+1);


	[] he=0 & pc=2 -> 0.6838709677419355: (he_est'=0) & (pc'=3) + 0.21935483870967742: (he_est'=1) & (pc'=3) + 0.0967741935483871: (he_est'=2) & (pc'=3); 	
	[] he=1 & pc=2 -> 0.0: (he_est'=0) & (pc'=3) + 1.0: (he_est'=1) & (pc'=3) + 0.0: (he_est'=2) & (pc'=3);
	[] he=2 & pc=2 -> 0.01744186046511628: (he_est'=0) & (pc'=3) + 0.0: (he_est'=1) & (pc'=3) + 0.9825581395348837: (he_est'=2) & (pc'=3);


	// Select actions
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

	// action selection stochasticity
	[] a=0 & pc=4 -> dyn_suc: (a'=0) & (pc'=5) + dyn_fail: (a'=1) & (pc'=5) + dyn_fail: (a'=2) & (pc'=5);
	[] a=1 & pc=4 -> dyn_suc: (a'=1) & (pc'=5) + dyn_fail: (a'=0) & (pc'=5) + dyn_fail: (a'=2) & (pc'=5);
	[] a=2 & pc=4 -> dyn_suc: (a'=2) & (pc'=5) + dyn_fail: (a'=0) & (pc'=5) + dyn_fail: (a'=1) & (pc'=5);
	
	// airplane and environment: 
	[] he=1 & a=1 & pc=5 -> 1 : (he'=-1) & (pc'=6); // error
	[] he=2 & a=2 & pc=5 -> 1 : (he'=-1) & (pc'=6); // error

	[] cte=0 & he=0 & a=0 & pc=5 -> 1 : (pc'=1) & (a'=-1);
	[] cte=0 & he=0 & a=1 & pc=5 -> 1 : (cte'=1) & (he'=1) & (pc'=1) & (a'=-1);
	[] cte=0 & he=0 & a=2 & pc=5 -> 1 : (cte'=2) & (he'=2) & (pc'=1) & (a'=-1);

	[] cte=0 & he=1 & a=0 & pc=5 -> 1 : (cte'=1) & (pc'=1) & (a'=-1);
	[] cte=0 & he=1 & a=2 & pc=5 -> 1 : (he'=0) & (pc'=1) & (a'=-1);

	[] cte=0 & he=2 & a=0 & pc=5 -> 1 : (cte'=2) & (pc'=1) & (a'=-1);
	[] cte=0 & he=2 & a=1 & pc=5 -> 1 : (he'=0) & (pc'=1) & (a'=-1);

	// left-side dynamics:
	[] cte=1 & he=0 & a=0 & pc=5 -> 1 : (pc'=1) & (a'=-1);
	[] cte=1 & he=0 & a=1 & pc=5 -> 1 : (cte'=3) & (he'=1) & (pc'=1) & (a'=-1);
	[] cte=1 & he=0 & a=2 & pc=5 -> 1 : (cte'=0) & (he'=2) & (pc'=1) & (a'=-1);

	[] cte=1 & he=1 & a=0 & pc=5 -> 1 : (cte'=3) & (pc'=1) & (a'=-1);
	[] cte=1 & he=1 & a=2 & pc=5 -> 1 : (he'=0) & (pc'=1) & (a'=-1);

	[] cte=1 & he=2 & a=0 & pc=5 -> 1 : (cte'=0) & (pc'=1) & (a'=-1);
	[] cte=1 & he=2 & a=1 & pc=5 -> 1 : (he'=0) & (pc'=1) & (a'=-1);

	[] cte=3 & he=0 & a=0 & pc=5 -> 1 : (pc'=1) & (a'=-1);
	[] cte=3 & he=0 & a=1 & pc=5 -> 1 : (cte'=-1) & (pc'=6); //error
	[] cte=3 & he=0 & a=2 & pc=5 -> 1 : (cte'=1) & (he'=2) & (pc'=1) & (a'=-1);

	[] cte=3 & he=1 & a=0 & pc=5 -> 1 : (cte'=-1) & (pc'=6); //error
	[] cte=3 & he=1 & a=2 & pc=5 -> 1 : (he'=0) & (pc'=1) & (a'=-1);

	[] cte=3 & he=2 & a=0 & pc=5 -> 1 : (cte'=1) & (pc'=1) & (a'=-1);
	[] cte=3 & he=2 & a=1 & pc=5 -> 1 : (he'=0) & (pc'=1) & (a'=-1);

	// right-side dynamics:
	[] cte=2 & he=0 & a=0 & pc=5 -> 1 : (pc'=1) & (a'=-1);
	[] cte=2 & he=0 & a=1 & pc=5 -> 1 : (cte'=0) & (he'=1) & (pc'=1) & (a'=-1);
	[] cte=2 & he=0 & a=2 & pc=5 -> 1 : (cte'=4) & (he'=2) & (pc'=1) & (a'=-1);

	[] cte=2 & he=1 & a=0 & pc=5 -> 1 : (cte'=0) & (pc'=1) & (a'=-1);
	[] cte=2 & he=1 & a=2 & pc=5 -> 1 : (he'=0) & (pc'=1) & (a'=-1);

	[] cte=2 & he=2 & a=0 & pc=5 -> 1 : (cte'=4) & (pc'=1) & (a'=-1);
	[] cte=2 & he=2 & a=1 & pc=5 -> 1 : (he'=0) & (pc'=1) & (a'=-1);

	[] cte=4 & he=0 & a=0 & pc=5 -> 1 : (pc'=1) & (a'=-1);
	[] cte=4 & he=0 & a=1 & pc=5 -> 1 : (cte'=2) & (he'=1) & (pc'=1) & (a'=-1);
	[] cte=4 & he=0 & a=2 & pc=5 -> 1 : (cte'=-1) & (pc'=6); //error

	[] cte=4 & he=1 & a=0 & pc=5 -> 1 : (cte'=2) & (pc'=1) & (a'=-1);
	[] cte=4 & he=1 & a=2 & pc=5 -> 1 : (he'=0) & (pc'=1) & (a'=-1);

	[] cte=4 & he=2 & a=0 & pc=5 -> 1 : (cte'=-1) & (pc'=6); //error
	[] cte=4 & he=2 & a=1 & pc=5 -> 1 : (he'=0) & (pc'=1) & (a'=-1);

endmodule

module crashed
	crash: [0..1];
	[] crash=0 & pc=6 -> 1:(crash'=1);
endmodule


dtmc

const N;

module taxinet

	//  state
	cte : [-1..4] init 0;
	// cte=0: on centerline
	// cte=1: left of centerline
	// cte=2: right of centerline
	// cte=3: more left
 	// cte=4: more right
	// cte=-1: off runway ERROR STATE

	he: [-1..2] init 0;
	// he=0: no angle
	// he=1: negative
	// he=2: positive
	// he=-1: ERROR

	// encoding result of run-time guard
	v: [0..1] init 1;
	// v=1: certified
	// v=0: not certified

	// estimate of the state from NN
	cte_est: [0..4] init 0;
	he_est: [0..2] init 0; 
	
	// actions issued by controller
	a: [0 .. 2] init 0; 
	// a=0: go straight
	// a=1: turn left
	// a=2: turn right

  	// program counter
	pc:[0..5] init 0; 
	// 5 is now "sink state"

	// steps
	k:[1..N] init 1;

	// run-time guard: assume we can certify all inputs	
	[]  pc=0 -> 1: (v'=1) & (pc'=1);	

	// NN perfect perception 
	[] cte=0 & v=1 & pc=1 -> 1.0: (cte_est'=0) & (pc'=2) + 
				 0.0: (cte_est'=1) & (pc'=2) + 
				 0.0: (cte_est'=2) & (pc'=2) + 
				 0.0: (cte_est'=3) & (pc'=2) + 
				 0.0: (cte_est'=4) & (pc'=2);
	[] cte=1 & v=1 & pc=1 -> 0.0: (cte_est'=0) & (pc'=2) + 
				 1.0: (cte_est'=1) & (pc'=2) + 
				 0.0: (cte_est'=2) & (pc'=2) + 
				 0.0: (cte_est'=3) & (pc'=2) + 
				 0.0: (cte_est'=4) & (pc'=2);
	[] cte=2 & v=1 & pc=1 -> 0.0: (cte_est'=0) & (pc'=2) + 
				 0.0: (cte_est'=1) & (pc'=2) + 
				 1.0: (cte_est'=2) & (pc'=2) + 
				 0.0: (cte_est'=3) & (pc'=2) + 
				 0.0: (cte_est'=4) & (pc'=2);
	[] cte=3 & v=1 & pc=1 -> 0.0: (cte_est'=0) & (pc'=2) + 
				 0.0: (cte_est'=1) & (pc'=2) + 
				 0.0: (cte_est'=2) & (pc'=2) + 
				 1.0: (cte_est'=3) & (pc'=2) + 
				 0.0: (cte_est'=4) & (pc'=2);
	[] cte=4 & v=1 & pc=1 -> 0.0: (cte_est'=0) & (pc'=2) + 
				 0.0: (cte_est'=1) & (pc'=2) + 
				 0.0: (cte_est'=2) & (pc'=2) + 
				 0.0: (cte_est'=3) & (pc'=2) + 
				 1.0: (cte_est'=4) & (pc'=2);


	[] he=0 & v=1 & pc=2 -> 1.0: (he_est'=0) & (pc'=3) + 0.0: (he_est'=1) & (pc'=3) + 0.0: (he_est'=2) & (pc'=3); 	
	[] he=1 & v=1 & pc=2 -> 0.0: (he_est'=0) & (pc'=3) + 1.0: (he_est'=1) & (pc'=3) + 0.0: (he_est'=2) & (pc'=3);
	[] he=2 & v=1 & pc=2 -> 0.0: (he_est'=0) & (pc'=3) + 0.0: (he_est'=1) & (pc'=3) + 1.0: (he_est'=2) & (pc'=3);

	
	//controller: 
	[] cte_est=0 & he_est=0 & pc=3 -> 1 : (a'=0) & (pc'=4);
	[] cte_est=0 & he_est=1 & pc=3 -> 1 : (a'=2) & (pc'=4);
	[] cte_est=0 & he_est=2 & pc=3 -> 1 : (a'=1) & (pc'=4);
	
	[] (cte_est=1 | cte_est=3) & he_est=0 & pc=3 -> 1 : (a'=2) & (pc'=4);
	[] (cte_est=1 | cte_est=3) & he_est=1 & pc=3 -> 1 : (a'=2) & (pc'=4);
	[] (cte_est=1 | cte_est=3) & he_est=2 & pc=3 -> 1 : (a'=0) & (pc'=4);
	
	[] (cte_est=2 | cte_est=4) & he_est=0 & pc=3 -> 1 : (a'=1) & (pc'=4);
	[] (cte_est=2 | cte_est=4) & he_est=1 & pc=3 -> 1 : (a'=0) & (pc'=4);
	[] (cte_est=2 | cte_est=4) & he_est=2 & pc=3 -> 1 : (a'=1) & (pc'=4);

	// airplane and environment: 
	[] he=1 & a=1 & pc=4 & k<N -> 1 : (he'=-1) & (pc'=5); // error
	[] he=2 & a=2 & pc=4 & k<N -> 1 : (he'=-1) & (pc'=5); // error

	[] cte=0 & he=0 & a=0 & pc=4 & k<N -> 1 : (pc'=0) & (k'=k+1);
	[] cte=0 & he=0 & a=1 & pc=4 & k<N -> 1 : (cte'=1) & (he'=1) & (pc'=0) & (k'=k+1);
	[] cte=0 & he=0 & a=2 & pc=4 & k<N -> 1 : (cte'=2) & (he'=2) & (pc'=0) & (k'=k+1);

	[] cte=0 & he=1 & a=0 & pc=4 & k<N -> 1 : (cte'=1) & (pc'=0) & (k'=k+1);
	[] cte=0 & he=1 & a=2 & pc=4 & k<N -> 1 : (he'=0) & (pc'=0) & (k'=k+1);

	[] cte=0 & he=2 & a=0 & pc=4 & k<N -> 1 : (cte'=2) & (pc'=0) & (k'=k+1);
	[] cte=0 & he=2 & a=1 & pc=4 & k<N -> 1 : (he'=0) & (pc'=0) & (k'=k+1);

	// left-side dynamics:
	[] cte=1 & he=0 & a=0 & pc=4 & k<N -> 1 : (pc'=0) & (k'=k+1);
	[] cte=1 & he=0 & a=1 & pc=4 & k<N -> 1 : (cte'=3) & (he'=1) & (pc'=0) & (k'=k+1);
	[] cte=1 & he=0 & a=2 & pc=4 & k<N -> 1 : (cte'=0) & (he'=2) & (pc'=0) & (k'=k+1);

	[] cte=1 & he=1 & a=0 & pc=4 & k<N -> 1 : (cte'=3) & (pc'=0) & (k'=k+1);
	[] cte=1 & he=1 & a=2 & pc=4 & k<N -> 1 : (he'=0) & (pc'=0) & (k'=k+1);

	[] cte=1 & he=2 & a=0 & pc=4 & k<N -> 1 : (cte'=0) & (pc'=0) & (k'=k+1);
	[] cte=1 & he=2 & a=1 & pc=4 & k<N -> 1 : (he'=0) & (pc'=0) & (k'=k+1);

	[] cte=3 & he=0 & a=0 & pc=4 & k<N -> 1 : (pc'=0) & (k'=k+1);
	[] cte=3 & he=0 & a=1 & pc=4 & k<N -> 1 : (cte'=-1) & (pc'=5); //error
	[] cte=3 & he=0 & a=2 & pc=4 & k<N -> 1 : (cte'=1) & (he'=2) & (pc'=0) & (k'=k+1);

	[] cte=3 & he=1 & a=0 & pc=4 & k<N -> 1 : (cte'=-1) & (pc'=5); //error
	[] cte=3 & he=1 & a=2 & pc=4 & k<N -> 1 : (he'=0) & (pc'=0) & (k'=k+1);

	[] cte=3 & he=2 & a=0 & pc=4 & k<N -> 1 : (cte'=1) & (pc'=0) & (k'=k+1);
	[] cte=3 & he=2 & a=1 & pc=4 & k<N -> 1 : (he'=0) & (pc'=0) & (k'=k+1);

	// right-side dynamics:
	[] cte=2 & he=0 & a=0 & pc=4 & k<N -> 1 : (pc'=0) & (k'=k+1);
	[] cte=2 & he=0 & a=1 & pc=4 & k<N -> 1 : (cte'=0) & (he'=1) & (pc'=0) & (k'=k+1);
	[] cte=2 & he=0 & a=2 & pc=4 & k<N -> 1 : (cte'=4) & (he'=2) & (pc'=0) & (k'=k+1);

	[] cte=2 & he=1 & a=0 & pc=4 & k<N -> 1 : (cte'=0) & (pc'=0) & (k'=k+1);
	[] cte=2 & he=1 & a=2 & pc=4 & k<N -> 1 : (he'=0) & (pc'=0) & (k'=k+1);

	[] cte=2 & he=2 & a=0 & pc=4 & k<N -> 1 : (cte'=4) & (pc'=0) & (k'=k+1);
	[] cte=2 & he=2 & a=1 & pc=4 & k<N -> 1 : (he'=0) & (pc'=0) & (k'=k+1);

	[] cte=4 & he=0 & a=0 & pc=4 & k<N -> 1 : (pc'=0) & (k'=k+1);
	[] cte=4 & he=0 & a=1 & pc=4 & k<N -> 1 : (cte'=2) & (he'=1) & (pc'=0) & (k'=k+1);
	[] cte=4 & he=0 & a=2 & pc=4 & k<N -> 1 : (cte'=-1) & (pc'=5); //error

	[] cte=4 & he=1 & a=0 & pc=4 & k<N -> 1 : (cte'=2) & (pc'=0) & (k'=k+1);
	[] cte=4 & he=1 & a=2 & pc=4 & k<N -> 1 : (he'=0) & (pc'=0) & (k'=k+1);

	[] cte=4 & he=2 & a=0 & pc=4 & k<N -> 1 : (cte'=-1) & (pc'=5); //error
	[] cte=4 & he=2 & a=1 & pc=4 & k<N -> 1 : (he'=0) & (pc'=0) & (k'=k+1);

endmodule

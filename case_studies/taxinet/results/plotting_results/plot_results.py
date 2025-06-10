from plot_functions import *

def makeFilename(filename):
	out_dir='../plots'
	return f"{out_dir}/{filename}"
## DC models
 ## ALL WORST CASE STRATEGIES
plotPareto('DC', makeFilename("pareto_front_DC.pdf"))

 ## CRASHING
plotLine('DC', f"Pmax=? [ (F pc=-1)&(G pc!=-2) ]:", "N", "Prob", makeFilename("DC_p_crash_not_use_DC.pdf"))
plotLine('DC', f"Pmax=? [ (F pc=-1) ]/Pmax=? [ (G pc!=-2) ]:", "N", "Prob", makeFilename("DC_p_crash_given_not_use_DC.pdf"))
plotLine('DC', f"Pmax=? [ (F pc=-1)&(G pc!=-2) ]/Pmax=? [ (G pc!=-2) ]:", "N", "Prob", makeFilename("DC_p_crash_and_not_use_DC_given_not_use_DC.pdf"))
plotLine('DC', f"Pmax=? [ (F pc=-1) ]:", "N", "Prob", makeFilename("DC_p_crash.pdf"))

 ## USING DC
plotLine('DC', f"Pmax=? [ F pc=-2 ]:", "N", "Prob", makeFilename("DC_p_use_DC.pdf"))
plotLine('DC', f"Pmax=? [ F pc=-2 ]/Pmax=? [ G pc!=-1 ]:", "N", "Prob", makeFilename("DC_p_use_DC_given_no_crash.pdf"))
plotLine('DC', f"Pmax=? [ (F pc=-2)&(G pc!=-1) ]/Pmax=? [ G pc!=-1 ]:", "N", "Prob", makeFilename("DC_p_use_DC_and_no_crash_given_no_crash.pdf"))

 ## SUCCEEDING
plotLine('DC', f"Pmin=? [ F k=N ]:", "N", "Prob", makeFilename("DC_p_success.pdf"))
plotLine('DC', f"Pmin=? [ (F k=N)&(G pc>0) ]:", "N", "Prob", makeFilename("DC_p_succeed_and_not_use_DC.pdf"))
plotLine('DC', f"Pmin=? [ (F k=N)&(G pc!=-2) ]/Pmin=? [ (F k=N) ]:", "N", "Prob", makeFilename("DC_p_succeed_and_no_DC_given_success.pdf"))
# plotLine('DC', f"Pmax=? [ pc!=-2 U<=N false ]:", "N", "Prob", makeFilename("DC_p_not_using_DC_for_N_steps.pdf")) ## Need to fix (should be Pmin)
plotLine('DC', f"Pmin=? [ pc>0 U k=N ]:", "N", "Prob", makeFilename("DC_p_not_crash_or_use_DC_until_N_steps.pdf"))

## NDC models
 ## ALL WORST CASE STRATEGIES
plotPareto('NDC', makeFilename("pareto_front_NDC.pdf"))

 ## CRASHING
plotLine('NDC', f"Pmax=? [ (F pc=-1)&(G pc!=-2) ]:", "N", "Prob", makeFilename("NDC_p_crash_not_get_stuck.pdf"))
plotLine('NDC', f"Pmax=? [ (F pc=-1) ]/Pmax=? [ (G pc!=-2) ]:", "N", "Prob", makeFilename("NDC_p_crash_given_never_gettin_stuck.pdf"))
plotLine('NDC', f"Pmax=? [ (F pc=-1)&(G pc!=-2) ]/Pmax=? [ (G pc!=-2) ]:", "N", "Prob", makeFilename("NDC_p_crash_and_get_stuck_DC_given_never_getting_stuck.pdf"))
plotLine('NDC', f"Pmax=? [ (F pc=-1) ]:", "N", "Prob", makeFilename("NDC_p_crash.pdf"))


 ## GETTING STUCK
plotLine('NDC', f"Pmax=? [ F pc=-2 ]:", "N", "Prob", makeFilename("NDC_p_get_stuck.pdf"))
plotLine('NDC', f"Pmax=? [ F pc=-2 ]/Pmax=? [ G pc!=-1 ]:", "N", "Prob", makeFilename("NDC_p_get_stuck_given_no_crash.pdf"))
plotLine('NDC', f"Pmax=? [ (F pc=-2)&(G pc!=-1) ]/Pmax=? [ G pc!=-1 ]:", "N", "Prob", makeFilename("NDC_p_not_get_stucl_and_no_crash_given_no_crash.pdf"))


 ## SUCCEEDING
plotLine('NDC', f"Pmin=? [ F k=N ]:", "N", "Prob", makeFilename("NDC_p_success.pdf"))
plotLine('NDC', f"Pmin=? [ (F k=N)&(G pc>0) ]:", "N", "Prob", makeFilename("NDC_p_succeed_and_no_crash_or_getting_stuck.pdf"))
plotLine('NDC', f"Pmin=? [ (F k=N)&(G pc!=-2) ]/Pmin=? [ (F k=N) ]:", "N", "Prob", makeFilename("NDC_p_succeed_and_not_get_stuck_given_success.pdf"))
# plotLine('NDC', f"Pmax=? [ pc!=-2 U<=N false ]:", "N", "Prob", makeFilename("NDC_p_not_getting_stuck_for_N_steps.pdf")) ## Need to fix (should be Pmin)
plotLine('NDC', f"Pmin=? [ pc>0 U k=N ]:", "N", "Prob", makeFilename("NDC_p_not_crash_or_get_stuck_until_N_steps.pdf"))
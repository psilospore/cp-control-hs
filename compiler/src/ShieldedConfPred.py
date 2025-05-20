#


class ShieldedConfPred:
    def __self__(self,shield,dynamics,state_vars,action_vars,var_list):
        # self.state_conf_mats=state_conf_mats
        self.sheild = shield # (action -> 2^state)
        self.dynamics_logic = dynamics_logic # component logic
        self.percievers = perceivers # [(state: String, state_estimates : [string], conf_mat : [state x 2^state_estimates -> Prob, (min:Int,Max:Int)])]
        self.action_vars=action_vars # [String] (allow more than on action variable?)
        self.state_estimates = state_estimates # [String]
        self.var_list = var_list # [PrismVar]
        self.fail_states = fail_states # {{"Controller,Dynamics"}->[String]}

    def generate_prism_model(self,description,action_filter):

        # perceivers
        perceiver_components = []
        for scm in self.state_conf_mats:
            perceiver_components.append(PC.define_perceiver_from_conf_mat("Perceiver ({scm[0]})",scm[0],scm[1]))

        # Controller
        tsc = TSC.tempest_shielded_controller(self.shield,lambda a_p : a_p[1]>action_filter, minimize)
        controller_component = PC.PrismComponent("Controller", self.state_estimates,action,self.fail_states["Controller"],tsc)

        # dynamics
        dynamics_component = PC.PrismComponent("Dynamics",state+action,state,fail_states["Dynamics"],self.dynamics_logic)
        
        components = perceiver_components + [controller_component,dynamics_component]
        fail_state_list = inner_reduce(lambda x,y : x+y,self.fail_states.values())


        return PLSM.PrismLoopingStateMachine("ShieldedConfPred",label,"mdp",components,self.var_list,fail_state_list,description=description)

    # def stats(self):
        
    #     def conf_pred_hit_ratios(data,var_low,var_high):
    #         diff = var_high+1-var_low
    #         hit_counts = [0]*diff
    #         total_counts = [0]*diff
        
    #         for d in data:
    #             dint = mapL(int,d)
    #             hit = dint[1+dint[0]]
    #             hit_counts[dint[0]]+=hit
    #             total_counts[dint[0]]+=1
                
    #         return mapL(lambda hc_tc : hc_tc[0]/hc_tc[1], zip(hit_counts,total_counts))

    #     # [(state: String, state_estimates : [string], conf_mat : [state x 2^state_estimates -> Prob])]

    #     hit_ratios = []
    #     for perceiver in self.perceivers:
    #         name,est_names,conf_mat,min_max = perceiver
    #         var_min,var_max = min_max
    #         var_hr = conf_pred_hit_ratio(conf_mat,var_min,var_max)
    #         hit_ratios = [
            

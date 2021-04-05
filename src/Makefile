program =   ./Fast-Downward/fast-downward.py
param   =   --search    "astar(blind())"

complete:
	$(program) sailor-domain.pddl sailor-instl.pddl $(param)
	@echo 'result:'
	@cat sas_plan
stingy-wizard:
	$(program) sailor-stingy-wizard-domain.pddl sailor-instl.pddl $(param)
	@echo 'result:'
	@cat sas_plan
no-dinghy-to-steal:
	$(program) sailor-no-dinghy-to-steal-domain.pddl sailor-instl.pddl $(param)
	@echo 'result:'
	@cat sas_plan
no-path-to-academy:
	$(program) sailor-no-path-to-academy-domain.pddl sailor-instl.pddl $(param)
	@echo 'result:'
	@cat sas_plan
no-pearl-in-sea:
	$(program) sailor-no-pearl-in-sea-domain.pddl sailor-instl.pddl $(param)
	@echo 'result:'
	@cat sas_plan

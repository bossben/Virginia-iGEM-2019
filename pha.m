clear
core = loadBiGGModel('iML1515');
model = core;
%add new Metabolites
model = addMetabolite(model, 'R_3hbcoa_c', 'metName', '(3R)-hydroxybutanoyl-CoA', 'metFormula', 'C25H38N7O18P3S', 'Charge', -4);
model = addMetabolite(model, 'phb_c', 'metName', '(3R)-hydroxybutanoate', 'metFormula', 'C4H7O3', 'Charge', -1);
%add new PHB reactions. phaA is already present as ACAT1r
model = addReaction(model, 'PHABr', 'reactionFormula', 'aacoa_c + h_c + nadph_c <=> nadp_c + R_3hbcoa_c');
model = addReaction(model, 'PHACr', 'reactionFormula', 'R_3hbcoa_c <=> phb_c + coa_c');
%create a demand reaction for phb output
model = addDemandReaction(model, {'phb_c'});
%associate new genes to reactions
model = changeGeneAssociation(model, 'ACACT1r', 'PhaA');
model = changeGeneAssociation(model, 'PHABr', 'PhaB');
model = changeGeneAssociation(model, 'PHACr', 'PhaC');
%change medium carbon source to phenylacetaldehyde
model = changeRxnBounds(model, 'EX_pacald_e', -10, 'l');
model = changeRxnBounds(model, 'EX_glc__D_e', 0, 'l');
%change objective to both phb and biomass reactions (doesn't work)
model = changeObjective(model, {'DM_phb_c';'BIOMASS_Ec_iML1515_core_75p37M'});
%run Cb model
solution = optimizeCbModel(model, 'max');
%print pertinent reaction fluxes
printFluxVector(model, solution.x, true, true);

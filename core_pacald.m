clear
core = loadBiGGModel('iML1515');
model = core;
model = changeRxnBounds(model, 'EX_pacald_e', -10, 'l');
model = changeRxnBounds(model, 'EX_glc__D_e', 0, 'l');
model = changeObjective(model, 'BIOMASS_Ec_iML1515_core_75p37M');
solution = optimizeCbModel(model, 'max');
printFluxVector(model, solution.x, true);
printFluxVector(model, solution.x, true, true);
surfNet(model, 'accoa',0,solution.x,1,1);

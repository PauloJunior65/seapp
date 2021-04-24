function [ trOut,trTarg,vOut,vTarg,tsOut,tsTarg ] = net_regression_array( tr,dado,output )

trOut = output(tr.trainInd);
vOut = output(tr.valInd);
tsOut = output(tr.testInd);
trTarg = dado.target(tr.trainInd);
vTarg = dado.target(tr.valInd);
tsTarg = dado.target(tr.testInd);

end
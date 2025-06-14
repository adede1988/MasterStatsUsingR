caseSim <- function(growth, time = 365, startVal = 1){
  output = rep(NA, time)
  output[1] = startVal
  for(ii in 2:time){
    output[ii] = output[ii-1]*growth
  }
  return(output)
  
}

caseSimVar <- function(growth, time = 365, startVal = 1){
  output = rep(NA, time)
  output[1] = startVal
  for(ii in 2:time){
    output[ii] = output[ii-1]*growth[ii]
  }
  return(output)
  
}
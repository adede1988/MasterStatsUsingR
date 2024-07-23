

sampSize = seq.int(10,500,50)

out = data.frame(sampSize = sampSize, 
           single = sampSize,
           mixed = sampSize)


for(ss in 1:length(sampSize)){


testd = rep(0,5000)
testd2 = rep(0,5000)

for(ii in 1:5000){
  x = rnorm(sampSize[ss])
  y = rnorm(sampSize[ss])
  nx <- length(x)
  ny <- length(y)
  mean_x <- mean(x)
  mean_y <- mean(y)
  sd_x <- sd(x)
  sd_y <- sd(y)
  pooled_sd <- sqrt(((nx - 1) * sd_x^2 + (ny - 1) * sd_y^2) / (nx + ny - 2))
  testd[ii] <- abs((mean_x - mean_y)) / pooled_sd
  
  pool = sample(c(0,1,2,3), 20, T)
  
  groupSwitch = sample(pool, sampSize[ss], T)
  
  # -1.38*4 + .5*3 + 1.5 + 2.5
  
  x = c(rnorm(sum(groupSwitch==0), -1, 3), 
        rnorm(sum(groupSwitch==1), .5, .25),
        rnorm(sum(groupSwitch==2), 1.5, 2),
        rnorm(sum(groupSwitch==3), 2.5, 5))
  # x = rnorm(sampSize[ss], 0, 100)
  y = rnorm(sampSize[ss])
  nx <- length(x)
  ny <- length(y)
  mean_x <- mean(x)
  mean_y <- mean(y)
  sd_x <- sd(x)
  sd_y <- sd(y)
  pooled_sd <- sqrt(((nx - 1) * sd_x^2 + (ny - 1) * sd_y^2) / (nx + ny - 2))
  testd2[ii] <- abs((mean_x - mean_y)) / pooled_sd
  
  
  
  
}

out$single[ss] = sum(testd>.2)
out$mixed[ss] = sum(testd2>.2)

}


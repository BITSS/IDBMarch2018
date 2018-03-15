#Plot the rate of at least one false positives
setEPS()
postscript("falsepositive.eps")
curve(1-(1-.05)^x, 0, 100, xlab="Number of tests", ylab="Rate")
title(main="Rate of at least one false positive by number of tests")
mtext(expression(paste(alpha,"=0.05")))
dev.off()




*Garret Christensen March 2018
*Examples of multiple-testing adjustments in Stata

*IF YOU DON'T HAVE IT INSTALLED:
* ssc install qqvalue
clear all
set seed 1492
set obs 10
gen p1=runiform()
gen p2=runiform(0,0.1)
gen p3=runiform(0.6,1)

forvalues X=1/3 {
 foreach method in bonferroni sidak holm holland hochberg simes yekutieli {
	qqvalue p`X', method(`method') qvalue(p`X'`method')
 }
}
*Note that with a collection of weak (high) p-values, many tests return
*a single p-value for all tests, and sometimes all p-values ==1

*SEE http://www.stata-journal.com/sjpdf.html?articlenum=st0209 for exact references



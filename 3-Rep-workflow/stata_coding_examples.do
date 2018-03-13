*Garret Christensen March 8, 2018
*This file serves as an example of several Stata commands that can increase reproducibility.

*Set the directory at the top with a global, then do everything with
*relative paths after that so you only have to change one line
global dir "/Users/garret/Box Sync/CEGA-Programs-BITSS/2_Programs/10_institutions_support/IDB/2_march_2018_workshop/IDBMarch2018"
*Isn't it annoying how Box Sync makes you have a space in your pathname, requiring quotes?
*I think so. Also, Macs and Unix are case-sensitive and use forwardslash /,
*Windows isn't and uses backslash \
* Use lower case and no spaces to make life easy across systems.
cd "$dir"

clear all
set more off
cap log close
log using stata_coding_examples.log, replace
*Set the seed if you do anything randomized
set seed 1492

/*Add a test to see if anything changes:
count if _merge!=3
if r(N)!=74 {
display "Unmatched observations changed!"
this isn’t a command-will throw error to get your attention //this deliberately is not a valid command
} 
*/


*Be careful sorting! See https://www.stata.com/support/faqs/programming/sorting-on-categorical-variables/
*I generate some X, Y pairs. But X isn't unique, so sorting only on X creates
*non-reproducible arbitrariness!
set obs 100
gen n=_n
gen x=floor(runiform()*10)+1 //0 to 10
gen y=floor(runiform()*2)+1 //0 to 2



*Sort one way
sort x
list n x y if _n<6

*Shuffle and sort again, and you don't get the same thing!
sort y
sort x
list n x y if _n<6

sort y
sort x, stable //This doesn't even solve it, but it does make them keep the same relative order as they had before.
list n x y if _n<6

sort x y //Well, this *would* solve it, by x y pairs aren't even unique. We need a truly unique ID combo.
list n x y if _n<6

*You also won't get the same thing for either of these if you re-run the script, even though the seed is set!

*Test that data hasn't changed (Note that this doesn't pick up sorting differences)
datasignature set
replace x=exp(ln(x))
datasignature confirm
*To verify that you have the same data as your co-author on separate machines:
if r(datasignature)!= "100:3(45533):3171321020:960816469" Bob you screwed this up!
display "If I got here I passed the test"



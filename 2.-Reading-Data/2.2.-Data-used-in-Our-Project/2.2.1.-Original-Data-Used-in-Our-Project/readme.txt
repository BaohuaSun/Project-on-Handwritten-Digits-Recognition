Here are some information given in the optdigits-orig.names from UCI website:
 
"Number of Instances
optdigits-orig.tra Training 1934
optdigits-orig.cv Validation 946
optdigits-orig.wdep Writer-dependent 943
optdigits-orig.windep Writer-independent 1797
All files contain a header which include relevant information. See 
NIST TR for details"
 
The original data provided in UCI Machine Learning Repository is a little hard to read. We modified the format a little, thus it is easy for us to write matlab code to parse the data. Below we introduce the details.
 
Here is the data in "optdigits-orig.cv.txt", you can find the file in Data From UCI Repository

"All files contain a header which include relevant information. See 
NIST TR for details."
 
This header is a little anoying when we read the data. We just want to make it a little easier.
 
What we did is to delete the headers in all the 4 files:
optdigits-orig.tra.txt
optdigits-orig.cv.txt
optdigits-orig.wdep.txt
optdigits-orig.windep.txt

For example, for
"optdigits-orig.cv.txt" in the left figure, we can see the header information like:
"BU handwritten digit database: E Alpaydin C Kaynak 1995
Cross-validation file
entwidth = 32
entheight = 32
depth = 1
density = 300
whitepix = 0
ntot = 946
ndigit = 946
nlower = 0
nupper = 0
nparag = 0
firstdigit = 0
lastdigit = 945
firstlower = 945
lastlower = 945
firstupper = 945
lastupper = 945
firstparag = 945
lastparag = 945"
are at the first few lines, which contains no data we are going to use. The data below are the one we really want to use.
 
 
 
 
 
For simplicity, we delete the headers, and here is the example for "optdigits-orig.cv.txt" after headers-deleted.

 
 
Following the same method, we delete the headers for all the 4 data files:
optdigits-orig.tra.txt
optdigits-orig.cv.txt
optdigits-orig.wdep.txt
optdigits-orig.windep.txt

and combine the first three files in order "optdigits-orig.tra.txt", "optdigits-orig.cv.txt", and "optdigits-orig.wdep.txt" together as the "TrainData.txt" as you can find in Original Data Used in Our Project ,
 
and rename the fourth file "optdigits-orig.windep.txt as the "TestData.txt" as you can find in Original Data Used in Our Project .
 
 
OK, we already prepared the original data files to be read by the matlab file-reading codes.

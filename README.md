README 
======

This is the README file for Norris, et al (in prep).  The definitive, updated version of this file is maintained at https://github.com/arlin/PenG_and_GLin/edit/master/README.md.  

## CONTACT

All questions or requests for further information may be addressed to Ryan Norris (ryanwnorris@gmail.com), Department of Evolution, Ecology and Organismal Biology, Ohio State University, 4240 Campus Dr., Lima, OH 45804, USA.  

## CONTENTS

Norris, et al (in review) present 2 new methods for imputing (from fossil data) informed Bayesian priors for phylogeny calibration.  The methods are called PenG (penultimate gap) and GLin (ghost lineage length).  The study includes a comparative evaluation of PenG and GLin with several methods, based on simulations.  

This archive contains simulated data and the results of applying various calibration methods.  It consists of a large number of small files in a hierarchy of directories.  For each of 3 given tree shapes, there are 1000 sub-directories with replicate simulations.  For further information, consult the Methods section of Norris, et al.  

## LABELS AND ABBREVIATIONS

There are a lot of abbreviations in the file names, so we'll present the list of abbreviations first, to make that more intelligible. 

* ad11 : abbreviated implementation of Dornburg, et al. (2012) 
* dorn : method of Dornburg, et al, 2012
* f4, f10, f25 : fossil densities of 1 per 4, 10, or 25 MY respectively 
* int : intermediate tree shape (((((A,B),C),D),(E,F)),(G,H))
* m08 : method of Marshall (2008)
* m08min : method of Marshall (2008) preventing posterior trees contrary to fossils
* pec : pectinate tree shape (A,(B,(C,(D,(E,(F,(G,H)))))))
* sym : symmetric tree shape (((A,B),(C,D)),((E,F),(G,H)))
 
## FILES
The files here contain two sets of results, a minor set of results concerning implementations of the method of Dornburg, et al., and a major set of results concerning the comparative evaluation of PenG, GLin, and other methods for inferring divergence times.

### Comparative evaluation.  

The comparative evaluation consists of 3 different types of tests
1. post hoc calibration of true tree
2. post-hoc calibration of the inferred tree
3. prior calibration with tree inference in a full Bayesian analysis

However, the top-level file structure reflects a different 3-part distinction, between the 3 different tree shapes, pec, sym and int (see abbreviations above). Within each subdirectory for a tree shape, there are 1000 subdirectories, each with a replicate.  

Each subdirectory for a replicate is named by its shape and iteration, and includes sub-directories for 3 fossil densities, like this: 

pec/ - containing all replicates for this tree shape 
	pec_4/ - containing replicate #4 files common to all fossil densities
		f4/ - containing results for fossil density 4
		f10/ - containing results for fossil density 10
		f25/ - containing results for fossil density 25

The top level for each replicate contains 		
* [shape]_[repl].tre - the true tree
* [shape]_[repl]_ultra.tre - the ultrametric tree generated from BEAST
* [shape]_[repl]branches.txt - branch lengths of the true tree
* [shape]_[repl]nodes.txt - ages of nodes for the true tree
* [shape]_[repl]uncal.txt - ages of nodes for the uncalibrated BEAST tree
* f4, f10, f25 - subdirectories for each level of fossilization 

Then, for each level of fossilization, we have the following (the code for branches is simply an 8-value bit string indicating which of the 8 taxa descend from a branch):
* [01]{8} - simulated fossil dates for branch identified by file name
* [shape]_[repl]_[density].anc_tree - file from indelSeqGen
* [shape]_[repl]_[density].ma - file from indelSeqGen
* [shape]_[repl]_[density].root - file from indelSeqGen
* [shape]_[repl]_[density].scale_tree - file from indelSeqGen
* [shape]_[repl]_[density].seq - simulated sequences from indelSeqGen
* [shape]_[repl]_[density].trace - file from indelSeqGen

As well as
* [shape]_[repl]_[density]_[method].xml - BEAST input file for given method
* [shape]_[repl]_[density]_[method].tre - BEAST output tree for given method
* [shape]_[repl]_[density]_[method].txt - age estimates on each node for test of bias

where the methods are named using the same abbreviations as in the text: "obs", "ad11", "peng", "glin", "dorn", "m08" and "m08min". 

### Implementations of Dornburg, et al.  

We implemented "ad11", an abbreviated version of Dornburg, et al.  The abbreviated method and the original method will give the same results if they choose the same set of fossils for calibration.  We carried out the full Dornburg method on 3 of the same data sets to which we also applied ad11 (intermediate tree replicate #1 with fossil density of 10, replicate 2 with density 25, and replicate #4 with fossil density 4.  The results of the Dornburg method are in the "dornburg_full" directory, and the corresponding results of ad11 are in the comparative evaluation directory.     

## LICENSE

The contents of this archive are distributed under terms in the file LICENSE.  

## REFERENCES

[use this section to list any references cited in the data files] 

* [citation code] : [bibliographic entry] 

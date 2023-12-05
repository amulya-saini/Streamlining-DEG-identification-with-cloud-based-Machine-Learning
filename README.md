# Group1--cloud-project
Streamlining DEG identification with cloud-based Machine Learning

In main focus of the project was to analyse the raw RNA-seq alignment files in BAM (Binary Alignment mapping) format, perform gene quantification and identify the biomarker features using PYSPARK.

The given code can serve as a basic pipeline for RNA-Seq analysis and gene identification using spark and its machine learning models.

RNA-seq alignment refers to the process of mapping or aligning short sequences of RNA molecules obtained from high-throughput sequencing technologies to a reference genome or transcriptome.

Gene quantification using a GTF (Gene Transfer Format) file involves estimating the expression levels of genes based on RNA-seq data aligned to a reference genome or transcriptome. GTF files provide information about gene annotations, including the genomic coordinates of exons, introns, transcripts, and other features within the genome.

## METHODS

The 6 BAM alignment files are read using **pysam's** alignmentFile function.
The GTF file is read as a spark dataframe and filtered to include only feature as genes.

A quantification function is employed which takes the GTF file rows and uses the seqname, chromosome start and end positions to read the BAM file and count the reads aligned to that specific position. The function stores the counts in a dictionary with gene id's as keys and the counts as values.

Counts obtained from quantification are preprocessed (log transformed, filtered and transposed) using pyspark.sql.functions.
Metadata corresponding to the BAM files is also read as spark dataframe.
The metadata labels are tranformed into indexes using string index function.

Feature selection using chisq.selector was performed to obtain the top 20 genes that can be potentially used as biomarkers for the labels.

Differential Expression analysis which is used to identify genes that show significant changes in expression levels between different experimental conditions, treatments, or biological states was performed in **R** to cross verify the feature selected biomarkers.

A Logistic regression model has been employed using the biomarkers to predict the conditions.


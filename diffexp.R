# Cloud project

counts1 <- read.delim('~/Downloads/counts.csv',sep=',',row.names = 1)
counts2 <- read.delim('~/Downloads/counts_47_48.csv',sep=',',row.names = 1)

colnames(counts2) <- c('SRR26924247','SRR26924248')


counts3 <- readxl::read_excel('~/Downloads/mergedcounts.xlsx')
rownames(counts3) <- counts3$Gene_ID
counts3$Gene_ID <- NULL
colnames(counts3) <- c('SRR26924243','SRR26924244')


counts <- cbind(counts3, counts1)
counts <- cbind(counts,counts2)


#write.csv(counts, '~/Desktop/Cloud Computing/project/counts.csv')

metadata = data.frame(sra_accesion = c('SRR26924243','SRR26924244','SRR26924245','SRR26924246',
                                       'SRR26924247','SRR26924248'),
                      condition = c('EGFL7 overexpression','EGFL7 overexpression','EGFL7 overexpression',
                                    'Normal Control','Normal Control','Normal Control'))

rownames(metadata) <- metadata$sra_accesion

counts <- read.delim('/Users/namrathashivanichalasani/Desktop/Cloud Computing/project/counts.csv',sep=',',
                     row.names = 1)

rownames(counts) <- counts$...1
counts$...1 <- NULL
counts <- counts[,-4]
metadata <- metadata[-4,]


#DEGs

library(DESeq2)

dds <- DESeqDataSetFromMatrix(countData = round(counts),
                              colData   = metadata,
                              design = ~condition)

dds <- dds[rowSums(counts(dds) >= 10) >=2,]
#dds <- dds[keep,]

dds <- DESeq(dds,betaPrior = TRUE)

result_de <- subset(results(dds),padj<0.05)
result_de <- result_de[order(result_de$padj),]
result <- data.frame(result_de)

#write.csv(result,'/Users/namrathashivanichalasani/Desktop/Cloud Computing/project/DEGs.csv')

library(EnhancedVolcano)

EnhancedVolcano::EnhancedVolcano(results(dds),lab = rownames(results(dds)),x = "log2FoldChange",
                                 y = 'padj')


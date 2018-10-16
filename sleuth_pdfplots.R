.libPaths("/projects/oarc/NF-Seq/sleuth")
library("sleuth")
load(file="./results/sleuth_object.so")
#sleuth_live(so, options=list(port=43838))
#sleuth_live(so)

#plot an example DE transcript result
p1 = plot_pca(so, color_by = 'condition')
p2 = plot_sample_density(so) 
p3 = plot_vars(so) 
p4 = plot_scatter(so) 

#Print out the plots created above and store in a single PDF file
pdf(file="SleuthResults.pdf")
print(p1)
print(p2)
print(p3)
print(p4)
dev.off()


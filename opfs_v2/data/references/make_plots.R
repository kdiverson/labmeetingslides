#plot
par(mfrow=c(3,2))

anterior_nares.ko.axes<-read.table("anterior_nares.ko.merge.thetayc.1.lt.nmds.axes")
anterior_nares.opf.axes<-read.table("anterior_nares.opf.merge.thetayc.1.lt.nmds.axes")

plot(anterior_nares.ko.axes, main="KO")
plot(anterior_nares.opf.axes, main="OPFs")

posterior_fornix.ko.axes<-read.table("posterior_fornix.ko.merge.thetayc.1.lt.nmds.axes")
posterior_fornix.opf.axes<-read.table("posterior_fornix.opf.merge.thetayc.1.lt.nmds.axes")

plot(posterior_fornix.ko.axes, main="KO")
plot(posterior_fornix.opf.axes, main="OPFs")

buccal_mucosa.ko.axes<-read.table("buccal_mucosa.ko.merge.thetayc.1.lt.nmds.axes")
buccal_mucosa.opf.axes<-read.table("buccal_mucosa.opf.merge.thetayc.1.lt.nmds.axes")

plot(buccal_mucosa.ko.axes, main="KO")
plot(buccal_mucosa.opf.axes, main="OPFs")


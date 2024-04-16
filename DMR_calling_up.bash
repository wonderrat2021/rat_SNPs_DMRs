#Alignment
bismark="/DATA/Rnwar_methylome/software/bismark_v0.22.1/bismark";
bismark_genome_preparation="/DATA/Rnwar_methylome/software/bismark_v0.22.1/bismark_genome_preparation";
ref_genome="/sunting/bs_rs/reference/";
fq="/sunting/bs_rs/BS/trim_out";

for i in G1 G2 G3 H1 H2 H3 X1 X2 X3;
do 
bismark --hisat2 -N 0 -L 20 -p 10  --un --ambiguous --sam  --genome_folder ${ref_genome}/"ref_"$i -1 ${fq}/$i"_R1_paired.fq.gz" -2 ${fq}/$i"_R2_paired.fq.gz" -o ${ref_genome}/"ref_"$i >$i"_bismark_log";
done

#deduplicate
bismark="/DATA/Rnwar_methylome/software/bismark_v0.22.1/bismark";
bismark_genome_preparation="/DATA/Rnwar_methylome/software/bismark_v0.22.1/bismark_genome_pr
eparation";
ref_genome="/sunting/bs_rs/reference";
fq="/sunting/bs_rs/BS/trim_out";
deduplicate="/DATA/Rnwar_methylome/software/bismark_v0.22.1/deduplicate_bismark";

for i in G1 G2 G3 H1 H2 H3 X1 X2 X3;
do ${deduplicate} -p ${ref_genome}/"ref_"$i/$i"_R1_paired_bismark_hisat2_pe.sam" -o ${ref_genome}/"ref_"$i/$i"_R1_paired_bismark_hisat2_pe.deduplicated.sam" >$i"_deduplicated.bismark_log";
done

#Methylextract
ref_genome="/sunting/bs_rs/reference";
methylextract="/DATA/Rnwar_methylome/software/bismark_v0.22.1/bismark_methylation_extractor"

for i in G1 G2 G3 H1 H2 H3 X1 X2 X3;
do ${methylextract} --bedGraph --gzip $i"_R1_paired_bismark_hisat2_pe.deduplicated.deduplicated.bam" --parallel 10 --cytosine_report --genome_folder ${ref_genome}/"ref_"$i -o ${ref_genome}/"ref_"$i >$i"_extract.bismark_log";
done
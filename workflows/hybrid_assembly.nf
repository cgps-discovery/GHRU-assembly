//import modules
include { CALCULATE_GENOME_SIZE               } from '../modules/short_reads_preprocess'
include { DETERMINE_MIN_READ_LENGTH           } from '../modules/short_reads_preprocess'
include { TRIMMING                            } from '../modules/short_reads_preprocess'
include { FASTQC                              } from '../modules/short_reads_preprocess'
include { NANOPLOT                            } from '../modules/long_reads_preprocess'
include { PORECHOP                            } from '../modules/long_reads_preprocess'
include { UNICYCLER                           } from '../modules/hybrid_assemblers'
include { QUAST                               } from '../modules/quast' 
include { SPECIATION                          } from '../modules/speciation' 
include { CHECKM_MARKERS                      } from '../modules/contamination'
include { CONTAMINATION_CHECKM                } from '../modules/contamination'
include { CALCULATEBASES_SR                   } from '../modules/calculate_bases'
include { CALCULATEBASES_LR                   } from '../modules/calculate_bases'
include { ASSEMBLY_DEPTH as ASSEMBLY_DEPTH_SR } from '../modules/assembly_depth'
include { ASSEMBLY_DEPTH as ASSEMBLY_DEPTH_LR } from '../modules/assembly_depth'
include { COMBINE_DEPTH_REPORTS               } from '../modules/assembly_depth'
include { COMBINE_REPORTS                     } from '../modules/combine_reports'

workflow HY_ASSEMBLY{

    take:
    
    hyb_reads


    //main workflow for hybrid assembly
    main: 

    //calculate genomesize for which it is not available and create a channel for reads with genome size
    reads_with_genome_size = CALCULATE_GENOME_SIZE(hyb_reads.meta, )

    //determine min read length required for trimming
    DETERMINE_MIN_READ_LENGTH(reads_with_genome_size)

    //qc trimming using trimmomatic
    TRIMMING (reads_with_genome_size, DETERMINE_MIN_READ_LENGTH.out, params.adapter_file)

    //create channel called processed short reads from trimming out
    processed_short_reads= TRIMMING.out

    //do fastqc for the trimmed reads
    FASTQC(processed_short_reads)

    //qc of long reads using nanoplot
    NANOPLOT(hyb_reads)

    //trim adapters using porechop
    PORECHOP(hyb_reads)

    //create only long reads channel
    processed_long_reads= PORECHOP.out.long_reads

    //hybrid assembly with unicycler
    UNICYCLER(processed_short_reads, processed_long_reads)

    //run quast for assessing assembly
    QUAST(UNICYCLER.out)

    //speciate with speciator
    SPECIATION(UNICYCLER.out)

    //contamination check checkm
    CHECKM_MARKERS(SPECIATION.out.species_name)
    CONTAMINATION_CHECKM(UNICYCLER.out, CHECKM_MARKERS.out)
    
    //calculate bases
    CALCULATEBASES_SR(processed_short_reads)

    //calculate bases
    CALCULATEBASES_LR(PORECHOP.out.long_read_assembly)

    //calculate short read depth based on assembly length
    ASSEMBLY_DEPTH_SR (QUAST.out.assembly_length, CALCULATEBASES_SR.out, "short_reads")

    //calculate long read depth based on assembly length
    ASSEMBLY_DEPTH_LR (QUAST.out.assembly_length, CALCULATEBASES_LR.out, "long_reads")

    //combine SR and LR depth reports
    COMBINE_DEPTH_REPORTS(ASSEMBLY_DEPTH_SR.out, ASSEMBLY_DEPTH_LR.out)
 
    //Consolidate all reports
    COMBINE_REPORTS(QUAST.out.report, SPECIATION.out, CONTAMINATION_CHECKM.out, COMBINE_DEPTH_REPORTS.out)
 }
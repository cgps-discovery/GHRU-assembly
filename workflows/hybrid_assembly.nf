//import modules
include { CALCULATE_GENOME_SIZE          } from '../modules/short_reads_preprocess'
include { DETERMINE_MIN_READ_LENGTH      } from '../modules/short_reads_preprocess'
include { TRIMMING                       } from '../modules/short_reads_preprocess'
include { FASTQC                         } from '../modules/short_reads_preprocess'
include { NANOPLOT                       }  from '../modules/long_reads_preprocess'
include { PORECHOP                       }  from '../modules/long_reads_preprocess'
include { UNICYCLER                      }  from '../modules/hybrid_assemblers'
include { QUAST                          }  from '../modules/quast' 
include { SPECIATION                     }  from '../modules/speciation' 
include { CHECKM_MARKERS                 } from '../modules/contamination'
include { CONTAMINATION_CHECKM           } from '../modules/contamination'
include { CONTAMINATION_GUNC             } from '../modules/contamination'
include { COMBINE_CONTAMINATION_REPORTS  } from '../modules/contamination'
include { COMBINE_REPORTS                } from '../modules/combine_reports'
include { QC_SCORING                     } from '../modules/quality_check_scoring'

workflow HY_ASSEMBLY{

    take:
    
    //take short reads from hybrid channel
    hyb_srt_reads

    //take long reads from hybrid channel
    hyb_lng_reads

    //take the guncDB path from main
    //gunc_db

    //main workflow for hybrid assembly
    main: 

    //calculate genomesize for which it is not available and create a channel for reads with genome size
    reads_with_genome_size = CALCULATE_GENOME_SIZE(hyb_srt_reads)

    //determine min read length required for trimming
    DETERMINE_MIN_READ_LENGTH(reads_with_genome_size)

    //qc trimming using trimmomatic
    TRIMMING (reads_with_genome_size, DETERMINE_MIN_READ_LENGTH.out, params.adapter_file)

    //create channel called processed short reads from trimming out
    processed_short_reads= TRIMMING.out

    //do fastqc for the trimmed reads
    FASTQC(processed_short_reads)

    //qc of long reads using nanoplot
    NANOPLOT(hyb_lng_reads)

    //trim adapters using porechop
    PORECHOP(hyb_lng_reads)

    //create only long reads channel
    processed_long_reads= PORECHOP.out.long_reads

    //hybrid assembly with unicycler
    UNICYCLER(processed_short_reads, processed_long_reads)

    //run quast for assessing assembly
    QUAST(UNICYCLER.out, "hybrid")

    //speciate with speciator
    SPECIATION(UNICYCLER.out, "hybrid")

    //contamination check checkm
    CHECKM_MARKERS(SPECIATION.out.species_name)
    CONTAMINATION_CHECKM(UNICYCLER.out, CHECKM_MARKERS.out, "hybrid")

    //contamination check gunc
    //CONTAMINATION_GUNC(UNICYCLER.out, gunc_db)

    //Merge Checkm and Gunc Outputs using gunc-merge
    //COMBINE_CONTAMINATION_REPORTS(CONTAMINATION_CHECKM.out, CONTAMINATION_GUNC.out)
 
    //Consolidate all reports
    COMBINE_REPORTS(QUAST.out, SPECIATION.out, CONTAMINATION_CHECKM.out, "hybrid")
  
    //Quality of scoring
    QC_SCORING(COMBINE_REPORTS.out, params.json_file)
 }

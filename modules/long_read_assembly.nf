process ASSEMBLY_DRAGONFLYE{

    label 'dragonflye_container'

    tag { sample_id }
    
    publishDir "${params.output}/long_read_assemblies", mode: 'copy', pattern: '*_contigs.fasta'

    input:
    tuple val(sample_id), path(long_reads), val(genome_size)
    val(medaka_model)
    val(assembler_thread)
    val(assembler_ram)

    output:
    tuple val(sample_id), path(fasta)


    script:
    LR="$long_reads"
    GSIZE="$genome_size"
    CPU="$assembler_thread"
    RAM="$assembler_ram"
    fasta="${sample_id}.flye_contigs.fasta"
    """
    dragonflye --gsize $GSIZE --reads $LR --cpus $CPU --ram $RAM \
    --prefix $sample_id --racon 1 --medaka 1 --model $medaka_model \
    --outdir "$sample_id" --force --keepfiles --depth 0
    mv "$sample_id"/"$sample_id".fa $fasta
    """
}

//add any other assembler_needed
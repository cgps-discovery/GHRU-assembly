process SPECIATION {

    //label 'speciation_container'

    tag { sample_id }

    input:
    tuple val(sample_id), path(fasta_file)

    output:
    tuple val(sample_id), path(json_file)

    script:
    
    """
    fasta_file="${fasta_file}"
    cat fasta_file | docker run -i --platform linux/x86_64 speciator:v4.0.0 > "$sample_id"_speciator_output.json
    """
    

}
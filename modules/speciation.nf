process SPECIATION {

    label 'speciation_container'

    tag { sample_id }

    input:
    tuple val(sample_id), path(fasta_file)

    output:
    tuple val(sample_id), path(json_file)

    script:
    
    """
    fasta_file="${fasta_file}"
    python3 speciator.py fasta_file /libraries /bactinspector/data/taxon_info.pqt > "$sample_id"_speciator_output.json
    """
    

}
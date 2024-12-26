// Start message
def startMessage(String pipelineVersion) {
    log.info( 
        $/
        |
        |╔═══════════════════════════════════════════════════════════════════════════════════════════════════════════════════╗
        |║                                                                                                                   ║░
        |║    ██████   ██   ██  █████    ██    ██      █████   █████  █████  █████  ███   ███  ███████  ██      ██      ██   ║░
        |║   ██        ██   ██  ██   ██  ██    ██     ██   ██ ██     ██     ██     ██ ██ ██ ██ ██    ██ ██        ██  ██     ║░
        |║   ██   ███  ███████  █████    ██    ██     ███████ ██████ ██████ ██████ ██   █   ██ ███████  ██          ██       ║░
        |║   ██    ██  ██   ██  ██  ██   ██    ██     ██   ██     ██     ██ ██     ██       ██ ██    ██ ██          ██       ║░
        |║    ██████   ██   ██  ██   ██   ██████      ██   ██ █████  █████   █████ ██       ██ ███████   ███████    ██       ║░
        |║                                                                                                                   ║░   
        |║                                                                                                                   ║░
        |║                              ░░░░░   ░  ░░░░░   ░░░░░  ░      ░  ░░    ░  ░░░░░                                   ║░ 
        |║                              ░    ░  ░  ░    ░  ░      ░      ░  ░ ░   ░  ░                                       ║░
        |║                              ░░░░░   ░  ░░░░░   ░░░░   ░      ░  ░  ░  ░  ░░░░                                    ║░
        |║                              ░       ░  ░       ░      ░      ░  ░   ░ ░  ░                                       ║░   
        |║                              ░       ░  ░       ░░░░░  ░░░░░  ░  ░    ░░  ░░░░░                                   ║░
        |${String.format('║  v %-46s',     pipelineVersion)}                                                                 ║░
        |╚═══════════════════════════════════════════════════════════════════════════════════════════════════════════════════╝░
        |  ░░░░░░░░░░░░░░░░░░░░░░░░░░░░░░░░░░░░░░░░░░░░░░░░░░░░░░░░░░░░░░░░░░░░░░░░░░░░░░░░░░░░░░░░░░░░░░░░░░░░░░░░░░░░░░░░░░░
       /$.stripMargin()
    )
}

// Define a Nextflow function to resolve relative paths
def resolveRelativePath(basePath, relativePath) {
    // Ensure basePath is absolute
    def base = file(basePath).toAbsolutePath()
    def resolvedPath = file("${base}/${relativePath}").toAbsolutePath()
    print resolvedPath
    return resolvedPath
}
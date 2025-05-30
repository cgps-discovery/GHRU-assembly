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

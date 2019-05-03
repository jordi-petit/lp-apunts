console.log "mysys"

# list of cytoscape instances
window.mycys = []


# add a cytoscape instance
window.mycytoscape = (inf) ->
    window.mycys.push cytoscape(inf)

# ensure cytoscape instances are well drawn
window.slideShow.on 'afterShowSlide', (slide) ->
    for cy in window.mycys
        # console.log 'refresh', cy.container().id
        cy.resize()
        cy.fit()

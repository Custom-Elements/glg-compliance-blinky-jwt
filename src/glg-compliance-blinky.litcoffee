# Overview

Retrieve compliance information for a particular CM in a particular
project via the `core-ajax` element.

Should handle rule exclusions.
Should maybe handle multiple CMs? Too chatty? Premature optimization?

# The `glg-compliance-blinky` Element

Doesn't do much besides respond to the `core-ajax` call and process the response.

    Polymer 'glg-compliance-blinky',
      created: ->

      ready: ->

      attached: ->
        @working = true

      domReady: ->

      detached: ->

      onResponse: (e, response) ->
        messages = response?.response?.councilMembers
        return console.error "Error retrieving compliance message for {{@cmId}}:", response if not messages
        console.log messages[@cmId]

      onComplete: ->
        @working = false

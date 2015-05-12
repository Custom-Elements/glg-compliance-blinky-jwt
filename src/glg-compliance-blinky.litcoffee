# Overview

Retrieve compliance information for a particular CM in a particular
project via the `core-ajax` element.

Should handle rule exclusions.
Should maybe handle multiple CMs? Too chatty? Premature optimization?

# The `glg-compliance-blinky` Element

Doesn't do much besides respond to the `core-ajax` call and process the response.

    Polymer 'glg-compliance-blinky',
      created: ->
        @working = false
        @hold = false
        @blocked = false

      ready: ->

      attached: ->
        @working = true

      domReady: ->

      detached: ->

      onResponse: (e, response) ->
        messages = response?.response?.councilMembers
        return console.error "Error retrieving compliance message for {{@cmId}}:", response if not messages
        @parseMessages(messages[@cmId])

      onComplete: ->
        @working = false

      parseMessages: (messages) ->
        messages.forEach (message) =>
          if message.level is 'hold'
            @hold = true
          if message.level is 'block'
            @blocked = true
        if messages.length
          @tooltip = messages.map( (message) -> message.message).join '\n'
        else
          @tooltip = "No Hold or Block"

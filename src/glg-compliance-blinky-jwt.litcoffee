# Overview

Retrieve compliance information for a particular CM in a particular
project via the `core-ajax` element.

Should handle rule exclusions.
Should maybe handle multiple CMs? Too chatty? Premature optimization?

# The `glg-compliance-blinky-jwt` Element

Doesn't do much besides respond to the `core-ajax` call and process the response.

    Polymer 'glg-compliance-blinky-jwt',
      created: ->
        @errored = false
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

      onError: (e, response) ->
        @tooltip = 'Something went wrong. Please try again later.'
        @errored = true
        if response.xhr?.status >= 500 and response.xhr?.status <= 599
          @tooltip = 'The server encountered an error. Please try again later.'
          console.error "glg-compliance-blinky-jwt: This blew up: #{response.xhr.responseURL}"

      onComplete: ->
        @working = false

      parseMessages: (messages) ->
        clearedMessages = []
        messages.forEach (message) =>
          if message.rule is 'restrictTermsAndConditions'
            return
          if message.level is 'hold'
            @hold = true
          if message.level is 'block'
            @blocked = true
          clearedMessages.push message
        if clearedMessages.length
          @tooltip = clearedMessages.map( (message) -> message.message).join '\n'
        else
          @tooltip = "No Hold or Block"

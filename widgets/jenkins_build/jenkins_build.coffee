class Dashing.JenkinsBuild extends Dashing.Widget

  @accessor 'value', Dashing.AnimatedValue
  @accessor 'bgColor', ->
    if @get('currentResult') == "SUCCESS"
      "#96bf48"
    else if @get('currentResult') == "FAILURE"
      "#D26771"
    else if @get('currentResult') == "PREBUILD"
      "#ff9618"
    else
      "#999"
  refreshLastRun: =>
    @set('timestamp2', moment(@get('timestamp')).fromNow())

  @accessor 'console-url', ->
    @get('url') + "console"

  @accessor 'duration-readable', ->
    moment.duration(@get('duration'), 'milliseconds').humanize()

  constructor: ->
    super
    @observe 'value', (value) ->
      $(@node).find(".jenkins-build").val(value).trigger('change')

  ready: ->
    @refreshLastRun()
    meter = $(@node).find(".jenkins-build")
    $(@node).fadeOut().css('background-color',@get('bgColor')).fadeIn()
    meter.attr("data-bgcolor", meter.css("background-color"))
    meter.attr("data-fgcolor", meter.css("color"))
    meter.knob
        change: (value) ->
        release: (value) ->
          return
        cancel: ->
          console.log "cancel : ", this
          return
  onData: (data) ->
   @refreshLastRun()
   if data.currentResult isnt data.lastResult
     $(@node).fadeOut().css('background-color',@get('bgColor')).fadeIn()

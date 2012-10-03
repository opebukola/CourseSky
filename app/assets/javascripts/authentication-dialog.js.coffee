class CourseSky.AuthenticationDialog
  constructor: () ->
    @bindEvents()
    $("#authentication-dialog").modal
      backdrop: false

  bindEvents: ->
    $("#authentication-dialog form").on "ajax:success", (event, data, status)->
      location.reload()

    $("#authentication-dialog form").on "ajax:error", (event, xhr, error)->
      $("#authentication-dialog .alert").remove()
      msg = xhr.responseText.replace(/["\[\]\{\}]/g, "")
      $("#authentication-dialog .nav-tabs").before('<div class="alert alert-error"><button type="button" class="close" data-dismiss="alert">×</button>' + msg  + '</div>')


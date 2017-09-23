class this.ImageSelector
  constructor: ->
    @selector = new RecordSelector('.image-selector .record-selector')

    @_setupEvents()

  _setupEvents: ->
    # Handle Unlink
    $( ".image-select .image-container .unlink a" ).on "click", (ev) =>
      ev.preventDefault()
      @_unlink(@_getContainer(ev))

    # Handle opening selector
    $( ".image-select .image-container .link a" ).on "click", (ev) =>
      ev.preventDefault()
      @_openSelector(@_getContainer(ev))

  # Removes an image association from a record
  _unlink: (container) ->
    container.find('input').val('')
    container.find('.placeholder').removeClass('hide')
    container.find('.actual').addClass('hide')
    container.find('.unlink').addClass('hide')

  # Open Image Selector
  _openSelector: (container) ->
    @activeContainer = container
    @selector.open(callbackSuccess: @_link)

  # Retrieve image container which holds actual image and hidden association input
  _getContainer: (ev) ->
    $(ev.currentTarget).closest('.image-container')

  _link: (selectedData) =>
    @activeContainer.find('input').val(selectedData.id)
    @activeContainer.find('.placeholder').addClass('hide')
    @activeContainer.find('.actual').attr('src',selectedData.image)
    @activeContainer.find('.actual').removeClass('hide')
    @activeContainer.find('.unlink').removeClass('hide')


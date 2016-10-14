class this.Menu
  # Menu constructor
  constructor: (container) ->
    @menuItemContainer = $('.menu-item-container')
    @_createMenuItems()
    @_initializeSortable()
    @_setupEvents()

    @_setupForm()

  _setupEvents: ->
    # Attempt to handle dynamic placeholder lengths
    # $('.sortable').each (sortable_index, sortable_element) =>
    #   sortable_element.addEventListener 'sortstart', (ev) =>
    #     item = $(ev.detail.item)
    #     placeholder = $(ev.detail.placeholder)
    #
    #     placeholder.css('height', item.css('height'))
    #     placeholder.css('width', item.css('width'))

    $('.sortable').each (sortable_index, sortable_element) =>
      sortable_element.addEventListener 'sortupdate', =>
        @_calculateMenuItemPriorities()

    # Handle new MenuItem Insertion & Removal
    $('#menu-items')
      .on 'cocoon:after-insert', (e, new_item) =>
        @_handleMenuItemInsertion(new_item)

      .on 'cocoon:before-remove', (e, removed_item) =>
        @_calculateMenuItemPriorities()

    # Handle Edit click for title or description
    $('.overview .input-display').on 'click', '.material-icons', (e) =>
      @_showMenuField(e.target)

    # Handle overview input-field defocus
    $('.overview input').focusout (e) =>
      @_hideMenuField(e.target)

    # Do not allow submit on enter
    $('form').on 'keyup keypress', (e) =>
      keyCode = e.keyCode or e.which
      if keyCode == 13
        e.preventDefault()
        inputId = e.target.id

        if inputId == 'menu_description' or inputId == 'menu_title'
          @_hideMenuField(e.target)


  _setupForm: ->
    @formValidator = $("form").validate
      errorElement: 'span'
      errorClass: 'has-error'
      validClass: ''
      highlight: (element, errorClass) ->
        $(element).closest('.input-field').addClass(errorClass)
      unhighlight: (element, errorClass) ->
        $(element).closest('.input-field').removeClass(errorClass)
        $(element).closest('.input-field').find('span.has-error').hide()
      ignore: ":hidden:not(select)"


  # Hides title or description input
  _hideMenuField: (input) ->
    iconHtml = "<i class='material-icons'>edit</i>"
    inputContainer = $(input.closest('.input-field'))
    inputContainer.addClass 'hide'
    inputContainer.prev('.input-display').html "#{input.value}#{iconHtml}"
    inputContainer.prev('.input-display').removeClass 'hide'

  # Shows title or description input
  _showMenuField: (input) ->
    displayContainer = $(input.closest('.input-display'))
    displayContainer.addClass 'hide'
    displayContainer.next('.input-field').removeClass 'hide'
    displayContainer.next('.input-field').find('input').focus()

  # Initalize drag and drop
  _initializeSortable: ->
    sortable '.sortable',
      items: '.menu-item-container'

  # Create Menu Item objects
  _createMenuItems: ->
    @menuItemContainer.each (i, itemContainer) =>
      new MenuItem(@, itemContainer)

  # Calculate & set menu item priorities
  _calculateMenuItemPriorities: ->
    $('.menu-item-container').each (priority, itemContainer) =>
      $(itemContainer).find('.priority-field').val(priority)

  # Initializes new Menu Item
  _handleMenuItemInsertion: (new_item) ->
    # Create connection to modal
    modal = new_item.find('.modal')
    modalTrigger = new_item.find('.modal-trigger')
    modal.attr("id","menu-item-modal-#{$.now()}")
    modalTrigger.attr("href","#menu-item-modal-#{$.now()}")

    # Initialize new MenuItem
    menu_item = new MenuItem(@, new_item)

    @_initializeSortable()
    @_calculateMenuItemPriorities()
    new_item.find('select').material_select()

    # Open modal
    menu_item.openModal()

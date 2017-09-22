// This is a manifest file that'll be compiled into application.js, which will include all the files
// listed below.
//
// Any JavaScript/Coffee file within this directory, lib/assets/javascripts, vendor/assets/javascripts,
// or any plugin's vendor/assets/javascripts directory can be referenced here using a relative path.
//
// It's not advisable to add code directly here, but if you do, it'll appear at the bottom of the
// compiled file.
//
// Read Sprockets README (https://github.com/rails/sprockets#sprockets-directives) for details
// about supported directives.
//
//= require jquery
//= require jquery_ujs
//= require materialize-sprockets
//= require turbolinks
//= require nprogress
//= require nprogress-turbolinks
//= require rails.validations
//= require rails.validations.simple_form
//= require parsley
//= require wice_grid
//= require cocoon
//= require ckeditor/loader
//= require i18n
//= require i18n/translations
//= require integral/images
//= require integral/posts
//= require integral/pages
//= require integral/lists
//= require integral/pickers
//= require integral/extensions
//= require_directory ./support

document.addEventListener("turbolinks:load", function() {
  Waves.displayEffect();
  Materialize.updateTextFields();
  $('select').material_select();
  $(".button-collapse").sideNav();
  $(".dropdown-button").dropdown();
  $('body').addClass('loaded');
  $('.collapsible').collapsible({
    accordion : false
  });

  SlugGenerator.check_for_slugs();
  RecordSelector.init();
  $('.icon-modal-trigger').leanModal();

  // Used for Autocomplete
  var filterSuggestions = function(suggestableInput, suggestions) {
    existingItems = suggestableInput.val().split(',')

    return suggestions.filter( function( el ) {
      return existingItems.indexOf( el ) < 0;
    });
  };

  // Material Tags
  // TODO: Newest version of Materialize now implements this. Investigate replacing.
  $("input[data-role=materialtags]").each(function( index ) {
    suggestableInput = $(this)
    typeaheadSuggestions = suggestableInput.data('typeahead').split(' ')

    // Initialize suggest engine
    suggestEngine = new Bloodhound({
      datumTokenizer: Bloodhound.tokenizers.whitespace,
      queryTokenizer: Bloodhound.tokenizers.whitespace,
      local: typeaheadSuggestions
    });

    // Initialize materialtags
    suggestableInput.materialtags({
      typeaheadjs: {
        source: function(query, cb) {
          suggestEngine.search(query, function(suggestions) {
            cb(filterSuggestions(suggestableInput, suggestions));
          });
        }
      }
    });
  });

  // Set the local for clientside validations
  I18n.locale = $('body').data('locale') || 'en'

  // CKEditor Initialization
  // TODO: Figure out why this is causing JS warning messages
    for(name in CKEDITOR.instances) {
      CKEDITOR.instances[name].destroy(true);
    }

  $('.ckeditor textarea').each(function() {
    editor = $(this);

    CKEDITOR.replace(editor.attr('id'), { "language": I18n.locale });
  });

  /*** Image Selector ***/
  imageSelector = new RecordSelector('.image-selector .record-selector')

    // Unlink image from object
    $( ".image-select .image-container .unlink a" ).on( "click", function(ev) {
      ev.preventDefault();
      container = $(ev.currentTarget).closest('.image-container');

      container.find('input').val('');
      container.find('.placeholder').removeClass('hide');
      container.find('.actual').addClass('hide');
      container.find('.unlink').addClass('hide');
    });

  // Open ImageFinder modal
  $( ".image-select .image-container .link a" ).on( "click", function(ev) {
    ev.preventDefault();
    container = $(ev.currentTarget).closest('.image-container');

    imageSelector.open()
  });

  // Link image to object
  $( ".image-selector .record-selector" ).on( "object-selection", function(ev, selectedData) {
    container = $(".image-select .image-container")

      container.find('input').val(selectedData.id);
    container.find('.placeholder').addClass('hide');
    container.find('.actual').attr('src',selectedData.image)
      container.find('.actual').removeClass('hide');
    container.find('.unlink').removeClass('hide');
  });
});

document.addEventListener("turbolinks:render", function() {
  initWiceGrid();
  $('input, textarea').characterCounter();
  $('.tooltipped').tooltip({delay: 50});
  $('ul.tabs').tabs();
});


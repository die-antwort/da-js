(function( $ ) {
  // Track changes to form fields accordingly set/reset CSS class "changed".
  //
  // Usage: 
  //     $("#myform").formChangeTracker();
  //
  // If the form element is wrapped in an element with the class "field" (rails scaffold) or "input" (formtastic), the class "changed" is set/reset on this wrapper element. Otherwise, "changed" is set/reset on the form element itself and its label (if present).
  
  $.fn.formChangeTracker = function() {

    var elementSelector = "input[type!=hidden],textarea,select";
  
    this.each(function() {

      var form = $(this);
      saveInitialValues(elementSelector);
      form.on("change keyup click", elementSelector, updateStatus);

      function saveInitialValues(selector) {
        form.find(selector).each(function() {
          $(this).data("initialValue", valueFor(this));
        })
      }

      function valueFor(element) {
        if (element.type == "checkbox" || element.type == "radio") return element.checked;
        return $(element).val();
      }
      
      function updateStatus(event, ignoreOtherRadiobuttons) {
        var targets = targetsForElement(this);

        if (elementHasChanged(this)) {
          targets.addClass('changed');
        } else {
          targets.removeClass('changed');
        }
    
        // For radiobuttons, if there is no container, also update all other radiobuttons of the same group
        if (this.type == "radio" && !ignoreOtherRadiobuttons && targets.index(this) != -1) {
          form.find("input[type=radio][name='" + this.name + "']").each(function() {
            updateStatus.call(this, null, true);
          });
        }
      }

      function elementHasChanged(element) {
        return valueFor(element) !== $(element).data("initialValue");
      }
  
      // Return the element(s) on that the "changed" class should be set/removed.
      function targetsForElement(element) {
        // use wrapping element with class .field or .input (formtastic) if present ...
        var targets = $(element).closest("form .field, form .input");
    
        // ... or fallback to the form element itself (and its label)
        if (targets.length == 0) targets = $(element).add("label[for=" + element.id + "]");
    
        return targets;
      }

    });
  };
})( jQuery );

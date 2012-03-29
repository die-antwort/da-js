# Hide/show elements dynamically according to their data-visible-if attribute.
#
# All elements with a data-visible-if attribute are checked on each change/focusout/click event:
# For each element, the content of its data-visible-if attribute is eval'd. If the eval'd code returns true, the element is shown – otherwise it is hidden.
# (The data-visible-if attributes must contain valid JavaScript code.)
# 
# Calling conditionalVisibility() also sets up the correct initial state (shown/hidden) of each element (again according to the result of the eval'd code in its dava-visible-if attribute). 
#
# Use $("body").conditionalVisibility() to enable the functionality for the whole document, or use a more specific selector to enable it only for some elements. 
# 
# If you want to force an update of the visibilites, use $(…).trigger("updateVisibilites").
# 
# Example:
# 
#   <form id="myform">
#     <input id="checkbox" type="checkbox" >
#     <input id="text" data-visible-if="$('#checkbox')[0].checked">
#   </form>
#   <script>
#     $("#myform").conditionalVisibility()
#   </script>

$.fn.conditionalVisibility = ->
    
    updateVisibilities = (event, options) ->
      $(this).find("[data-visible-if]").each ->
        if eval($(this).data("visible-if")) 
          if options?.skipAnimations
            $(this).show()
          else
            $(this).slideDown(100)
        else 
          if options?.skipAnimations
            $(this).hide()
          else
            $(this).slideUp(100)
    
    this.on("change focusout click updateVisibilities", updateVisibilities).trigger("updateVisibilities", {skipAnimations: true})

  
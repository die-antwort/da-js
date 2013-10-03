# Hide/show elements dynamically according to their data-visible-if attribute.
#
# All elements with a data-visible-if attribute are checked on change, focusout and click events:
# For each element, the content of its data-visible-if attribute is eval'd. If the eval'd code returns true, the element is shown – otherwise it is hidden.
# (The data-visible-if attributes must contain valid JavaScript code.)
#
# Events `shown.conditionalVisibility` / `hidden.conditionalVisibility` are triggered everytime an element has been shown or hidden.
# 
# Calling conditionalVisibility() also sets up the correct initial state (shown/hidden) of each element (again according to the result of the eval'd code in its dava-visible-if attribute). 
#
# Use $("body").conditionalVisibility() to enable the functionality for the whole document, or use a more specific selector to enable it only for some elements. 
# 
# Use $(…).conditionalVisibility({events: "keypress click"}) to customize the events wich trigger re-evaluation of visibilites (defaults to "change focusout click").
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

$.fn.conditionalVisibility = (options = {}) ->
    
    events = options.events || "change focusout click"
    events += " updateVisibilities"
    
    updateVisibilities = (event, options) ->
      $(this).find("[data-visible-if]").each ->
        $this = $(this)
        if eval($this.data("visible-if"))
          if $this.is(":hidden")
            if options?.skipAnimations
              $this.show()
            else
              $this.slideDown(100)
            $this.promise().done -> $this.trigger("shown.conditionalVisibility")
        else 
          if $this.is(":visible")
            if options?.skipAnimations
              $this.hide()
            else
              $this.slideUp(100)
            $this.promise().done -> $this.trigger("hidden.conditionalVisibility")
    
    this.on(events, updateVisibilities).trigger("updateVisibilities", {skipAnimations: true})

  
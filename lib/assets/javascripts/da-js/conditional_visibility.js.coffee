# Hide/show elements dynamically according to their `data-visible-if` attribute.
#
# All elements with a `data-visible-if` attribute are checked on change, focusout and click events:
# For each element, the content of its `data-visible-if` attribute is eval'd. If the eval'd code 
# returns true, the element is shown – otherwise it is hidden. (The attribute must contain valid
# JavaScript code.)
#
# Use `$("body").conditionalVisibility()` to enable the functionality for the whole document, 
# or use a more specific selector to enable it only for some elements. 
# 
# Use `$(…).conditionalVisibility({events: "keypress click"})` to customize the events wich trigger 
# re-evaluation of visibilites (defaults to "change focusout click").
# 
# There are two ways to manually force re-evaluation of visibilities:
#
#   - `$(…).trigger("updateVisibilities")` updates visibilities (using animations) and then triggers
#     `shown.conditionalVisibility` / `hidden.conditionalVisibility` events accordingly.
# 
#   - `$(…).trigger("setVisibilities")` sets visibilities directly (no animations, does not trigger 
#     custom events). This is already called automatically on pageready. You may want to call this
#     manually after new elements have been added to the DOM (eg a modal with content fetched via 
#     ajax).
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
    
    updateVisibilities = (event) ->
      $(this).find("[data-visible-if]").each ->
        $this = $(this)
        if eval($this.data("visible-if"))
          if $this.is(":hidden")
            $this.slideDown(100)
            $this.promise().done -> $this.trigger("shown.conditionalVisibility")
        else 
          if $this.is(":visible")
            $this.slideUp(100)
            $this.promise().done -> $this.trigger("hidden.conditionalVisibility")
    
    setVisibilities = (event) ->
      $(this).find("[data-visible-if]").each ->
        $this = $(this)
        $this.toggle !!eval($this.data("visible-if"))
    
    this.on(events, updateVisibilities).on("setVisibilities", setVisibilities).trigger("setVisibilities")

  
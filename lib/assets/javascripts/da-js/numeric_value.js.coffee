# Like val(), but return the value parsed as float (or 0, if the value is not numeric). Also works for non-input elements (using the element's text content as value).
#
# Thousands delimiters (",") are handled correctly. 
# German thousands delimiters (".") and separators (",") are handled correctly if the lang attribute of the HTML element is set to "de".
#
# Options:
#   ignoreCurrencySign: If true, values with leading currency signs (€, $) are considered numeric and parsed correctly.
#   nullOnError: If true, null is returned (instead of 0) if the value is not numeric.

$.fn.numericValue = (options = {}) ->
  
  delocalize = (val) ->
    if $("html").attr("lang") == "de"
      val.replace(".", "").replace(",", ".")
    else
      val.replace(",", "")
  
  $this = $(this)
  val = delocalize(if $this.is(":input") then $this.val() else $this.text())
  val = val.replace(/^\s*[€$]\s*/, "") if options.ignoreCurrencySign
  if $.isNumeric(val)
    parseFloat(val)
  else
    if options.nullOnError then null else 0

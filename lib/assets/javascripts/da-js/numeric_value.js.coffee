# Like val(), but return the value parsed as float (or 0 if the value is not numeric). Also works for non-input elements (using the text content instead of the value).
#
# Thousands delimiters (",") are handled correctly. 
# German thousands delimiters (".") and separators (",") are handled correctly if the lang attribtue of the HTML element is set to "de". 
#
# Options:
#   ignoreCurrencySign: If true, leading currency signs (€, $) are ignored on parsing. 

$.fn.numericValue = (options = {}) ->
  
  delocalize = (val) ->
    if $("html").attr("lang") == "de"
      val.replace(".", "").replace(",", ".")
    else
      val.replace(",", "")
  
  $this = $(this)
  val = delocalize(if $this.is(":input") then $this.val() else $this.text())
  val = val.replace(/^\s*[€$]\s*/, "") if options.ignoreCurrencySign
  return 0 unless $.isNumeric(val) 
  parseFloat(val)

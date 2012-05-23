# Like val(), but return the value parsed as float (or 0 if the value is not numeric).
#
# Thousands delimiters (",") are handled correctly. 
# German thousands delimiters (".") and separators (",") are handled correctly if the lang attribtue of the HTML element is set to "de". 

$.fn.numericValue = ->
  
  delocalize = (val) ->
    if $("html").attr("lang") == "de"
      val.replace(".", "").replace(",", ".")
    else
      val.replace(",", "")
  
  val = delocalize($(this).val())
  return 0 unless $.isNumeric(val) 
  parseFloat(val)

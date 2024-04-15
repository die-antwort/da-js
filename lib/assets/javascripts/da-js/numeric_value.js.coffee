# Like val(), but return the value parsed as float (or 0, if the value is not numeric). Also works for non-input elements (using the element's text content as value).
#
# Thousands delimiters (",") are handled correctly.
# German thousands delimiters (".") and separators (",") are handled correctly if the lang attribute of the input element (or any of its parent elements) is set to "de".
#
# Options:
#   ignoreCurrencySign: If true, values with leading currency signs (€, $) are considered numeric and parsed correctly.
#   ignoreTrailingStrings: If true, values with trailing strings are considered numeric and parsed correctly.
#   nullOnError: If true, null is returned (instead of 0) if the value is not numeric.

$.fn.numericValue = (options = {}) ->

  delocalize = (val, locale) ->
    if locale == "de"
      val.replace(".", "").replace(",", ".")
    else
      val.replace(",", "")

  $this = $(this)
  locale = $this.closest("[lang]").attr("lang")
  val = if $this.is(":input") then $this.val() else $this.text()
  val = delocalize(val, locale)
  val = val.replace(/^\s*[€$]\s*/, "") if options.ignoreCurrencySign
  val = val.replace(/[^.\d]+$/, "") if options.ignoreTrailingStrings
  if $.isNumeric(val)
    parseFloat(val)
  else
    if options.nullOnError then null else 0

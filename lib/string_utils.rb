class String
  BLANK_RE = /\A[[:space:]]*\z/

  # File activesupport/lib/active_support/core_ext/object/blank.rb, line 114
  def blank?
    # The regexp that matches blank strings is expensive. For the case of empty
    # strings we can speed up this method (~3.5x) with an empty? call. The
    # penalty for the rest of strings is marginal.
    empty? || BLANK_RE === self
  end
end

# extend ruby String class
class String
  def t(options={})              # with I18n's "t" method
    res = I18n.t self, options
  end
end
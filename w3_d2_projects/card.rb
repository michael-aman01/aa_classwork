


class Card
  attr_reader :face_value, :token
  def initialize(token)
    @token = token
    @face_value = " " #initialized to hiddenß
  end

  def hide
    @face_value = " "
  end

  def reveal
    @face_value = @token
  end

end

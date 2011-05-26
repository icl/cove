module JWPlayerHelpers
  def jwplayer_play
    page.execute_script "jwplayer().play()"
  end
  def jwplayer_position
    (page.execute_script "jwplayer().getPosition()").to_f
  end
end

World(JWPlayerHelpers)
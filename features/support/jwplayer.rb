module JWPlayerHelpers
  def jwplayer_play
    page.execute_script "jwplayer().play()"
    # wait for the player to actually start playing
    sleep(0.1) while jwplayer_position == 0
  end
  def jwplayer_position
    (page.evaluate_script "jwplayer().getPosition()").to_f
  end
end

World(JWPlayerHelpers)
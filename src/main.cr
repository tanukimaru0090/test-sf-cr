require "crsfml/window"
require "crsfml/audio"
require "json"

DEFAULT_WINDOW_TITLE  = "Crystal+SFML = < 2.5.2"
DEFAULT_WINDOW_WIDTH  = 640
DEFAULT_WINDOW_HEIGHT = 480

config_path = "./test.json"
path = "/home/daruma/ダウンロード/th-music/thb02 暗闇の風穴.wav"
file = File.read(config_path)
jdata = JSON.parse(file)
window_title = jdata["title"].as_s
window_width = jdata["width"].as_i
window_height = jdata["height"].as_i

window = SF::Window.new(SF::VideoMode.new(window_width,window_height),window_title)
music = SF::Music.new

if !music.open_from_file(path)
  p "BGMファイル '#{path}' が見つかりませんでした"
end
music.play
while window.open?
  while event = window.poll_event
    if event.is_a? SF::Event::Closed
      music.stop
      window.close
    end
  end
  window.display
end


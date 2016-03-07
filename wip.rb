notes = %i( G3 G3 A3 B3 ).ring
bpm = 105
use_bpm bpm

ROOT = :E3 # How can we make this value dynamic and share it between threads?

live_loop :beat do
  # use_bpm bpm
  sleep 1
end

live_loop :left_hand do |n|
  sync :beat
  use_synth :piano
  play notes.tick, sustain: 1
  sleep 0.45
  play ROOT, sustain: 1
  n + 1
end

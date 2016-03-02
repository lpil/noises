use_synth :saw

notes = (0..6).map { |e| e * 6 + 38 }
notes = notes.zip(notes.reverse)

live_loop :lazer do |n|
  size = notes.length
  use_synth %i(dsaw pulse).choose if n % size * 4 == 0
  play notes[n % size], amp: 0.5
  sleep 1.3 / size
  n + 1
end

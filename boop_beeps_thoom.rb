use_bpm 90

our_scale = :minor_pentatonic

live_loop :beat do |n|
  cue :bar    if n % 4 == 0
  cue :phrase if n % 32 == 0
  sleep 1
  n + 1
end

live_loop :the_boop do
  sync :bar
  with_fx :reverb, mix: 0.45 do
    play scale(:Eb2, our_scale, num_octaves: 3).choose,
      attack: 0.2,
      release: 3.0,
      amp: 0.6
  end
end

live_loop :beeps do
  sync :beat
  with_fx :reverb, mix: 0.36 do
    [
      0.0,
      0.2,
      0.5,
      0.7,
    ].each do |rest|
      in_thread do
        sleep rest
        amp = rand(0.5) + 0.2
        play scale(:Eb2, our_scale, num_octaves: 3).choose,
          release: 0.1,
          amp: amp
        play scale(:Eb6, our_scale, num_octaves: 2).choose,
          release: 0.1,
          amp: amp * 0.7
        play scale(:Eb2, our_scale, num_octaves: 2).choose,
          release: 0.3,
          amp: amp
      end
    end
  end
end

live_loop :thoom do
  sync :phrase
  with_fx :reverb, room: 1 do
    sample :bd_boom, amp: 3
  end
end

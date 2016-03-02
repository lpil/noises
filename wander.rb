live_loop :guit do
  with_fx :echo, mix: 0.7, phase: 0.85 do
    sample :guit_em9, rate: -0.5
  end
  sample :guit_em9, rate: -0.5
  sleep 4
end

live_loop :guit_for do
  sample :guit_em9, rate: 0.5
  sleep 4
end

live_loop :boom do
  with_fx :reverb, room: 1 do
    sample :bd_boom, amp: 10, rate: 1
  end
  sleep 8
end

live_loop :pulse do
  sample :bd_boom, amp: 2.0, rate: 1
  sleep 0.25
  sample :bd_boom, amp: 2.1, rate: 1
  sleep 0.75
end

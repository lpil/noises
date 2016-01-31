(ns noises.getting-started.intro
  (:use overtone.live))

; We can define synths!
;
; The "out" ugen is used to send data to a bus, or busses if more channels are
; given. The first bus is the left output of your audio interface.

(defsynth beep [] (out 0 (* 0.1 (sin-osc 440))))

(def beep-synth-id (beep)) ; Create an instance of the synth
(kill beep-synth-id)       ; Use the returned synth id to stop it
(stop)                     ; Stop all synths


; We can pass arguments to synths. Here lets play with the amp and freq.

(defsynth beep2 [freq 440 amp 0.1]
  (->> (sin-osc freq)
       (* amp)
       (out 0)))

(beep2)
(beep2 220 0.4)
(beep2 80  0.8)
(stop)


; We can pass 2 outputs to "out" to get stereo

(defsynth beep3 [freq 440 amp 0.1]
  (let [a (* amp (sin-osc freq))
        b (* amp (sin-osc freq))]
    (out 0 [a b])))

(beep3)
(beep3 220 0.4)
(beep3 80  0.8)
(stop)


; Like sclang there is multi channel expansion.

(defsynth beep4 [freq 440 amp 0.1]
  (->> (sin-osc [freq freq])
       (* amp)
       (out 0)))

(beep4)
(beep4 220 0.4)
(beep4 80  0.8)
(stop)


; Playing with slight difference in frequencies

(defsynth beep5 [freq 440 amp 0.1 offset 7]
  (->> (sin-osc [freq (+ freq offset)])
       (* amp)
       (out 0)))

(def b (beep5))
(ctl b :amp 0.3)
(ctl b :offset 3)
(ctl b :offset 30)
(ctl b :offset 300)
(ctl b :offset 70)
(kill b)


(defsynth beep6 [freq 440 amp 0.2 offset 7 delay 0.4]
  (let [freqs [freq (+ freq offset)]
        env (env-gen (perc) :action FREE)
        src (* env (sin-osc freqs))
        del (delay-n src delay delay)
        delayed (+ src del)
        amped   (* amp delayed)]
    (out 0 amped)))

(beep6)
(beep6 :amp 0.4 :delay 0.1)

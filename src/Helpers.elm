module Helpers exposing ((?))


(?) : a -> a -> Bool -> a
(?) true false check =
  if check then
    true
  else
    false

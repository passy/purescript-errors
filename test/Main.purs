module Test.Main where

import Prelude
import Data.Either (Either(..))
import Data.Maybe (Maybe(..), isNothing)
import Test.Unit
import Control.Error.Util
import Control.Monad.Except
import Control.Monad.Maybe.Trans
import Data.Identity

main = runTest $ do
  test "hush" $ do
    assert "Right is Just" $ case (hush $ Right 5) of
      Just n -> n == 5
      _      -> false
    assert "Left is Nothing" $ isNothing (hush $ Left 5)

  test "hushT" $ do
    let exR = except $ Right "right"
    let exL = except $ Left "left"

    assert "Except Right is Just" $ do
      let res = runIdentity <<< runMaybeT <<< hushT $ exR
      case res of
        Just str -> str == "right"
        _        -> false

    assert "Except Left is Nothing" $ do
      let res = runIdentity <<< runMaybeT <<< hushT $ exL
      isNothing res

  test "note" $ do
    assert "Nothing is Left a" $ do
      let res = note "nothing" Nothing
      case res of
        Left a -> a == "nothing"
        _      -> false

    assert "Just is Right a" $ do
      let res = note "nothing" $ Just "something"
      case res of
        Right a -> a == "something"
        _       -> false

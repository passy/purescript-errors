module Test.Main where

import Prelude
import Data.Either (Either(..))
import Data.Maybe (Maybe(..), isNothing)
import Test.Unit
import Control.Error.Util

main = runTest $ do
  test "hush" $ do
    assert "Right is Just" $ case (hush $ Right 5) of
      Just n -> n == 5
      _      -> false
    assert "Left is Nothing" $ isNothing (hush $ Left 5)

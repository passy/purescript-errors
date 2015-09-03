module Test.Main where

import Prelude
import Data.Either (Either(..))
import Data.Maybe (Maybe(..), isNothing)
import Test.Unit
import Control.Error.Util
import Control.Monad.Except
import Control.Monad.Maybe.Trans
import Data.Identity

type MaybeId a = MaybeT Identity a

maybeId :: forall a. Maybe a -> MaybeId a
maybeId = MaybeT <<< Identity

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

  test "noteT" $ do
    assert "Nothing is Left a" $ do
      let res = noteT "nothing" $ maybeId Nothing
      case (runExcept res) of
        Left a -> a == "nothing"
        _      -> false

    assert "Just is Right a" $ do
      let res = noteT "nothing" $ maybeId $ Just "something"
      case (runExcept res) of
        Right a -> a == "something"
        _       -> false

  test "hoistMaybe" $ do
    assert "lift Nothing" $ do
      let maybet = hoistMaybe Nothing
      isNothing (runIdentity <<< runMaybeT $ maybet)

    assert "lift Just" $ do
      let maybet = hoistMaybe $ Just 42
      let unwrap = (runIdentity <<< runMaybeT $ maybet)
      case unwrap of
        Just n -> n == 42
        _      -> false

  test "(??)" $ do
    assert "Nothing to ExceptT" $ do
      let res = Nothing ?? "nothing"
      let unwrap = runExcept res
      case unwrap of
        Left a -> a == "nothing"
        _      -> false

    assert "Just to ExceptT" $ do
      let res = Just "something" ?? "nothing"
      let unwrap = runExcept res
      case unwrap of
        Right a -> a == "something"
        _       -> false

  test "(?:)" $ do
    assert "from Nothing" $ (Nothing ?: "nothing") == "nothing"
    assert "from Just" $ (Just "something" ?: "nothing") == "something"

module Test.Main where

import Prelude (Unit, (==), ($), bind, (<<<))
import Control.Monad.Aff.AVar (AVAR)
import Data.Either (Either(..))
import Data.Maybe (Maybe(..), isNothing)
import Test.Unit (TIMER, test, runTest)
import Test.Unit.Console (TESTOUTPUT)
import Test.Unit.Assert as Assert
import Control.Monad.Eff (Eff)
import Control.Monad.Except (runExcept, except)
import Control.Monad.Maybe.Trans (MaybeT(MaybeT), runMaybeT)
import Data.Identity (Identity(Identity), runIdentity)

import Control.Error.Util ((?:), (??), hoistMaybe, noteT, note, hushT, hush)

type MaybeId a = MaybeT Identity a

maybeId :: forall a. Maybe a -> MaybeId a
maybeId = MaybeT <<< Identity

main :: forall eff. Eff ( timer :: TIMER
                        , avar :: AVAR
                        , testOutput :: TESTOUTPUT | eff ) Unit
main = runTest $ do
  test "hush" $ do
    Assert.assert "Right is Just" $ case (hush $ Right 5) of
      Just n -> n == 5
      _      -> false
    Assert.assert "Left is Nothing" $ isNothing (hush $ Left 5)

  test "hushT" $ do
    let exR = except $ Right "right"
    let exL = except $ Left "left"

    Assert.assert "Except Right is Just" $ do
      let res = runIdentity <<< runMaybeT <<< hushT $ exR
      case res of
        Just str -> str == "right"
        _        -> false

    Assert.assert "Except Left is Nothing" $ do
      let res = runIdentity <<< runMaybeT <<< hushT $ exL
      isNothing res

  test "note" $ do
    Assert.assert "Nothing is Left a" $ do
      let res = note "nothing" Nothing
      case res of
        Left a -> a == "nothing"
        _      -> false

    Assert.assert "Just is Right a" $ do
      let res = note "nothing" $ Just "something"
      case res of
        Right a -> a == "something"
        _       -> false

  test "noteT" $ do
    Assert.assert "Nothing is Left a" $ do
      let res = noteT "nothing" $ maybeId Nothing
      case (runExcept res) of
        Left a -> a == "nothing"
        _      -> false

    Assert.assert "Just is Right a" $ do
      let res = noteT "nothing" $ maybeId $ Just "something"
      case (runExcept res) of
        Right a -> a == "something"
        _       -> false

  test "hoistMaybe" $ do
    Assert.assert "lift Nothing" $ do
      let maybet = hoistMaybe Nothing
      isNothing (runIdentity <<< runMaybeT $ maybet)

    Assert.assert "lift Just" $ do
      let maybet = hoistMaybe $ Just 42
      let unwrap = (runIdentity <<< runMaybeT $ maybet)
      case unwrap of
        Just n -> n == 42
        _      -> false

  test "(??)" $ do
    Assert.assert "Nothing to ExceptT" $ do
      let res = Nothing ?? "nothing"
      let unwrap = runExcept res
      case unwrap of
        Left a -> a == "nothing"
        _      -> false

    Assert.assert "Just to ExceptT" $ do
      let res = Just "something" ?? "nothing"
      let unwrap = runExcept res
      case unwrap of
        Right a -> a == "something"
        _       -> false

  test "(?:)" $ do
    Assert.assert "from Nothing" $ (Nothing ?: "nothing") == "nothing"
    Assert.assert "from Just" $ (Just "something" ?: "nothing") == "something"

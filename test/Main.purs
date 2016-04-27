module Test.Main where

import Prelude (bind, Unit, ($))
import Control.Monad.Aff.AVar (AVAR)
import Test.Unit (TIMER, test, runTest)
import Test.Unit.Console (TESTOUTPUT)
import Control.Monad.Eff (Eff)
import Control.Monad.Maybe.Trans (MaybeT)
import Data.Identity (Identity)

import Test.Control.Error.Util

type MaybeId a = MaybeT Identity a


main :: forall eff. Eff ( timer :: TIMER
                        , avar :: AVAR
                        , testOutput :: TESTOUTPUT | eff ) Unit
main = runTest $ do
  test "Control.Error.Util" Test.Control.Error.Util.suite
  test "Data.EitherR" Test.Data.EitherR.suite

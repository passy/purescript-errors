module Test.Main where

import Prelude (bind, Unit, ($))

import Control.Monad.Aff.AVar (AVAR)
import Control.Monad.Eff (Eff)
import Control.Monad.Eff.Console (CONSOLE)
import Control.Monad.Maybe.Trans (MaybeT)
import Data.Identity (Identity)
import Test.Unit (TIMER, suite)
import Test.Unit.Console (TESTOUTPUT)
import Test.Unit.Main (runTest)

type MaybeId a = MaybeT Identity a


main :: forall eff. Eff ( timer :: TIMER
                        , avar :: AVAR
                        , console :: CONSOLE
                        , testOutput :: TESTOUTPUT | eff ) Unit
main = runTest $ do
  suite "Control.Error.Util" Test.Control.Error.Util.suite
  suite "Data.EitherR" Test.Data.EitherR.suite

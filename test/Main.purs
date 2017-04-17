module Test.Main where

import Prelude (discard, Unit, ($))

import Control.Monad.Aff.AVar (AVAR)
import Control.Monad.Eff (Eff)
import Control.Monad.Eff.Console (CONSOLE)
import Control.Monad.Maybe.Trans (MaybeT)
import Data.Identity (Identity)
import Test.Control.Error.Util (suite) as UtilTest
import Test.Data.EitherR (suite) as EitherRTest
import Test.Unit (suite)
import Test.Unit.Console (TESTOUTPUT)
import Test.Unit.Main (runTest)

type MaybeId a = MaybeT Identity a


main :: forall eff. Eff ( avar :: AVAR
                        , console :: CONSOLE
                        , testOutput :: TESTOUTPUT | eff ) Unit
main = runTest $ do
  suite "Control.Error.Util" UtilTest.suite
  suite "Data.EitherR" EitherRTest.suite

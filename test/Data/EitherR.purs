module Test.Data.EitherR where

import Test.Unit.Assert as Assert
import Control.Alt ((<|>))
import Control.Monad.Aff (Aff)
import Control.Monad.Aff.AVar (AVAR)
import Data.Either (Either(Left, Right))
import EitherR (EitherR, succeed, runEitherR)
import Prelude (class Eq, return, bind, Unit, ($), (==))
import Test.Unit (test, TIMER)
import Test.Unit.Console (TESTOUTPUT)

data TestError = TestError Int
instance eqTestError :: Eq TestError where
  eq (TestError i) (TestError j) = i == j


suite :: forall eff. Aff ( timer :: TIMER , avar :: AVAR , testOutput :: TESTOUTPUT | eff ) Unit
suite = do
  test "EitherR monad" $ do
    let succeedResult = runEitherR $ do
                          x <- return 1
                          succeed 2
                          return x
    Assert.assert "`succeed` breaks execution chain with `Right` value" $
      succeedResult == Right 2
  test "EitherR alt" $ do
    let successesAggregation =
          succeed [1] <|>
          succeed [2] <|>
          (succeed [3] :: EitherR (Array Int) TestError)
    Assert.assert "`alt` aggregates results" $
      (runEitherR successesAggregation) == Right [1, 2, 3]
    let e1 = (successesAggregation <|> return (TestError 1) <|> return (TestError 2))
    Assert.assert "`alt` returns first error value" $
      (runEitherR e1) == Left (TestError 1)


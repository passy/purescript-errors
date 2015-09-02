module Control.Error.Util
  ( hush
  )
where

import Prelude
import Data.Either (Either(Left, Right), either)
import Control.Monad.Except.Trans (ExceptT(..), runExceptT)
import Control.Monad.Maybe.Trans (MaybeT(..), runMaybeT)
import Data.Maybe (Maybe(Just, Nothing), maybe, fromMaybe)

{- $conversion
    Use these functions to convert between 'Maybe', 'Either', 'MaybeT', and
    'ExceptT'.
-}

-- | Suppress the 'Left' value of an 'Either'
hush :: forall a b. Either a b -> Maybe b
hush = either (const Nothing) Just

-- | Suppress the 'Left' value of an 'ExceptT'
hushT :: forall a b m. (Monad m) => ExceptT a m b -> MaybeT m b
hushT = MaybeT <<< liftM1 hush <<< runExceptT

-- | Tag the 'Nothing' value of a 'Maybe'
note :: forall a b. a -> Maybe b -> Either a b
note a = maybe (Left a) Right

-- | Tag the 'Nothing' value of a 'MaybeT'
noteT :: forall a b m. (Monad m) => a -> MaybeT m b -> ExceptT a m b
noteT a = ExceptT <<< liftM1 (note a) <<< runMaybeT

-- | Lift a 'Maybe' to the 'MaybeT' monad
hoistMaybe :: forall a b m. (Monad m) => Maybe b -> MaybeT m b
hoistMaybe = MaybeT <<< return

-- | Convert a 'Maybe' value into the 'ExceptT' monad
(??) :: forall a b e m. (Applicative m) => Maybe a -> e -> ExceptT e m a
(??) a e = ExceptT (pure $ note e a)

-- | Convert an applicative 'Maybe' value into the 'ExceptT' monad
(!?) :: forall a b e m. (Applicative m) => m (Maybe a) -> e -> ExceptT e m a
(!?) a e = ExceptT (note e <$> a)

-- | An infix form of 'fromMaybe' with arguments flipped.
(?:) :: forall a. Maybe a -> a -> a
(?:) maybeA b = fromMaybe b maybeA

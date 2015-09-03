## Module Control.Error.Util

#### `hush`

``` purescript
hush :: forall a b. Either a b -> Maybe b
```

Suppress the 'Left' value of an 'Either'

#### `hushT`

``` purescript
hushT :: forall a b m. (Monad m) => ExceptT a m b -> MaybeT m b
```

Suppress the 'Left' value of an 'ExceptT'

#### `note`

``` purescript
note :: forall a b. a -> Maybe b -> Either a b
```

Tag the 'Nothing' value of a 'Maybe'

#### `noteT`

``` purescript
noteT :: forall a b m. (Monad m) => a -> MaybeT m b -> ExceptT a m b
```

Tag the 'Nothing' value of a 'MaybeT'

#### `hoistMaybe`

``` purescript
hoistMaybe :: forall a b m. (Monad m) => Maybe b -> MaybeT m b
```

Lift a 'Maybe' to the 'MaybeT' monad

#### `(??)`

``` purescript
(??) :: forall a b e m. (Applicative m) => Maybe a -> e -> ExceptT e m a
```

_left-associative / precedence -1_

Convert a 'Maybe' value into the 'ExceptT' monad

#### `(!?)`

``` purescript
(!?) :: forall a b e m. (Applicative m) => m (Maybe a) -> e -> ExceptT e m a
```

_left-associative / precedence -1_

Convert an applicative 'Maybe' value into the 'ExceptT' monad

#### `(?:)`

``` purescript
(?:) :: forall a. Maybe a -> a -> a
```

_left-associative / precedence -1_

An infix form of 'fromMaybe' with arguments flipped.



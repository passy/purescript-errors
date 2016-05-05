# purescript-errors

[![Latest release](http://img.shields.io/bower/v/purescript-errors.svg)](https://github.com/passy/purescript-errors/releases)
[![Build Status](https://travis-ci.org/passy/purescript-errors.svg?branch=master)](https://travis-ci.org/passy/purescript-errors)
[![Dependency Status](https://www.versioneye.com/user/projects/55e9948a211c6b001f000de3/badge.svg?style=flat)](https://www.versioneye.com/user/projects/55e9948a211c6b001f000de3)

> A partial port of Gabriel Gonzalez' [errors
> library](https://github.com/Gabriel439/Haskell-Errors-Library) for Haskell.

- Module documentation:
    - [Control.Error.Util](docs/Control/Error/Util.md)
    - [Data.EitherR](docs/Data/EitherR.md)
- [Pursuit](http://pursuit.purescript.org/packages/purescript-errors)

## About that "partial"

`Control.Error.Safe` has not been ported since `purescript-lists` and
`purescript-arrays` provide safe alternatives by default. `Control.Error.Script`
relies on platform-specific features not available in PureScript.

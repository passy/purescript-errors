# purescript-errors

[![Latest release](http://img.shields.io/bower/v/purescript-errors.svg)](https://github.com/passy/purescript-errors/releases)
[![Build Status](https://travis-ci.org/passy/purescript-errors.svg?branch=master)](https://travis-ci.org/passy/purescript-errors)

> A partial port of Gabriel Gonzales' [errors
> library](https://github.com/Gabriel439/Haskell-Errors-Library) for Haskell.

- [Module documentation](docs/Control/Error/Util.md)

## About that "partial"

`Control.Error.Safe` has not been ported since `purescript-lists` and
`purescript-arrays` provide safe alternatives by default. `Control.Error.Script`
relies on platform-specific features not available in PureScript.

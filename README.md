# Linear Algebra

[![Build status](https://github.com/pharo-ai/linear-algebra/workflows/CI/badge.svg)](https://github.com/pharo-ai/linear-algebra/actions/workflows/test.yml)
[![Coverage Status](https://coveralls.io/repos/github/pharo-ai/linear-algebra/badge.svg?branch=master)](https://coveralls.io/github/pharo-ai/linear-algebra?branch=master)
[![License](https://img.shields.io/badge/license-MIT-blue.svg)](https://raw.githubusercontent.com/pharo-ai/linear-algebra/master/LICENSE)

Fast linear algebra implemented using [Pharo Lapack](https://github.com/pharo-ai/lapack).

For the documentation, please refer to the pharo-ai wiki page: https://github.com/pharo-ai/wiki/blob/master/wiki/LinearAlgebra/LinearAlgebra.md

## How to install it

To install `linear-algebra`, go to the Playground (Ctrl+O+W) in your [Pharo](https://pharo.org/) image and execute the following Metacello script (select it and press Do-it button or Ctrl+D):

```Smalltalk
Metacello new
  baseline: 'AILinearAlgebra';
  repository: 'github://pharo-ai/linear-algebra/src';
  load.
```

## How to depend on it

If you want to add a dependency on `linear-algebra` to your project, include the following lines into your baseline method:

```Smalltalk
spec
  baseline: 'AILinearAlgebra'
  with: [ spec repository: 'github://pharo-ai/linear-algebra/src' ].
```

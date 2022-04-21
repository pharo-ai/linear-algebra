# Linear Algebra

[![Build status](https://github.com/pharo-ai/linear-algebra/workflows/CI/badge.svg)](https://github.com/pharo-ai/linear-algebra/actions/workflows/test.yml)
[![Coverage Status](https://coveralls.io/repos/github/pharo-ai/linear-algebra/badge.svg?branch=master)](https://coveralls.io/github/pharo-ai/linear-algebra?branch=master)
[![License](https://img.shields.io/badge/license-MIT-blue.svg)](https://raw.githubusercontent.com/pharo-ai/linear-algebra/master/LICENSE)

Fast linear algebra implemented using [Lapack](http://www.netlib.org/lapack/).

## How to install it

To install `linear-algebra`, go to the Playground (Ctrl+OW) in your [Pharo](https://pharo.org/) image and execute the following Metacello script (select it and press Do-it button or Ctrl+D):

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

## Linear regression

```st
matrixA := #(
    ( 0.12  -8.19   7.69  -2.26  -4.71)
    (-6.91   2.22  -5.12  -9.08   9.96)
    (-3.33  -8.94  -6.72  -4.40  -9.98)
    ( 3.97   3.33  -2.74  -7.92  -3.20)) asAIMatrix.
	
matrixB := #(
    (7.30   0.47  -6.28)
    (1.33   6.58  -3.42)
    (2.68  -1.71   3.46)
    (-9.62  -0.79   0.41)) asAIMatrix.	
	
algo := AILeastSquares new
    matrixA: matrixA;
    matrixB: matrixB;
    yourself.
	
algo solve.

algo solution. "AIMatrix(
    (-0.69  -0.24   0.06)
    (-0.80  -0.08   0.21)
    ( 0.38   0.12  -0.65)
    ( 0.29  -0.24   0.42)
    ( 0.29   0.35  -0.30))"
	
algo singularValues. "#(18.66 15.99 10.01 8.51)"
algo rank. "4"
```

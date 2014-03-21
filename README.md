Wiener process construction in Matlab
=====================================

Matlab function that lets you generate sample paths of a [Wiener process](http://en.wikipedia.org/wiki/Wiener_process, "Wikipedia entry for Wiener process") in the interval [0, 1] using the wavelet method.

Usage
=====

Execute the function by passing as arguments:

1. the numer of samples of the path
2. and the number of iterations of the wavelet construction method.

For example:

```matlab
w = wprocess(2048, 1000);
```

The number of samples in the path must be a power of 2. The higher the numer of iterations, the more accurate the output Wiener process sample path will be.

Now it is possible to plot the sample path:

```matlab
x = linspace(0, 1, 2048);
plot(x, w);
```
![Alt text](/sample/wiener.png "Wiener process sample path")

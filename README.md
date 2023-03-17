# SHTns.jl

[![Stable](https://img.shields.io/badge/docs-stable-blue.svg)](https://fgerick.github.io/SHTns.jl/stable)
[![Dev](https://img.shields.io/badge/docs-dev-blue.svg)](https://fgerick.github.io/SHTns.jl/dev)
[![Build Status](https://github.com/fgerick/SHTns.jl/actions/workflows/CI.yml/badge.svg?branch=master)](https://github.com/fgerick/SHTns.jl/actions/workflows/CI.yml?query=branch%3Amaster)
[![Codecov](https://codecov.io/gh/fgerick/SHTns.jl/branch/master/graph/badge.svg)](https://codecov.io/gh/fgerick/SHTns.jl)


A Julia wrapper around the [SHTns](https://bitbucket.org/nschaeff/shtns) spherical harmonic transform library. 

# This is WORK IN PROGRESS and will certainly have BREAKING changes.

For the moment not a lot is tested. There are wrappers generated by Clang.jl to call most functions exported by the C library. The *more Julian* API is under development. The documentation will come, for the time being I refer to the [documentation of the C library](https://nschaeff.bitbucket.io/shtns/). 

# Installation

```julia
import Pkg; Pkg.add("SHTns")
```


# License 

SHTns.jl is distributed under the GPL-3.0 license in agreement with the CeCILL license of SHTns.
> Copyright (c) 2010-2021 Centre National de la Recherche Scientifique. 
	written by Nathanael Schaeffer (CNRS, ISTerre, Grenoble, France).
	SHTns is distributed under the open source [CeCILL License](http://www.cecill.info/licences/Licence_CeCILL_V2.1-en.html) (GPL compatible) located in the LICENSE file.


# Citation

The SHTns guidelines read:

- A related research paper has been published:
  [Efficient Spherical Harmonic Transforms aimed at pseudo-spectral numerical simulations](http://dx.doi.org/10.1002/ggge.20071),
  also [available from arXiv](http://arxiv.org/abs/1202.6522).
- If you use SHTns for research work, please **cite this paper**:

        @article {shtns,
          author = {Schaeffer, Nathanael},
          title = {Efficient spherical harmonic transforms aimed at pseudospectral numerical simulations},
          journal = {Geochemistry, Geophysics, Geosystems},
          doi = {10.1002/ggge.20071}, volume = {14}, number = {3}, pages = {751--758},
          year = {2013},
        }

  If you use Ishioka's recurrence (the default since SHTns v3.4), you may also want to cite his paper:

        @article {ishioka2018,
          author={Ishioka, Keiichi},
          title={A New Recurrence Formula for Efficient Computation of Spherical Harmonic Transform},
          journal={Journal of the Meteorological Society of Japan},
          doi = {10.2151/jmsj.2018-019}, volume={96}, number={2}, pages={241--249},
          year={2018},
        }

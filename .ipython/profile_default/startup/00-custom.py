try:
    import matplotlib; matplotlib.use('PDF')
    import matplotlib.pyplot as plt
except ModuleNotFoundError:
    pass

try:
    import numpy as np
except ModuleNotFoundError:
    pass

try:
    import torch
    import torch.nn as nn
    import torch.nn.functional as F
except ModuleNotFoundError:
    pass

try:
    import tensorflow as tf
except ModuleNotFoundError:
    pass

try:
    import jax
    import jax.numpy as jnp
    from jax import grad, jit, vmap
except ModuleNotFoundError:
    pass

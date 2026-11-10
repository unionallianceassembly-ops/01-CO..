# Grok-1 setup

This repository provides a reproducible setup wrapper for the official [xai-org/grok-1](https://github.com/xai-org/grok-1) JAX example. It fetches the source and checkpoint into `vendor/grok-1`; the very large checkpoint is kept out of Git.

## Requirements

- Linux and Python 3.10 (the upstream requirements pin JAX 0.4.25).
- NVIDIA GPU hardware and CUDA-compatible drivers. The model has 314B parameters; this is not practical on an ordinary workstation. The upstream example configures an eight-device model mesh and requires substantial GPU memory.
- Enough disk space and bandwidth for the checkpoint download, which is several hundred gigabytes. Check current Hugging Face model storage requirements before starting.

## Setup and run

```bash
./setup.sh
cd vendor/grok-1
python run.py
```

The script clones the official source, installs its pinned dependencies plus Hugging Face Hub transfer support, and downloads the `ckpt-0` checkpoint and tokenizer. Review `setup.sh` before running it; it installs packages and downloads large files. To skip the model-weight download, set `SKIP_WEIGHTS=1` (the inference example will not run without the checkpoint).

The official source and model weights are distributed under Apache-2.0 as described by xAI. See the upstream [license](https://github.com/xai-org/grok-1/blob/main/LICENSE.txt) and model card for the applicable terms and details.

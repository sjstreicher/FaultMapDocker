# FaultMap Docker

Docker image for the [FaultMap](https://github.com/sjstreicher/FaultMap) fault analysis library.

## Quick start

### Pull the image

```bash
docker pull simonstreicher/faultmap
```

### Build locally

```bash
docker build -t faultmap .
```

### Run the container

Set up a local directory with `data/`, `results/`, and `configs/` subdirectories,
then run the container with volumes mounted:

```bash
docker run -it \
  -v ~/faultmap/faultmap_data:/opt/faultmap_data \
  -v ~/faultmap/faultmap_configs:/opt/faultmap_configs \
  -v ~/faultmap/faultmap_results:/opt/faultmap_results \
  faultmap
```

### Run an analysis

Inside the container:

```bash
cd /repos/faultmap
cp /opt/faultmap_configs/case_config.json .
uv run python run_weightcalc.py
```

## Configuration

Copy `config.json` from this repository into your configs directory and adjust
the paths if needed. The expected keys are:

| Key | Default | Description |
|-----|---------|-------------|
| `data_loc` | `/opt/faultmap_data` | Input data directory |
| `config_loc` | `/opt/faultmap_configs` | Case configuration directory |
| `save_loc` | `/opt/faultmap_results` | Output / results directory |
| `infodynamics_loc` | `/repos/faultmap/infodynamics.jar` | Path to the JIDT JAR |

## What's inside

- **Base image:** Python 3.12 (slim)
- **Package manager:** [uv](https://docs.astral.sh/uv/)
- **Java:** JDK (headless) for JIDT information-dynamics calculations
- **System libraries:** HDF5, OpenBLAS, LAPACK, Freetype, Ghostscript, dvipng, LaTeX
- **FaultMap:** cloned to `/repos/faultmap` with all dependencies installed via `uv sync`

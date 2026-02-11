# FaultMap Docker Image
#
# VERSION 1.0

FROM python:3.12-slim

LABEL maintainer="Simon Streicher <streichersj@gmail.com>"
LABEL version="1.0"
LABEL description="Docker image for the FaultMap fault analysis library"

# Install system dependencies
#   - pkg-config, gcc, g++, gfortran: build tools for compiled extensions
#   - git: clone FaultMap repository
#   - default-jdk-headless: Java runtime for JIDT (information dynamics)
#   - ghostscript, dvipng, texlive-latex-extra: LaTeX rendering for plots
#   - libhdf5-dev: HDF5 support for PyTables
#   - libopenblas-dev, liblapack-dev: optimised linear algebra
#   - libfreetype6-dev: font rendering for matplotlib
RUN apt-get update && apt-get install -y --no-install-recommends \
    pkg-config \
    gcc g++ gfortran \
    git \
    default-jdk-headless \
    ghostscript dvipng \
    libhdf5-dev \
    libopenblas-dev liblapack-dev \
    libfreetype6-dev \
    texlive-latex-extra \
    && rm -rf /var/lib/apt/lists/*

# Set JAVA_HOME for JPype1 / JIDT
ENV JAVA_HOME=/usr/lib/jvm/default-java
ENV PATH="${JAVA_HOME}/bin:${PATH}"

# Install uv package manager
COPY --from=ghcr.io/astral-sh/uv:latest /uv /uvx /usr/local/bin/

# Clone FaultMap repository
WORKDIR /repos
RUN git clone https://github.com/sjstreicher/FaultMap.git faultmap

# Install FaultMap and all dependencies via uv
WORKDIR /repos/faultmap
RUN uv sync

# Create data directories for volume mounting
RUN mkdir -p /opt/faultmap_data /opt/faultmap_configs /opt/faultmap_results

# Default command
CMD ["/bin/bash"]

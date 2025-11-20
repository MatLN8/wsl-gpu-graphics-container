ARG BASE_IMAGE=ubuntu:22.04
ARG ADAPTER=NVIDIA

FROM ${BASE_IMAGE}

ARG DEBIAN_FRONTEND=noninteractive

RUN apt-get update && \
    apt-get install -y --no-install-recommends software-properties-common && \
    add-apt-repository ppa:kisak/turtle -y && \
    apt-get update && \
    apt-get dist-upgrade -y

RUN apt-get install -y --no-install-recommends \
    # tools (glxinfo, glxgears)
    mesa-utils \        
    # more tools  
    mesa-utils-extra \    
    # GLVND dispatcher (libGL.so stub)  
    libgl1 \        
    # Gallium drivers (d3d12_dri.so, swrast_dri.so, etc.)        
    libgl1-mesa-dri \        
    # EGL implementation
    libegl1-mesa \    
    # GLES symbols (some apps indirectly need them)      
    libgles2-mesa \
    # X11
    x11-apps \
    libx11-6 \
    libxext6 \
    libxrender1 \
    libxrandr2 \
    libxi6 \
    && rm -rf /var/lib/apt/lists/*

ENV LD_LIBRARY_PATH=/usr/lib/wsl/lib:${LD_LIBRARY_PATH}
ENV MESA_D3D12_DEFAULT_ADAPTER_NAME=${ADAPTER}
ENV GALLIUM_DRIVER=d3d12
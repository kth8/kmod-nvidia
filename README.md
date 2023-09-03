Used by https://github.com/kth8/silverblue

```shell
COPY --from=ghcr.io/kth8/kmod-nvidia:${KERNEL_VERSION} /rpms /var/tmp/nvidia
RUN rpm-ostree install xorg-x11-drv-nvidia-cuda nvidia-vaapi-driver /var/tmp/nvidia/kmod-nvidia-${KERNEL_VERSION}*.rpm
```

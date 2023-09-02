ARG SOURCE_IMAGE="${SOURCE_IMAGE}"
ARG BASE_IMAGE="quay.io/fedora-ostree-desktops/${SOURCE_IMAGE}"
ARG FEDORA_MAJOR_VERSION="${FEDORA_MAJOR_VERSION}"

FROM ${BASE_IMAGE}:${FEDORA_MAJOR_VERSION} as builder
ARG FEDORA_MAJOR_VERSION="${FEDORA_MAJOR_VERSION}"
ARG KERNEL_VERSION="${KERNEL_VERSION}"

RUN rpm-ostree install \
	https://mirrors.rpmfusion.org/free/fedora/rpmfusion-free-release-${FEDORA_MAJOR_VERSION}.noarch.rpm \
	https://mirrors.rpmfusion.org/nonfree/fedora/rpmfusion-nonfree-release-${FEDORA_MAJOR_VERSION}.noarch.rpm

RUN rpm-ostree install akmod-nvidia
RUN ln -s /usr/bin/ld.bfd /etc/alternatives/ld && ln -s /etc/alternatives/ld /usr/bin/ld
RUN akmods --force --kernels ${KERNEL_VERSION} --kmod nvidia

FROM scratch
ARG KERNEL_VERSION="${KERNEL_VERSION}"
COPY --from=builder /var/cache/akmods/nvidia/kmod-nvidia-${KERNEL_VERSION}*.rpm /rpms

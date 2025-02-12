FROM --platform=${BUILDPLATFORM} alpine AS builder

ARG KEYRINGURL="https://repo.archlinuxpower.org/base/any/archpower-keyring-20220105-1.1-any.pkg.tar.zst"
RUN apk add --no-cache bash arch-install-scripts
RUN cat >> /etc/pacman.conf <<HERE
SigLevel = Required DatabaseOptional
LocalFileSigLevel = Optional
[base-any]
Server = https://repo.archlinuxpower.org/base/any
[base]
Server = https://repo.archlinuxpower.org/base/\$arch
HERE
RUN wget "${KEYRINGURL}" -O /tmp/archpower-keyring.pkg.tar.zst
RUN cat > /bootstrap.sh <<HERE
mkdir -p \${1}/var/{lib,cache}/pacman
export PACMAN_KEYRING_DIR=\${1}/etc/pacman.d/gnupg
pacman-key --init
bsdtar --exclude='.*' -xf /tmp/archpower-keyring.pkg.tar.zst -C \${1}
pacman-key --populate archpower --populate-from \${1}/usr/share/pacman/keyrings
cp /etc/pacman.conf \${1}/pacman.tmp
pacman -Sy --noconfirm --config /pacman.tmp --sysroot \${1} --arch \${2} base
rm \${1}/pacman.tmp
HERE
RUN bash /bootstrap.sh /sysroot.ppc64le powerpc64le
RUN bash /bootstrap.sh /sysroot.ppc64 powerpc64
RUN bash /bootstrap.sh /sysroot.ppc powerpc
RUN bash /bootstrap.sh /sysroot.riscv64 riscv64

FROM scratch
ARG TARGETARCH
MAINTAINER Alexander Baldeck <alex.bldck@gmail.com>

COPY --from=builder /sysroot.${TARGETARCH}/ /

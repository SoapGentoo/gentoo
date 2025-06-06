# Copyright 1999-2025 Gentoo Authors
# Distributed under the terms of the GNU General Public License v2

EAPI=8

inherit autotools

DESCRIPTION="Helper library for the x11-misc/matchbox-keyboard package"
HOMEPAGE="https://git.yoctoproject.org/cgit/cgit.cgi/libfakekey"
SRC_URI="https://git.yoctoproject.org/cgit/cgit.cgi/${PN}/snapshot/${P}.tar.bz2"

LICENSE="GPL-2"
SLOT="0"
KEYWORDS="amd64 ~arm arm64 ~hppa ~loong ppc ppc64 ~riscv x86"
IUSE="debug doc"

BDEPEND="
	x11-base/xorg-proto
	doc? ( app-text/doxygen )
"
DEPEND="x11-libs/libXtst"
RDEPEND="${DEPEND}"

PATCHES=( "${FILESDIR}/${P}-ac.patch" ) # Allow configure to use libtool-2

src_prepare() {
	default

	# Fix underlinking bug #367595
	sed -i -e 's/^fakekey_test_LDADD=/fakekey_test_LDADD=-lX11 /' \
		tests/Makefile.am || die 'Cannot sed Makefile.am'
	sed -e "s/AM_CONFIG_HEADER/AC_CONFIG_HEADERS/" -i configure.ac || die
	eautoreconf
}

src_configure() {
	local myeconfargs=(
		# --with/without-x is ignored by configure script and X is used.
		--with-x
		$(use_enable debug)
		$(use_enable doc doxygen-docs)
	)
	econf "${myeconfargs[@]}"
}

src_install() {
	use doc && local HTML_DOCS=( doc/html/. )
	default
	find "${D}" -name '*.la' -type f -delete || die
}

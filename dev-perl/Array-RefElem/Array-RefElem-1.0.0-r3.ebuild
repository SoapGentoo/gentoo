# Copyright 1999-2021 Gentoo Authors
# Distributed under the terms of the GNU General Public License v2

EAPI=7

DIST_AUTHOR=GAAS
DIST_VERSION=1.00
inherit perl-module

DESCRIPTION="Set up array elements as aliases"

SLOT="0"
KEYWORDS="~alpha amd64 ~hppa ~mips ppc ppc64 sparc x86 ~amd64-linux ~x86-linux ~ppc-macos ~x64-macos ~x64-solaris"

src_compile() {
	mymake=(
		"OPTIMIZE=${CFLAGS}"
	)
	perl-module_src_compile
}

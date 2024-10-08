# Copyright 1999-2022 Gentoo Authors
# Distributed under the terms of the GNU General Public License v2

EAPI=7
DIST_AUTHOR=LEONT
DIST_VERSION=0.012
inherit perl-module

DESCRIPTION="Build.PL install path logic made easy"
SLOT="0"
KEYWORDS="~alpha amd64 arm arm64 hppa ~loong ~m68k ~mips ppc ppc64 ~riscv ~s390 sparc x86 ~amd64-linux ~x86-linux ~ppc-macos ~x64-macos ~x64-solaris"
IUSE="test"
RESTRICT="!test? ( test )"

RDEPEND="
	virtual/perl-Carp
	>=dev-perl/ExtUtils-Config-0.2.0
	virtual/perl-File-Spec
"
BDEPEND="${RDEPEND}
	virtual/perl-ExtUtils-MakeMaker
	test? (
		>=virtual/perl-File-Spec-0.830.0
		virtual/perl-File-Temp
		virtual/perl-Test-Simple
	)
"

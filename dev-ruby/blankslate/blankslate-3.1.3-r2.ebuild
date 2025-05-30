# Copyright 1999-2025 Gentoo Authors
# Distributed under the terms of the GNU General Public License v2

EAPI=8

USE_RUBY="ruby31 ruby32 ruby33 ruby34"

RUBY_FAKEGEM_EXTRADOC="README"

RUBY_FAKEGEM_RECIPE_TEST="rspec3"

inherit ruby-fakegem

DESCRIPTION="Base class with almost all of the methods from Object and Kernel being removed"
HOMEPAGE="https://rubygems.org/gems/blankslate"

LICENSE="MIT"
SLOT="0"
KEYWORDS="~alpha amd64 arm arm64 ~hppa ~loong ppc ppc64 ~riscv ~s390 sparc x86"

all_ruby_prepare() {
	# Avoid test failing with rspec 2.x.
	sed -i -e '/cleanliness/,/^  end/ s:^:#:' spec/blankslate_spec.rb || die
}

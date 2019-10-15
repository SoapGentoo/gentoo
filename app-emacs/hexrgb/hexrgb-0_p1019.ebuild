# Copyright 1999-2019 Gentoo Authors
# Distributed under the terms of the GNU General Public License v2

EAPI=7

inherit elisp

DESCRIPTION="Functions to manipulate colors, including RGB hex strings"
HOMEPAGE="https://www.emacswiki.org/emacs/hexrgb.el"
SRC_URI="https://dev.gentoo.org/~ulm/distfiles/${P}.el.xz"

LICENSE="GPL-2+"
SLOT="0"
KEYWORDS="~amd64 ~ppc ~sparc ~x86"

SITEFILE="50${PN}-gentoo.el"

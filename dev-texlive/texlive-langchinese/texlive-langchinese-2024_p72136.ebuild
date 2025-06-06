# Copyright 1999-2025 Gentoo Authors
# Distributed under the terms of the GNU General Public License v2

EAPI=8

TEXLIVE_MODULE_CONTENTS="
	collection-langchinese.r72136
	arphic.r15878
	arphic-ttf.r42675
	cns.r45677
	ctex.r71527
	exam-zh.r69917
	fandol.r37889
	fduthesis.r67231
	hanzibox.r63062
	hyphen-chinese.r58652
	nanicolle.r56224
	njurepo.r50492
	pgfornament-han.r72640
	qyxf-book.r56319
	sjtutex.r72826
	suanpan-l3.r72540
	upzhkinsoku.r47354
	xpinyin.r66115
	xtuthesis.r47049
	zhlineskip.r51142
	zhlipsum.r54994
	zhmetrics.r22207
	zhmetrics-uptex.r40728
	zhnumber.r66115
	zhspacing.r41145
"
TEXLIVE_MODULE_DOC_CONTENTS="
	arphic.doc.r15878
	arphic-ttf.doc.r42675
	asymptote-by-example-zh-cn.doc.r15878
	asymptote-faq-zh-cn.doc.r15878
	asymptote-manual-zh-cn.doc.r15878
	cns.doc.r45677
	ctex.doc.r71527
	ctex-faq.doc.r15878
	exam-zh.doc.r69917
	fandol.doc.r37889
	fduthesis.doc.r67231
	hanzibox.doc.r63062
	impatient-cn.doc.r54080
	install-latex-guide-zh-cn.doc.r72158
	latex-notes-zh-cn.doc.r15878
	lshort-chinese.doc.r67025
	nanicolle.doc.r56224
	njurepo.doc.r50492
	pgfornament-han.doc.r72640
	qyxf-book.doc.r56319
	sjtutex.doc.r72826
	suanpan-l3.doc.r72540
	texlive-zh-cn.doc.r71700
	texproposal.doc.r43151
	tlmgr-intro-zh-cn.doc.r59100
	upzhkinsoku.doc.r47354
	xpinyin.doc.r66115
	xtuthesis.doc.r47049
	zhlineskip.doc.r51142
	zhlipsum.doc.r54994
	zhmetrics.doc.r22207
	zhmetrics-uptex.doc.r40728
	zhnumber.doc.r66115
	zhspacing.doc.r41145
"
TEXLIVE_MODULE_SRC_CONTENTS="
	ctex.source.r71527
	fduthesis.source.r67231
	hanzibox.source.r63062
	njurepo.source.r50492
	sjtutex.source.r72826
	xpinyin.source.r66115
	zhlipsum.source.r54994
	zhmetrics.source.r22207
	zhnumber.source.r66115
"

inherit texlive-module

DESCRIPTION="TeXLive Chinese"

LICENSE="FDL-1.1+ GPL-1+ GPL-3+ LGPL-2+ LPPL-1.3 LPPL-1.3c MIT TeX TeX-other-free public-domain"
SLOT="0"
KEYWORDS="amd64 ~ppc ~ppc64 ~x86"
COMMON_DEPEND="
	>=dev-texlive/texlive-langcjk-2024
"
RDEPEND="
	${COMMON_DEPEND}
"
DEPEND="
	${COMMON_DEPEND}
"

# Avoids collision with app-text/ttf2pk2
src_prepare() {
	default
	local i=texmf-dist/source/fonts/zhmetrics/ttfonts.map
	if [[ -f "${i}" ]]; then
		rm -f "${i}" || die
	fi
}

# Copyright 2021-2025 Gentoo Authors
# Distributed under the terms of the GNU General Public License v2

EAPI=8

PYTHON_COMPAT=( python3_{10..13} )
DISTUTILS_USE_PEP517=setuptools
export SETUPTOOLS_SCM_PRETEND_VERSION=${PV}
inherit distutils-r1

DESCRIPTION="Python Data, Leaflet.js Maps"
HOMEPAGE="https://github.com/python-visualization/folium"
SRC_URI="https://github.com/python-visualization/${PN}/archive/refs/tags/v${PV}.tar.gz -> ${P}.tar.gz"

LICENSE="MIT"
SLOT="0"
KEYWORDS="~amd64 ~arm64 ~x86"

PATCHES=(
	"${FILESDIR}"/${PN}-0.15.1-gentoo.patch
)

RDEPEND="sci-geosciences/xyzservices[${PYTHON_USEDEP}]
	sci-libs/branca[${PYTHON_USEDEP}]
	dev-python/jinja2[${PYTHON_USEDEP}]
	dev-python/requests[${PYTHON_USEDEP}]
	dev-python/numpy[${PYTHON_USEDEP}]"
DEPEND="${RDEPEND}"
BDEPEND="
	dev-python/setuptools-scm
	test? (
		dev-python/pillow[${PYTHON_USEDEP}]
		dev-python/pandas[${PYTHON_USEDEP}]
	)"

distutils_enable_tests pytest

EPYTEST_IGNORE=(
	tests/selenium									# require chromedriver
	tests/test_folium.py							# require geopandas
	tests/plugins/test_time_slider_choropleth.py	# require geopandas
	tests/test_repr.py								# require geckodriver
)

python_test() {
	epytest -m 'not web'
}

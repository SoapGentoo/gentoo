# Copyright 1999-2025 Gentoo Authors
# Distributed under the terms of the GNU General Public License v2

EAPI=8

PYTHON_COMPAT=( python3_{11..13} pypy3_11 )
DISTUTILS_USE_PEP517=hatchling

inherit distutils-r1 pypi xdg-utils

DESCRIPTION="Jupyter Notebook as a Jupyter Server Extension"
HOMEPAGE="
	https://jupyter.org/
	https://github.com/jupyter/nbclassic/
	https://pypi.org/project/nbclassic/
"

LICENSE="BSD"
SLOT="0"
KEYWORDS="amd64 arm arm64 ~loong ppc64 ~riscv x86"

RDEPEND="
	dev-python/ipykernel[${PYTHON_USEDEP}]
	dev-python/ipython-genutils[${PYTHON_USEDEP}]
	>=dev-python/nest-asyncio-1.5[${PYTHON_USEDEP}]
	>=dev-python/notebook-shim-0.2.3[${PYTHON_USEDEP}]
"

BDEPEND="
	dev-python/hatch-jupyter-builder[${PYTHON_USEDEP}]
	test? (
		dev-python/nbval[${PYTHON_USEDEP}]
		dev-python/pytest-jupyter[${PYTHON_USEDEP}]
		dev-python/pytest-tornasync[${PYTHON_USEDEP}]
		dev-python/requests[${PYTHON_USEDEP}]
		dev-python/requests-unixsocket[${PYTHON_USEDEP}]
		dev-python/testpath[${PYTHON_USEDEP}]
	)
	doc? (
		virtual/pandoc
	)
"

distutils_enable_tests pytest
distutils_enable_sphinx docs/source \
	dev-python/pydata-sphinx-theme \
	dev-python/nbsphinx \
	dev-python/sphinxcontrib-github-alt \
	dev-python/myst-parser \
	dev-python/ipython-genutils

src_prepare() {
	distutils-r1_src_prepare

	# Confuses hatchling sometimes, resulting in partial install.
	# https://github.com/jupyter/nbclassic/issues/336
	rm .gitignore || die

	# Let's save some space at build-time, we're not using them anyway.
	rm -r node_modules || die

	# Dead symlinks that trip up hatchling sometimes, depending
	# on the phase of the moon.
	rm nbclassic/static/components/jquery-typeahead/node_modules/.bin/lz-string || die
	# Symlink to itself.
	rm nbclassic/static/components/moment/meteor/moment.js || die
}

python_test() {
	local -x PYTEST_DISABLE_PLUGIN_AUTOLOAD=1

	# Notebook interferes with our tests, pretend it does not exist
	echo "raise ImportError" > notebook.py || die

	epytest -p pytest_tornasync.plugin
}

python_install_all() {
	distutils-r1_python_install_all
	# move /usr/etc stuff to /etc
	mv "${ED}/usr/etc" "${ED}/etc" || die
}

pkg_postinst() {
	xdg_desktop_database_update
	xdg_icon_cache_update
}

pkg_postrm() {
	xdg_desktop_database_update
	xdg_icon_cache_update
}

SRC = $(wildcard nbs/*.ipynb)

all: I2T2 docs

I2T2: $(SRC)
	nbdev_build_lib
	touch I2T2

docs_serve: docs
	cd docs && bundle exec jekyll serve

docs: $(SRC)
	nbdev_build_docs
	touch docs

test:
	nbdev_test_nbs

release: pypi
	nbdev_bump_version

pypi: dist
	twine upload --repository pypi dist/*

dist: clean
	python setup.py sdist bdist_wheel

clean:
	rm -rf dist
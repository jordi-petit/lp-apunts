all:
	gulp

install:
	npm install
	(cd src/js ; npm install)

pub:
	tar cz build | ssh jpetit@login1.cs.upc.edu 'cd public_html ; rm -rf LP ; tar xz ; mv build LP'

clean:
	rm -rf build
	rm -rf node_modules
	rm -rf src/js/node_modules

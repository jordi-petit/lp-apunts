all:
	gulp

install:
	npm install
	(cd src/js ; npm install)

pub:
	tar cz build | ssh -p 2222 jpetit@jutge.cs.upc.edu 'cd www ; rm -rf lp ; tar xz ; mv build lp'

clean:
	rm -rf build
	rm -rf node_modules
	rm -rf src/js/node_modules

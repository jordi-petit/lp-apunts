all:
	(cd src/js ; bower install)
	gulp

install:
	ssh -p 2222 jpetit@jutge.cs.upc.edu rm -rf www/lp
	tar cz build | ssh -p 2222 jpetit@jutge.cs.upc.edu 'cd www ; tar xz ; mv build lp'

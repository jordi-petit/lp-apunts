all:
	(cd src/js ; bower install)
	gulp

install:
	ssh -p 2222 jpetit@jutge.cs.upc.edu rm -rf www/lp
	scp -P 2222 -r build jpetit@jutge.cs.upc.edu:www/lp

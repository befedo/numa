pdf:
	pdflatex dokument.tex

all:
	pdflatex dokument.tex
	makeindex dokument.nlo -s nomencl.ist -o dokument.nls
	bibtex dokument.aux
	pdflatex dokument.tex
	pdflatex dokument.tex

glo:
	pdflatex dokument.tex
	makeindex dokument.nlo -s nomencl.ist -o dokument.nls
	pdflatex dokument.tex

clean:
	rm -f *.pdf *.bbl *.blg *.aux *.dvi *.log *.nav *.out *.snm *.toc *.vrb *~ *.backup *.lof *.url *.glg *.glo *.gls *.ist *.lol *.nls *.ilg *.nlo *.lot


all: opajournal.exe

opajournal.exe: src/main.opa
	opa src/main.opa -o opajournal.exe

clean:
	\rm -Rf *.exe _build _tracks *.log

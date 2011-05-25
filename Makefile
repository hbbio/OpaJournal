all: opajournal.exe

opa_chat.exe: src/main.opa
	opa src/main.opa -o opa_journal.exe

clean:
	\rm -Rf *.exe _build _tracks *.log

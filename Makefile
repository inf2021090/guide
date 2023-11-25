chapters = $(wildcard text/ch[0-8].txt)

book.tex: $(chapters)
	cat $(chapters) > $@

%.tex: text/%.txt
	pandoc $< -s -o $@

clean:
	rm text/*.tex book.tex


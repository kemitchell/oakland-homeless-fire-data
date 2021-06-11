targets=reports/month-histogram 2020.geojson 2020-heat.geojson

all: $(targets)

2020.geojson: 2020.tsv togeojson
	./togeojson < $< > $@

2020-heat.geojson: 2020.tsv toheatmapish
	./toheatmapish < $< > $@

reports/month-histogram: 2020.tsv | reports
	cut -f 1 < $< | sed 's/[0-9]\{4\}-\([0-9]\{2\}\)-[0-9]\{2\}/\1/' | xargs -I {} date -d "{}/01" +\%B | uniq -c > $@

reports:
	mkdir -p $@

.PHONY: clean

clean:
	rm -f $(targets)

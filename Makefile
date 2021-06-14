months=01 02 03 04 05 06 07 08 09 10 11 12
targets=reports/month-histogram 2020.geojson 2020-heat.geojson $(foreach month,$(months),2020-heat-$(month).geojson)

all: $(targets)

2020.geojson: 2020.tsv togeojson
	./togeojson < $< > $@

2020-heat.geojson: 2020.tsv toheatmapish
	./toheatmapish < $< > $@

2020-heat-%.geojson: 2020.tsv toheatmapish
	./toheatmapish 2020-$* < $< > $@

reports/month-histogram: 2020.tsv | reports
	cut -f 1 < $< | sed 's/[0-9]\{4\}-\([0-9]\{2\}\)-[0-9]\{2\}/\1/' | xargs -I {} date -d "{}/01" +\%B | uniq -c > $@

reports:
	mkdir -p $@

.PHONY: clean

clean:
	rm -f $(targets)

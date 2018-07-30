Debian UDD into Graph Database
==============================

The scripts in this repository pull (some) data from the
[Ultimate Debian Database](https://wiki.debian.org/UltimateDebianDatabase/)
and convert them to a graph database, in particular [Neo4j](https://neo4j.com/).

A detailed description of the process is available either on my blog
([Part 1](https://www.preining.info/blog/2018/04/analysing-debian-packages-with-neo4j-part-1-debian/),
[Part 2](https://www.preining.info/blog/2018/04/analysing-debian-packages-with-neo4j-part-2-udd-and-graph-db-schema/),
[Part 3](https://www.preining.info/blog/2018/05/analysing-debian-packages-with-neo4j-part-3-getting-data-from-udd-into-neo4j/)),
or [debian-package-neo4j.md](debian-package-neo4j.md).

The scripts here are:

- `pull-udd.pl` queries the UDD and downloads the two tables for packages
and sources. Needs DBI::PG Perl module. This scripts
needs quite some time, as the server is not fast. Please be patient.
- `generate-graph` is a Perl script that reads the two csv files generated
from `pull-udd.pl` and generates csv files ready to be imported into
Neo4j
- `sort-uniq.sh` ensures that duplicate lines are removed from the csvs
- `build-db` assembles the proper command line for `neo4j-import`
- `build-all` glues everything together

After the scripts has run, the files generated are in `debian-neo4j` 
and can be used as Neo4j database files.

Comments and improvements are always welcome.

Copyright
---------
Copyright 2017 Norbert Preining

License: GPL3+

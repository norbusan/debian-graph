
$^W = 1;
use strict;
use DBI;
use Data::Dumper;
$Data::Dumper::Indent = 1;
$Data::Dumper::Sortkeys = 1;  # stable output
$Data::Dumper::Purity = 1; # recursive structures must be safe

#my $limit = " limit 10";
my $limit = "";

my $udd = DBI->connect("DBI:Pg:dbname=udd;host=public-udd-mirror.xvm.mit.edu", "public-udd-mirror", "public-udd-mirror");

# source version maintainer maintainer_name maintainer_email format files uploaders bin architecture standards_version homepage build_depends build_depends_indep build_conflicts build_conflicts_indep priority section distribution release component vcs_type vcs_url vcs_browser python_version ruby_versions checksums_sha1 checksums_sha256 original_maintainer dm_upload_allowed testsuite autobuild extra_source_only

my $srcquery = $udd->prepare("SELECT source,version,maintainer_email,maintainer_name,release,uploaders,bin,architecture,build_depends,build_depends_indep,build_conflicts,build_conflicts_indep from sources$limit");

my $sources;
my $packages;

my $ret = $srcquery->execute();
if ($ret) {
  $sources  = $srcquery->fetchall_arrayref;
} else {
  die("Cannot get source: $!");
}

my $binquery = $udd->prepare("SELECT package,version,maintainer_email,maintainer_name,release,description,depends,recommends,suggests,conflicts,breaks,provides,replaces,pre_depends,enhances from packages$limit");

my $ret = $binquery->execute();
if ($ret) {
  $packages  = $binquery->fetchall_arrayref;
} else {
  die("Cannot get packages $!");
}

open(my $fd, ">", "udd.dump") || die("Cannot open udd.dump for writing: $!");
print $fd Data::Dumper->Dump([\$sources, \$packages], [qw(source packages)]);

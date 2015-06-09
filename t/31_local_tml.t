use strict;
use warnings;
use lib 't/lib/';
use Test::More 0.99;
use TestBridge;
use IO::Dir;
use File::Spec::Functions qw/catdir/;

my $tml_local = "t/tml-local";

for my $dir ( IO::Dir->new($tml_local)->read ) {
    next if $dir =~ /^\./;
    my $fn = "test_$dir";
    $fn =~ s/-/_/g;
    $fn =~ s/\.DIR\z//i if $^O eq 'VMS';
    my $bridge = TestBridge->can($fn);
    next unless $bridge;
    print qq{run_all_testml_files( "TestML", catdir($tml_local, $dir), $bridge );\n};
    run_all_testml_files( "TestML", catdir($tml_local, $dir), $bridge );
    last;
}

done_testing;

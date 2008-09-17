# Before `make install' is performed this script should be runnable with
# `make test'. After `make install' it should work as `perl File-Magic.t'

#########################

# change 'tests => 1' to 'tests => last_test_to_print';

use Test::More tests => 3;
use Data::Dumper;
use Cwd qw(realpath);
BEGIN { use_ok('File::Magic') };

my $loaded = 1;

END {print "not ok 1\n" unless $loaded;}

#########################

# Insert your test code below, the Test::More module is use()ed here so read
# its man page ( perldoc Test::More ) for help writing this test script.

my $fm = File::Magic->new();
isa_ok ( $fm, "File::Magic" );
my $type = $fm->type(realpath($^X));
ok( defined($type) );
my $errmsg = $fm->errmsg();
print( Dumper( \$errmsg ) );

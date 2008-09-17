package File::Magic;

use 5.008008;
use strict;
use warnings;

use vars qw(@ISA %EXPORT_TAGS @EXPORT_OK @EXPORT $VERSION);
use Exporter;

@ISA = qw(Exporter);

# Items to export into callers namespace by default. Note: do not export
# names by default without a very good reason. Use EXPORT_OK instead.
# Do not simply export all your public functions/methods/constants.

# This allows declaration	use File::Magic ':all';
# If you do not need this, moving things directly into @EXPORT or @EXPORT_OK
# will save memory.
%EXPORT_TAGS = ( 'all' => [ qw(
	
) ] );

@EXPORT_OK = ( @{ $EXPORT_TAGS{'all'} } );

@EXPORT = qw();

$VERSION = '0.01';

sub new
{
    my $className = shift;
    my $magic = &load(@_);

    my %instance = (
        magic => $magic,
    );

    my $self = bless( \%instance, $className );

    return $self;
}

sub type
{
    my $self = shift;
    my $filename = shift;

    return filetype( $self->{magic}, $filename ) ;
}

sub errmsg
{
    my $self = shift;
    return error( $self->{magic} );
}

sub DESTROY
{
    my $self = shift;
    unload($self->{magic});
}

require XSLoader;
XSLoader::load('File::Magic', $VERSION);

# Preloaded methods go here.

1;
__END__
# Below is stub documentation for your module. You'd better edit it!

=head1 NAME

File::Magic - Perl extension for embedding file(1)'s libmagic

=head1 SYNOPSIS

  use File::Magic;
  my $magic => File::Magic->new( [ '/path/to/personal/magic' [, flags ] ] );
  my $filetype = $magic->type( File::Spec->catfile( qw(path to file) );
  unless( defined( $filetype ) )
  {
      croak( $magic->errmsg() );
  }
  print( "$filetype\n" );

=head1 DESCRIPTION

This module covers simply getting the file type by using magic_file from
libmagic(3) from Ian F. Darwin, Måns Rullgård and Christos Zoulas.
The main improvement is no fork(2) is required to get the type of a file
and an impressive speed improvement come with that when a lot of files
needs to be typed ;-)

=head2 EXPORT

None.

=head2 FUNCTIONS

=over 4

=item new

C<File::Magic->new()> instantiates a new object of C<File::Magic>. It creates
a new instance within libmagic. Any further calls via this object will have
the same magic file and the same flags.

=item type

Returns the "magic" type of the specified file or
  sprintf( "%s: %s", $filename, strerror( $! ) );
If an internal error within libmagic happens, undef is returned.

=item errmsg

If - and only if - an error happened within libmagic, the method returns the
corrresponding error string.

=head1 SEE ALSO

See file(1) and libmagic(3). If your system doesn't contain a compatible
file command, see L<ftp://ftp.astron.com/pub/file/>.

=head1 AUTHOR

Jens Rehsack E<lt>rehsack@web.deE<gt>

=head1 COPYRIGHT AND LICENSE

Copyright (C) 2008 by Jens Rehsack

This library is free software; you can redistribute it and/or modify
it under the same terms as Perl itself, either Perl version 5.8.8 or,
at your option, any later version of Perl 5 you may have available.

=cut

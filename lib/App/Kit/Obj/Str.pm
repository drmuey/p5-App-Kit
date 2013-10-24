package App::Kit::Obj::Str;

## no critic (RequireUseStrict) - Moo does strict
use Moo;

our $VERSION = '0.1';

sub portable_crlf {
    return "\015\012";    # "\r\n" is not portable
}

sub zero_but_true { return "0E0"; }

Sub::Defer::defer_sub __PACKAGE__ . '::bytes_size' => sub {
    require String::UnicodeUTF8;
    return sub {
        shift;
        goto &String::UnicodeUTF8::bytes_size;
    };
};

Sub::Defer::defer_sub __PACKAGE__ . '::char_count' => sub {
    require String::UnicodeUTF8;
    return sub {
        shift;
        goto &String::UnicodeUTF8::char_count;
    };
};

has prefix => (
    is   => 'rw',
    lazy => 1,
    isa  => sub {
        die "prefix must be at least 1 character"      unless length( $_[0] ) > 0;
        die "prefix can only contain A-Z and 0-9"      unless $_[0] =~ m/\A[A-Za-z0-9]+\z/;
        die "prefix can not be more than 6 characters" unless length( $_[0] ) < 7;
    },
    default => sub { return 'appkit' },
);

# TODO: trim && ws_norm($str)

1;

=encoding utf-8

=head1 NAME

App::Kit::Obj::FIX - FIX utility object

=head1 VERSION

This document describes App::Kit::Obj::FIX version 0.1

=head1 SYNOPSIS

    $obj->FIX()

=head1 DESCRIPTION

FIX utility object

=head1 INTERFACE

=head2 FIX()

FIX

=head1 DIAGNOSTICS

Throws no warnings or errors of its own.

=head1 CONFIGURATION AND ENVIRONMENT

Requires no configuration files or environment variables.

=head1 DEPENDENCIES

L<FIX>

=head1 INCOMPATIBILITIES

None reported.

=head1 BUGS AND LIMITATIONS

No bugs have been reported.

Please report any bugs or feature requests to
C<bug-app-kit@rt.cpan.org>, or through the web interface at
L<http://rt.cpan.org>.

=head1 AUTHOR

Daniel Muey  C<< <http://drmuey.com/cpan_contact.pl> >>

=head1 LICENCE AND COPYRIGHT

Copyright (c) 2013, Daniel Muey C<< <http://drmuey.com/cpan_contact.pl> >>. All rights reserved.

This module is free software; you can redistribute it and/or
modify it under the same terms as Perl itself. See L<perlartistic>.

=head1 DISCLAIMER OF WARRANTY

BECAUSE THIS SOFTWARE IS LICENSED FREE OF CHARGE, THERE IS NO WARRANTY
FOR THE SOFTWARE, TO THE EXTENT PERMITTED BY APPLICABLE LAW. EXCEPT WHEN
OTHERWISE STATED IN WRITING THE COPYRIGHT HOLDERS AND/OR OTHER PARTIES
PROVIDE THE SOFTWARE "AS IS" WITHOUT WARRANTY OF ANY KIND, EITHER
EXPRESSED OR IMPLIED, INCLUDING, BUT NOT LIMITED TO, THE IMPLIED
WARRANTIES OF MERCHANTABILITY AND FITNESS FOR A PARTICULAR PURPOSE. THE
ENTIRE RISK AS TO THE QUALITY AND PERFORMANCE OF THE SOFTWARE IS WITH
YOU. SHOULD THE SOFTWARE PROVE DEFECTIVE, YOU ASSUME THE COST OF ALL
NECESSARY SERVICING, REPAIR, OR CORRECTION.

IN NO EVENT UNLESS REQUIRED BY APPLICABLE LAW OR AGREED TO IN WRITING
WILL ANY COPYRIGHT HOLDER, OR ANY OTHER PARTY WHO MAY MODIFY AND/OR
REDISTRIBUTE THE SOFTWARE AS PERMITTED BY THE ABOVE LICENCE, BE
LIABLE TO YOU FOR DAMAGES, INCLUDING ANY GENERAL, SPECIAL, INCIDENTAL,
OR CONSEQUENTIAL DAMAGES ARISING OUT OF THE USE OR INABILITY TO USE
THE SOFTWARE (INCLUDING BUT NOT LIMITED TO LOSS OF DATA OR DATA BEING
RENDERED INACCURATE OR LOSSES SUSTAINED BY YOU OR THIRD PARTIES OR A
FAILURE OF THE SOFTWARE TO OPERATE WITH ANY OTHER SOFTWARE), EVEN IF
SUCH HOLDER OR OTHER PARTY HAS BEEN ADVISED OF THE POSSIBILITY OF
SUCH DAMAGES.

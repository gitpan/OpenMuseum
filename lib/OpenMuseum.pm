package OpenMuseum;

use 5.006;
use strict;
use warnings FATAL => 'all';
use feature ':5.10';
use YAML qw/LoadFile DumpFile/;
use DBI;

=head1 NAME

OpenMuseum - Data provider or the OpenMusem museum management
system.

=head1 VERSION

Version 0.80

=cut

our $VERSION = '0.80';


=head1 SYNOPSIS

Quick summary of what the module does.

Perhaps a little code snippet.

    use OpenMuseum;

    my $foo = OpenMuseum->new();
    ...

=head1 METHODS

=head2 new

The new routine returns an initialized OpenMuseum object.

This method takes arguments as a hash consttructor.

EG:
    $om = OpenMuseum->new('config' => "config.yml");
One of the options must be config, and it must point to a file

=cut

sub new{
    $class = shift;
    %options = @_;
    $self = {};
    bless $self, $class;
    $self->{options} = %options;
    $self->initialize();
    return $self;
}

=head2 initialize

=cut

sub initialize{
    $self = shift;
    $self->{config} = LoadFile($self->{options}->{config});
    $self->{dbn} = $self->gendbn();
    $self->{dbh} = DBI->connect($self->{dbn}, $self->{config}->{userName}, $self->{config}->{password});
}

=head2 gendb

=cut

sub gendb{
    $self = shift;
    return "DBI:mysql:".$self->{config}->{db}.";host=".$self->{config}->{host};
}

=head2 authfiles

=cut

sub authfiles{
    $self = shift;
    $file = lc(shift);
    $statement = "SELECT item FROM authfiles WHERE filename == '$file'";
    return $self->{dbh}->selectall_arrayref($statement);
}

=head2 authen

=cut

sub authen{
    $self = shift;
    $user = shift;
    $pass = shift;
    $query = "SELECT id FROM users WHERE name == $user AND pass == $pass";
    $res = $self->{dbh}->selectrow_hashref($query, "id");
    if (defined($res)) {
        return $res->{id};
    } else {
        return undef;
    }
}

=head2 options

=cut

sub options{
    $self = shift;
    $name = shift;
    $val = shift;
    $self->{options}->{$name} = defined($val) ? $val : $self->{options}->{$name};
    return $self->{options}->{$name};
}

=head2 report

=cut

sub report{
    $self = shift;
    $report = shift;
    $reffield = shift;
    if ($report =~ /^select.*/i) {
        return $self->{dbh}->selectall_hashref($report, $reffield);
    }else {
        return "Bad Report, not select!";
    }
}

=head2 accessions

=cut

sub accessions{
    $self = shift;
    $type = shift;
    if ($type eq "query") {
    } elsif ($type eq "ids") {
    } elsif ($type eq "retrieve") {
    } elsif ($type eq "modify") {
    } elsif ($type eq "create") {
    } else {
        
    }
}

=head2 multimedia

=cut

sub multimedia{
    $self = shift;
    $type = shift;
    if ($type eq "query") {
    } elsif ($type eq "ids") {
    } elsif ($type eq "retrieve") {
    } elsif ($type eq "modify") {
    } elsif ($type eq "create") {
    } else {
        
    }

}

=head2 contacts

=cut

sub contacts{
    $self = shift;
    $type = shift;
    if ($type eq "query") {
    } elsif ($type eq "ids") {
    } elsif ($type eq "retrieve") {
    } elsif ($type eq "modify") {
    } elsif ($type eq "create") {
    } else {
        
    }

}

=head2 memberships

=cut

sub memberships{
    $self = shift;
    
}

=head2 archive

=cut

sub archive{
    $self = shift;
    $type = shift;
    if ($type eq "query") {
    } elsif ($type eq "ids") {
    } elsif ($type eq "retrieve") {
    } elsif ($type eq "modify") {
    } elsif ($type eq "create") {
    } else {
        
    }

}

=head2 exhibits

=cut

sub exhibits{
    $self = shift;
    $type = shift;
    if ($type eq "list") {
    } elsif ($type eq "create") {
    } elsif ($type eq "suspend") {
    } elsif ($type eq "display") {
    } elsif ($type eq "edit") {
    } else {
        
    }
}

=head2 control

=cut

sub control{
    $self = shift;
    $type = shift;
}

=head1 AUTHOR

Samuel W. Flint, C<< <linuxkid at linux.com> >>

=head1 BUGS

Please report any bugs or feature requests to C<bug-openmuseum at rt.cpan.org>, or through
the web interface at L<http://rt.cpan.org/NoAuth/ReportBug.html?Queue=OpenMuseum>.  I will be notified, and then you'll
automatically be notified of progress on your bug as I make changes.




=head1 SUPPORT

You can find documentation for this module with the perldoc command.

    perldoc OpenMuseum


You can also look for information at:

=over 4

=item * RT: CPAN's request tracker (report bugs here)

L<http://rt.cpan.org/NoAuth/Bugs.html?Dist=OpenMuseum>

=item * AnnoCPAN: Annotated CPAN documentation

L<http://annocpan.org/dist/OpenMuseum>

=item * CPAN Ratings

L<http://cpanratings.perl.org/d/OpenMuseum>

=item * Search CPAN

L<http://search.cpan.org/dist/OpenMuseum/>

=back


=head1 ACKNOWLEDGEMENTS


=head1 LICENSE AND COPYRIGHT

Copyright 2013 Samuel W. Flint.

This program is free software; you can redistribute it and/or modify
it under the terms of the GNU General Public License as published by
the Free Software Foundation; version 2 dated June, 1991 or at your option
any later version.

This program is distributed in the hope that it will be useful,
but WITHOUT ANY WARRANTY; without even the implied warranty of
MERCHANTABILITY or FITNESS FOR A PARTICULAR PURPOSE.  See the
GNU General Public License for more details.

A copy of the GNU General Public License is available in the source tree;
if not, write to the Free Software Foundation, Inc.,
59 Temple Place - Suite 330, Boston, MA 02111-1307, USA.


=cut

1; # End of OpenMuseum

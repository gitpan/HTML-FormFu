package HTML::FormFu::Constraint::Email;
$HTML::FormFu::Constraint::Email::VERSION = '2.01';
use Moose;
extends 'HTML::FormFu::Constraint';

use Email::Valid;

sub constrain_value {
    my ( $self, $value ) = @_;

    return 1 if !defined $value || $value eq '';

    my $ok = Email::Valid->address( -address => $value );

    return $ok;
}

__PACKAGE__->meta->make_immutable;

1;

__END__

=head1 NAME

HTML::FormFu::Constraint::Email - Email Address Constraint

=head1 DESCRIPTION

Checks the input value is an email address according to the C<address> 
method of L<Email::Valid>.

=head2 SEE ALSO

Is a sub-class of, and inherits methods from L<HTML::FormFu::Constraint>

L<HTML::FormFu>

=head1 AUTHOR

Carl Franks C<cfranks@cpan.org>

=head1 LICENSE

This library is free software, you can redistribute it and/or modify it under
the same terms as Perl itself.

=cut

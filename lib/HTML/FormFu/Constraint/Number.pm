package HTML::FormFu::Constraint::Number;
$HTML::FormFu::Constraint::Number::VERSION = '2.01';
use Moose;
extends 'HTML::FormFu::Constraint';

use Scalar::Util qw( looks_like_number );

sub constrain_value {
    my ( $self, $value ) = @_;

    return 1 if !defined $value || $value eq '';

    my $ok = looks_like_number($value);

    return $self->not ? !$ok : $ok;
}

__PACKAGE__->meta->make_immutable;

1;

__END__

=head1 NAME

HTML::FormFu::Constraint::Number - Numerical Constraint

=head1 DESCRIPTION

The input must be a number.

=head1 SEE ALSO

Is a sub-class of, and inherits methods from L<HTML::FormFu::Constraint>

L<HTML::FormFu>

=head1 AUTHOR

Carl Franks C<cfranks@cpan.org>

=head1 LICENSE

This library is free software, you can redistribute it and/or modify it under
the same terms as Perl itself.

=cut

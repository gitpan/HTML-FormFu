package HTML::FormFu::Constraint::Bool;
$HTML::FormFu::Constraint::Bool::VERSION = '2.01';
use Moose;
extends 'HTML::FormFu::Constraint::Regex';

sub regex {
    return qr/^[01]?\z/;
}

__PACKAGE__->meta->make_immutable;

1;

__END__

=head1 NAME

HTML::FormFu::Constraint::Bool - Boolean Constraint

=head1 DESCRIPTION

Value must be either 1 or 0.

=head1 SEE ALSO

Is a sub-class of, and inherits methods from L<HTML::FormFu::Constraint::Regex>,
L<HTML::FormFu::Constraint>

L<HTML::FormFu>

=head1 AUTHOR

Carl Franks C<cfranks@cpan.org>

=head1 LICENSE

This library is free software, you can redistribute it and/or modify it under
the same terms as Perl itself.

=cut

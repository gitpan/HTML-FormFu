package HTML::FormFu::Constraint::Printable;
$HTML::FormFu::Constraint::Printable::VERSION = '2.01';
use Moose;
extends 'HTML::FormFu::Constraint::Regex';

sub regex {
    return qr/^\p{IsPrint}*\z/;
}

__PACKAGE__->meta->make_immutable;

1;

__END__

=head1 NAME

HTML::FormFu::Constraint::Printable - Printable Characters Constraint

=head1 DESCRIPTION

Constraint that checks against the unicode C<print> character class, 
(Alphanumeric, punct, and space).

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

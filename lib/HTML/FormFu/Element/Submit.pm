package HTML::FormFu::Element::Submit;
$HTML::FormFu::Element::Submit::VERSION = '2.01';
use Moose;

extends 'HTML::FormFu::Element::Button';

after BUILD => sub {
    my $self = shift;

    $self->field_type('submit');

    return;
};

__PACKAGE__->meta->make_immutable;

1;

__END__

=head1 NAME

HTML::FormFu::Element::Submit - Submit button form field

=head1 SYNOPSIS

    $element = $form->element( Submit => 'foo' );

=head1 DESCRIPTION

Submit button form field.

=head1 METHODS

=head1 SEE ALSO

Is a sub-class of, and inherits methods from 
L<HTML::FormFu::Element::Button>, 
L<HTML::FormFu::Role::Element::Input>, 
L<HTML::FormFu::Role::Element::Field>, 
L<HTML::FormFu::Element>

L<HTML::FormFu>

=head1 AUTHOR

Carl Franks, C<cfranks@cpan.org>

=head1 LICENSE

This library is free software, you can redistribute it and/or modify it under
the same terms as Perl itself.

=cut
